FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    vim \
    less \
    tree \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create users
RUN useradd -m -s /bin/bash student
RUN useradd -m -s /bin/bash goblin
RUN useradd -m -s /bin/bash wizard
RUN useradd -m -s /bin/bash troll

RUN groupadd heroes
RUN groupadd monsters

RUN usermod -aG monsters goblin
RUN usermod -aG monsters troll
RUN usermod -aG heroes wizard

RUN echo "Welcome! Try: ls, pwd, cd, mkdir, cat, echo, vim" > /home/student/README.txt 


# ── Maze structure ────────────────────────────────────────────────────────────
RUN mkdir -p /home/student/MAZE/entrance && \
    mkdir -p /home/student/MAZE/entrance/left/up/field/barn/.trapdoor/box && \
    mkdir -p /home/student/MAZE/entrance/left/down/river/downstream/.secret_passage && \
    mkdir -p /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove/.portal_frame && \
    mkdir -p /home/student/MAZE/entrance/right/rope_swing/lake/surface && \
    mkdir -p /home/student/MAZE/entrance/right/rope_swing/lake/deeper/ruins && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/treasure_room && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/armory && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/cavern/shrine && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/locked_door
 
# ── Signs ─────────────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/sign.txt << SIGN
=== ENTRANCE ===
 
You stand at the entrance of a dark underground maze.
Two tunnels stretch before you.
 
  left/    - A dimly lit passage. Cool air drifts out.
  right/   - A wider tunnel. A low rumbling echoes from within.
 
A stone tablet on the wall reads:
  "Five fragments of the password are hidden in the maze.
   Find them all to claim the treasure."
SIGN
 
# ── LEFT PATH ────────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/left/sign.txt << SIGN
=== LADDER ROOM ===
 
A small stone room with a wooden ladder in the centre.
Faint light filters down from above.
The sound of rushing water rises from below.
 
  up/    - The ladder leads up towards the light.
  down/  - The ladder descends into darkness.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/sign.txt << SIGN
=== SURFACE ===
 
You climb out into the open air.
A grey sky stretches overhead.
An open field stretches in front of you.
In the distance you can see a barn.
 
  field/    - Walk into the field.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/field/sign.txt << SIGN
=== THE FIELD ===
 
The field is overgrown and quiet.
A battered scarecrow stands in the middle.
To the east is a rotting barn.
 
Sewn into the scarecrows chest is a scrap of paper.
 
  barn/    - Head to the barn.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/field/scarecrow.txt << SIGN
=== SCARECROW ===

A battered scarecrow stares blankly ahead.
It seems to be pointing towards the barn.
Someone left a note on the scarecrow, but the rain
and dirt has made it unreadable.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/field/barn/sign.txt << SIGN
=== THE BARN ===
 
The barn doors hang open. Inside is dark and musty.
Rusted farm tools line the walls.
A crow watches you from the rafters.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/field/barn/crow_note.txt << SIGN
Tied to the crows leg is a tiny note.
You convince it to hold still long enough to read it.
Most of the note has been ripped up, but you can make out one part of the password.
 
  "_ _ A _ _"
SIGN

RUN cat > /home/student/MAZE/entrance/left/up/field/barn/.trapdoor/sign.txt << SIGN
=== THE TRAPDOOR ===
 
After sweeping aside some hay and dirt you find the secret trapdoor.
You open it and climb down into a small dirt room with a wooden box.
inside the box is two notes.
SIGN

RUN cat > /home/student/MAZE/entrance/left/up/field/barn/.trapdoor/box/sign.txt << SIGN
=== THE BOX ===
 
Two notes sit side by side, each giving different directions.
It seems one was written by the wizard and the other by some imposter.
Which one should you trust?
SIGN

RUN cat > /home/student/MAZE/entrance/left/up/field/barn/.trapdoor/box/note1.txt << SIGN
=== NOTE 1 ===
 
So you found your way here. 
The maze holds even more secrets and treasure than you have already found. 
Those who know where to look will find it. 

