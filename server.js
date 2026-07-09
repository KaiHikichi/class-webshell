const crypto = require('crypto');
const express = require('express');
const http = require('http');
const WebSocket = require('ws');
const pty = require('node-pty');
const path = require('path');
const fs = require('fs');
const { execFile } = require('child_process');
require('dotenv').config();


const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

const USERS_FILE = path.join(__dirname, 'userManagement/users.json');
const GUESTS_FILE = path.join(__dirname, 'userManagement/guests.json');
const class_password = process.env.class_password;
const admin_password = process.env.admin_password;
const NAME_PATTERN = /^[a-zA-Z0-9][a-zA-Z0-9_.-]*$/;
tokens = new Map();

app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());



//routes======================================================================================

app.post('/api/login', (req, res) => {
	let { username, password } = req.body;

	//check if new guest account is being created
	if (username == 'ScienceAliveGuest' && password == class_password){
		username = addGuest();
	}
	
	let role = verifyLogin(username, password);
	if(role == null){
		//reject user
		role = null;
		return res.status(401).json({ error: 'Invalid username or password' });
	}

	const token = crypto.randomBytes(32).toString('hex');
	tokens.set(token, { username: username, role: role, expires: Date.now() + 8 * 60 * 60 * 1000 });
	return res.json({ token, username, role });
});

app.post('/api/sign-up', (req, res) => {
	let { username, password } = req.body;
	const users = JSON.parse(fs.readFileSync(USERS_FILE, 'utf8'));
	
	//check if username already exists
	let user = users.users.find(s => s.username === username);
	if(user){
		return res.status(401).json({ error: 'User already exists. Please pick a new username.' });
	}

	//if user does not exist check if password matches 
	if(password != class_password){
		return res.status(401).json({ error: 'Incorrect password.' });
	}

	//if user does not already exists and password matches add the user to json
	const newUser = {"username": username};
	users.users.push(newUser);

	fs.writeFileSync(USERS_FILE, JSON.stringify(users, null, 2), (err) => {
		if (err) throw err;
	});
	return res.json({ username });
});

app.post('/api/isAdmin', (req, res) => {
	let { username, token } = req.body;

	//validate token
	if (validateToken(token) == null){
		return res.status(401).json({ error: 'Invalid token.' });
	}

	//check admin
	const info = tokens.get(token)  
	if(info.role == 'admin'){
		return res.json({ username, token });
	}
	else{
		return res.status(401).json({ error: 'Non admin token.' });
	}
});

app.post('/api/populateAdmin', (req, res) => {
	let { username, token } = req.body;

	if (validateToken(token) == null){
		return res.status(401).json({ error: 'Invalid token.' });
	}

	const info = tokens.get(token)  
	if(info.role != 'admin'){
		return res.status(401).json({ error: 'Non admin token.' });
	}

	execFile('docker', ['volume', 'ls', '--format', '{{.Name}}'], (err, volOut, volErr) => {
		if (err) {
			console.error('docker volume ls failed:', volErr || err.message);
			return res.status(500).json({ error: 'Failed to list volumes.' });
		}

		execFile('docker', ['ps', '--format', '{{.Names}}'], (err2, psOut, psErr) => {
			if (err2) {
				console.error('docker ps failed:', psErr || err2.message);
				return res.status(500).json({ error: 'Failed to list containers.' });
			}

			const runningNames = new Set(psOut.split('\n').map(s => s.trim()).filter(Boolean));
			const volumes = volOut.split('\n')
				.map(s => s.trim())
				.filter(Boolean)
				.map(name => ({ name, active: runningNames.has(name) }));

			return res.json({ volumes });
		});
	});
});

app.post('/api/endSession', (req, res) => {
	let { username, token, target } = req.body;

	if (validateToken(token) == null){
		return res.status(401).json({ error: 'Invalid token.' });
	}
	const info = tokens.get(token);
	if(info.role != 'admin'){
		return res.status(401).json({ error: 'Non admin token.' });
	}
	if (!target || !NAME_PATTERN.test(target)) {
		return res.status(400).json({ error: 'Invalid target name.' });
	}

	execFile('docker', ['kill', target], (err, stdout, stderr) => {
		if (err) {
			console.error('docker kill failed:', stderr || err.message);
			return res.status(500).json({ error: 'Failed to end session.' });
		}
		return res.json({ success: true });
	});
});

