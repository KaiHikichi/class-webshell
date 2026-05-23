const crypto = require('crypto');
const express = require('express');
const http = require('http');
const WebSocket = require('ws');
const pty = require('node-pty');
const path = require('path');
const fs = require('fs');

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

const STUDENTS_FILE = path.join(__dirname, 'students.json');
tokens = new Map();

app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());



//routes

app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  const students = JSON.parse(fs.readFileSync(STUDENTS_FILE, 'utf8'));
  const student = students.find(s => s.username === username && s.password === password);
  if (!student) return res.status(401).json({ error: 'Invalid username or password' });

  const token = crypto.randomBytes(32).toString('hex')
  tokens.set(token, { username: 'alice', role: 'student', expires: Date.now() + 8 * 60 * 60 * 1000 });
  res.json({ token, username });
});

function validateToken(token) {
  const session = tokens.get(token)  
  
  if (!session) return null       
  
  if (Date.now() > session.expires) {
    tokens.delete(token)          
    return null
  }
  
  return session                    
}

wss.on('connection', (ws, req) => {
  const url = new URL(req.url, 'http://x');
  const username = url.searchParams.get('username');
  const token = url.searchParams.get('token');

  // check token is valid
  const session = validateToken(token)       
  if (!session) {
    ws.close() 
    return
  }

  const shell = pty.spawn('docker', [
    'run', '--rm', '-it',
    '--name', `student-${username}`,
    '--memory', '128m',
    '--cpus', '0.5',
    '--pids-limit', '50',
    '--security-opt=no-new-privileges',
    '--cap-drop', 'ALL',
    '--mount', `type=volume,source=student-${username},target=/home/student`,
    'classroom-student'
  ], {
    name: 'xterm-color',
    cols: 80, rows: 24,
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