I have hidden something in the mushroom grove.
SIGN

RUN cat > /home/student/MAZE/entrance/left/up/field/barn/.trapdoor/box/note2.txt << SIGN
=== NOTE 2 ===
 
So you found your way here. 
The maze holds even more secrets and treasure than you have already found. 
Those who know where to look will find it. 

There is a secret passage in the underground river.
You will need to hold your breathe to find it.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/sign.txt << SIGN
=== UNDERGROUND RIVER ===
 
The air is cold and damp. A fast-moving river cuts through
the cave floor, glowing faintly blue.
 
  river/    - Approach the river.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/sign.txt << SIGN
=== THE RIVER BANK ===
 
The river roars past. The current looks strong.
A narrow path follows the river up stream.
 
  upstream/      - Follow the narrow path upstream.
  downstream/    - Jump in the river and swim downstream.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/upstream/sign.txt << SIGN
=== Upstream ===
 
You follow the river upstream. 
The cave narrows and the sound of the water grows louder. 
Around a bend the path opens into a glowing underground mushroom grove.

mushroom_grove/   - Enter the mushroom grove
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove/sign.txt << SIGN
=== MUSHROOM GROVE ===
 
Enormous glowing mushrooms fill the cave.
The air smells sweet and strange.
You feel slightly dizzy but otherwise fine.
 
Sitting on the largest mushroom is a small box.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove/box.txt << SIGN
A small wooden box, unlocked.
Inside is a crystal ball.
Upon touching it it begins to glow.
Looking deeper into it you see:
 
  The first number of the password is 4.
SIGN

RUN cat > /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove/.portal_frame/sign.txt << SIGN
=== PORTAL FRAME===

Hidden behind a thick clump of mushrooms is a large circle of stones.
It looks to be a portal frame. 
The stones sit silently, the portal is deactivated.
Next to the portal is another pair of notes.  
SIGN

RUN cat > /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove/.portal_frame/note1.txt << SIGN
=== NOTE 1 ===

This portal leads to my vault, but the magic has faded. 
To reopen it you will need the glyph inscribed on my old helmet. 
I lost it down the chasm once while I was trying to take the rope swing.
SIGN

RUN cat > /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove/.portal_frame/note2.txt << SIGN
=== NOTE 2 ===

This portal leads to my vault, but the magic has faded. 
To reopen it you will need the glyph inscribed on my old knife. 
But someone must have stollen it from me while I was sleeping.
It must have been the goblin.
SIGN

RUN cat > /home/student/MAZE/entrance/left/down/river/downstream/sign.txt << SIGN
=== DOWNSTREAM ===
 
You jump into the river and let the current carry you downstream. 
The further you go the lower the cave ceiling gets, forcing you to swim closer to the surface. 
Eventually the gap between the water and the rock above closes entirely. 
There is no way forward. You must swim back against the current.
SIGN

RUN cat > /home/student/MAZE/entrance/left/down/river/downstream/.secret_passage/sign.txt << SIGN
=== SECRET PASSAGE ===
 
You take a deep breath and dive under the rock face as the cave ceiling meets the water
Eventually, you see a faint glow above you, there is an air pocket.
You swim up to catch your breath.
The walls are slick with a luminous moss that casts everything in pale green light
Someone has carved a message into the rock.
SIGN

RUN cat > /home/student/MAZE/entrance/left/down/river/downstream/.secret_passage/message.txt << SIGN
 
" HA HA!!!
  I made you go the wrong way
  - The Troll"
SIGN
 
# ── RIGHT PATH ───────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/right/sign.txt << SIGN
=== THE CHASM ROOM ===
 
A vast room with a deep chasm splitting the floor in two.
On the far side you can see a door.
The rumbling seems to be coming from the chasm.
How will you cross?
 
  rope_swing/      - A thick rope hangs above the chasm. Risky.
  narrow_cliff/    - A narrow ledge runs along the wall. Slow but steady.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/sign.txt << SIGN