app.post('/api/deleteVolume', (req, res) => {
	let { username, token, target } = req.body;

	if (validateToken(token) == null){
		return res.status(401).json({ error: 'Invalid token.' });
	}
	const info = tokens.get(token);
	if(info.role != 'admin'){
		return res.status(401).json({ error: 'Non admin token.' });
	}
	if (!target || !NAME_PATTERN.test(target)) {
		return res.status(400).json({ error: 'Invalid target name.' });
	}

	execFile('docker', ['volume', 'rm', target], (err, stdout, stderr) => {
		if (err) {
			console.error('docker volume rm failed:', stderr || err.message);
			return res.status(500).json({ error: 'Failed to delete volume. It may still be in use.' });
		}

		//remove target from user files
		if (target === "ScienceAliveAdmin" || target === "ScienceAliveGuest") {
			//do nothing
		} else if (/^guest\d+$/.test(target)) {
			const guests = JSON.parse(fs.readFileSync(GUESTS_FILE, 'utf8'));
			let guestIndex = guests.guests.findIndex(s => s.username === target);
			if (guestIndex !== -1) {
				guests.guests.splice(guestIndex, 1);
				fs.writeFileSync(GUESTS_FILE, JSON.stringify(guests, null, 2), 'utf8');
			}
		} else {
			const users = JSON.parse(fs.readFileSync(USERS_FILE, 'utf8'));
			let userIndex = users.users.findIndex(s => s.username === target);
			if (userIndex !== -1) {
				users.users.splice(userIndex, 1);
				fs.writeFileSync(USERS_FILE, JSON.stringify(users, null, 2), 'utf8');
			}
		}

		//revoke any active session token(s) for target
		for (const [t, tokenInfo] of tokens.entries()) {
			if (tokenInfo.username === target) {
				tokens.delete(t);
			}
		}

		return res.json({ success: true });
	});
});

function validateToken(token) {
	const info = tokens.get(token)  
	
	if (!info){
		return null       
	}

	if (Date.now() > info.expires) {
		tokens.delete(token)          
		return null
	}
	
	return info                    
}

function verifyLogin(username, password){
	//check username exists
	const users = JSON.parse(fs.readFileSync(USERS_FILE, 'utf8'));
	const guests = JSON.parse(fs.readFileSync(GUESTS_FILE, 'utf8'));

	let guest = guests.guests.find(s => s.username === username);
	let user = users.users.find(s => s.username === username);

	if(!user && !guest){
		return null;
	}

	//verify password
	if(username == 'ScienceAliveAdmin'){
		return password == admin_password ? 'admin' : null;
	}
	else if(guest){
		return password == class_password ? 'guest' : null;
	}
	else{
		return password == class_password ? 'student' : null;
	}
}

//add new guest to GUEST_FILE and return guest username
function addGuest(){
	const guests = JSON.parse(fs.readFileSync(GUESTS_FILE, 'utf8'));

	//create new guest account
	let newID = 0;
	if(guests.guests.length == 0){
		newID = 0;
	}
	else{
		newID = guests.guests.at(-1).id + 1;
	}
	
	username = "guest" + newID;

	const newGuest = {"username": username, "id": newID};
	guests.guests.push(newGuest);

	fs.writeFileSync(GUESTS_FILE, JSON.stringify(guests, null, 2), (err) => {
		if (err) throw err;
	});
	return username;
}

wss.on('connection', (ws, req) => {
	const url = new URL(req.url, 'http://x');
	let username = url.searchParams.get('username');
	const token = url.searchParams.get('token');

	// check token is valid
	const info = validateToken(token)       
	if (!info) {
		ws.close() 
		return
	}

	const shell = pty.spawn('docker', [
		'run', '--rm', '-it',
		'--name', `${username}`,
		'--memory', '40m',
		'--cpus', '0.5',
		'--pids-limit', '50',
		'--security-opt=no-new-privileges',
		'--env', `USERNAME=${username}`,
		'--cap-drop', 'ALL',
		'--cap-add', 'CHOWN',
		'--mount', `type=volume,source=${username},target=/home/student`,
		'classroom-student'
	], {
		name: 'xterm-color',
		env: { ...process.env, TERM: 'xterm-256color' }
	});

	shell.onData((data) => {
		if (ws.readyState === WebSocket.OPEN)
			ws.send(JSON.stringify({ type: 'output', data }));
	});

	shell.onExit(({ exitCode }) => {
		if (ws.readyState === WebSocket.OPEN) {
			ws.send(JSON.stringify({ type: 'exit', exitCode }));
			ws.close();
		}
	});

	ws.on('message', (message) => {
		try {
			const msg = JSON.parse(message);
			if (msg.type === 'input')  shell.write(msg.data);
			if (msg.type === 'resize') shell.resize(msg.cols, msg.rows);
		} catch (e) { console.error('Bad message:', e); }
	});

	ws.on('close', () => { shell.kill(); });
});


const PORT = process.env.PORT || 8888;
server.listen(PORT, () => {
	console.log(`Terminal server running at http://localhost:${PORT}`);
});