=== ROPE SWING ===
 
You grab the rope and launch yourself across the chasm.
Halfway across the rope snaps.
 
You plummet into darkness and land with a splash
in an underground lake far below.
 
  lake/    - Look around the lake.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/lake/sign.txt << SIGN
=== THE UNDERGROUND LAKE ===
 
The lake is enormous. The water is icy cold. 
A thundering waterfall pours from a crack in the 
cave ceiling far above, its roar echoing off the walls.
 
  surface/    - Swim to a rocky ledge and climb out.
  deeper/     - Dive deeper into the lake.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/lake/surface/sign.txt << SIGN
=== ROCKY LEDGE ===
 
You haul yourself out of the water.
Wedged in a crack in the cave wall is something shiny.
 
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/lake/surface/coin.txt << SIGN
A gold coin with a strange symbol engraved on its face.
It seems to be one part of the password.
 
  SYMBOL:  "#"
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/lake/deeper/sign.txt << SIGN
=== THE DEEP ===
 
You dive down. The water gets darker and colder.
Through the murk you can make out the outline of old ruins.
 
  ruins/    - Swim towards the ruins.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/lake/deeper/ruins/sign.txt << SIGN
=== UNDERWATER RUINS ===
 
The ruins of a small stone structure sit on the lake floor.
A stone door hangs open.
Inside is nothing but a stone table and some rusty armor.
Your lungs are burning. You need to surface soon.
SIGN

RUN cat > /home/student/MAZE/entrance/right/rope_swing/lake/deeper/ruins/.helmet.txt << SIGN
=== OLD HELMET ===
 
In the old underwater ruins you dig through the silt and mud and find the old helmet.
You rub off the dirt and rust, but can not see anything that looks like a magic glyph.
It is just a regular helmet.
It seems you were tricked by the troll.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/sign.txt << SIGN
=== NARROW CLIFF ===
 
You press yourself against the wall and inch along the ledge.
It takes a while but you make it across.
The passage opens up on the other side.
A cold breeze comes from a large cavern ahead.
Just before the cavern is a small burrow in the wall.
 
  goblin_den/    - Squeeze into the burrow.
  cavern/        - Head towards the cold breeze.
SIGN
 
# ── GOBLIN DEN ───────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/sign.txt << SIGN
=== GOBLIN DEN ===
 
You squeeze through the small goblin sized hole and enter the den.
It is clearly a home of sorts, though a very messy one.
Scraps of food, broken furniture and stolen trinkets
cover every surface. An empty firepit smoulders in the centre.
The goblin does not seem to be home right now.
 
Doorways lead to what looks like a treasury and an armory.
 
  treasure_room/    - Enter the goblin treasury.
  armory/           - Enter the armory.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/note.txt << SIGN
A scrap of parchment pinned to the wall with a knife.
It appears to be a list written in clumsy handwriting:
 
  THINGS I HAVE COLLECTED:
  - 3 swords (two broken)
  - 1 helmet (dented)
  - lots of coins (not enough)
  - a scroll with some words on it
  - some bones (decorative)
  - a shiny rock (very good)
 
  TO DO:
  - get more stuff
  - find the rest of the password
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/treasure_room/sign.txt << SIGN
=== GOBLIN TREASURY ===
 
A small side cave packed with the goblins collection.
Piles of coins, trinkets, and stolen goods cover the floor.
Most of it is junk but there is a lot of it.
A locked chest sits in the corner. The key is nowhere to be found.
Wedged under the chest to stop it wobbling is a folded note.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/treasure_room/note.txt << SIGN
The note wedged under the chest reads:
 
  "dear goblin,
   sorry i took a few of your coins
   ill give it back when we figure out what the password is
   i only know the last number is 6
   - the other goblin"
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/armory/sign.txt << SIGN
=== GOBLIN ARMORY ===
 
Calling it an armory is generous.
A collection of dull knives, bent spears, and cracked shields
are stacked on top of wooden crates in rough piles.
None of the weapons look sharp enough to cut bread.
A knife near the front has something tied to its handle.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/armory/knife_note.txt << SIGN
A scrap of cloth tied to the handle of a bent knife.
Written on it in charcoal:
 
  "THIS IS MY BEST KNIFE"
 
  It is very clearly not a good knife.
SIGN

RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/armory/.hidden_knife.txt << SIGN
=== HIDDEN KNIFE ===

After closer inspection of the armory you see a faint glowing coming from behind one of the crates.
Wedged between the crate and the wall is a knife unlike the others.
Its blade shimmers with a cold blue light.
Inscribed on the knife is a glyph.

  GLYPH: "~[*]~"
SIGN
 
# ── CAVERN ───────────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/cavern/sign.txt << SIGN
=== THE GREAT CAVERN ===
 
You step through the opening and catch your breathe.
The cavern is enormous, the ceiling disappears into darkness far above.
The sound of dripping water echoes all around.
 
Across the cavern floor, a faint warm light glows in the distance.
As your eyes adjust you can make out the shape of a shrine.
To one side a tunnel opening is visible.
 
  shrine/    - Cross the cavern towards the light.
  tunnel/    - Enter the tunnel.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/cavern/shrine/sign.txt << SIGN
=== THE SHRINE ===
 
A stone shrine sits in a pool of warm golden light
that seems to have no obvious source.
Offerings of flowers, coins and candles are arranged neatly.
The air here feels different, still and quiet.
 
A leather-bound book sits open on the altar.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/cavern/shrine/book.txt << SIGN
The book is open to a page near the end.
Most of it is written in a language you cannot read.
But a scribbled note on the back page is written in plain english.
The book is very old and worn, the page is faded and scratched.
All you can make out is:
 
  "I found all five fragments.
   The password is _ 5 _ _ _"
 
  Below that, a pressed flower and five small ink marks.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/sign.txt << SIGN
=== TUNNEL ===
 
A massive stone door blocks the entrance of the tunnel. 
At its centre is a rusted iron mechanism with slots for entering a combination. 
It will not budge without the correct password.

  To unlock the door you will need to run enter_password with the password as an argument.
  Ex: ./enter_password ABC12
 
  locked_door/  - Attempt to open the door.
SIGN

# ── Ownership ────────────────────────────────────────────────────────────────
RUN chown -R student:student /home/student/MAZE
RUN find /home/student/MAZE -name "*.txt" -exec chown wizard:heroes {} \;

RUN chown goblin:monsters /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/note.txt
RUN chown goblin:monsters /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/treasure_room/note.txt
RUN chown goblin:monsters /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/armory/knife_note.txt

RUN chown wizard:heroes /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove/box.txt

RUN chown troll:monsters /home/student/MAZE/entrance/left/up/field/barn/.trapdoor/box/note2.txt
RUN chown troll:monsters /home/student/MAZE/entrance/left/down/river/downstream/.secret_passage/message.txt
RUN chown troll:monsters /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove/.portal_frame/note1.txt
RUN chown troll:monsters /home/student/MAZE/entrance/right/rope_swing/lake/deeper/ruins/.helmet.txt

# ── Password ────────────────────────────────────────────────────────────────
# locked door
COPY scripts/enter_password /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/enter_password
RUN chown wizard:heroes /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/enter_password
RUN chmod 4711 /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/enter_password

RUN chmod 000 /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/locked_door
RUN chown wizard:heroes /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/locked_door

#portal
COPY scripts/enter_glyph /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove/.portal_frame/enter_glyph
RUN chown wizard:heroes /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove/.portal_frame/enter_glyph
RUN chmod 4711 /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove/.portal_frame/enter_glyph
 

# ── Docker ────────────────────────────────────────────────────────────────
COPY scripts/startup.sh /startup.sh
RUN chmod +x /startup.sh

USER student
WORKDIR /home/student

CMD ["/startup.sh"]