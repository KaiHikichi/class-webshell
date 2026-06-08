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

RUN groupadd heroes
RUN groupadd monsters

RUN usermod -aG monsters goblin
RUN usermod -aG heroes wizard

RUN echo "Welcome! Try: ls, pwd, cd, mkdir, cat, echo, vim" > /home/student/README.txt 


# ── Maze structure ────────────────────────────────────────────────────────────
RUN mkdir -p /home/student/MAZE/entrance && \
    mkdir -p /home/student/MAZE/entrance/left/up/field/barn && \
    mkdir -p /home/student/MAZE/entrance/left/down/river/downstream && \
    mkdir -p /home/student/MAZE/entrance/left/down/river/upstream/mushroom_grove && \
    mkdir -p /home/student/MAZE/entrance/right/rope_swing/pool/surface && \
    mkdir -p /home/student/MAZE/entrance/right/rope_swing/pool/deeper/ruins && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/treasure_room && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/armory && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/cavern/shrine && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/locked_door
 
# ── Signs ─────────────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/sign.txt << SIGN
=== ENTRANCE ===
 
You stand at the entrance of a dark maze.
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
A battered scarecrow stares blankly ahead.
It seems to be pointing towards the barn.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/field/barn/sign.txt << SIGN
=== THE BARN ===
 
The barn doors hang open. Inside it is dark and musty.
Rusted farm tools line the walls.
A crow watches you from the rafters.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/field/barn/crow_note.txt << SIGN
Tied to the crows leg is a tiny note.
You convince it to hold still long enough to read it.
Most of the note has been ripped but you can make out one part of the password.
 
  "_ _ A _ _"
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
 
You follow the river upstream and come across an underground mushroom grove.

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
Looking deeper into you see:
 
  The first number of the password is 4.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/downstream/sign.txt << SIGN
=== DOWNSTREAM ===
 
You jump in the river and swim downstream.
The further you go the lower the cave ceiling gets.
Eventually there is not enough room to breath, you will need to fight against the current and turn back.
SIGN
 
# ── RIGHT PATH ───────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/right/sign.txt << SIGN
=== THE CHASM ROOM ===
 
A vast room with a deep chasm splitting the floor in two.
On the far side you can see a door.
The rumbling is louder here.
How will you cross the chasm?
 
  rope_swing/      - A thick rope hangs above the chasm. Risky.
  narrow_cliff/    - A narrow ledge runs along the wall. Slow but steady.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/sign.txt << SIGN
=== ROPE SWING ===
 
You grab the rope and launch yourself across the chasm.
Halfway across the rope snaps.
 
You plummet into darkness and land with a splash
in an underground lake far below.
 
  pool/    - Look around the pool.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/sign.txt << SIGN
=== THE UNDERGROUND POOL ===
 
The pool is enormous. The water is icy cold.
A jet of water shoots out from the cave wall feeding the river.
 
  surface/    - Swim to a rocky ledge and climb out.
  deeper/     - Dive deeper into the pool.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/surface/sign.txt << SIGN
=== ROCKY LEDGE ===
 
You haul yourself out of the water.
A narrow tunnel leads upward toward the maze entrance.
Wedged in a crack in the rock is something shiny.
 
  tunnel/    - Crawl through the tunnel back to the entrance.
  ../        - Swim back.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/surface/coin.txt << SIGN
A gold coin with a strange symbol engraved on its face.
Could this be part of the password?
 
  SYMBOL:  "#"
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/deeper/sign.txt << SIGN
=== THE DEEP ===
 
You dive down. The water gets darker and colder.
Through the murk you can make out the outline of old ruins.
 
  ruins/    - Swim towards the ruins.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/deeper/ruins/sign.txt << SIGN
=== UNDERWATER RUINS ===
 
The ruins of a small building sit on the pool floor.
A stone door hangs open.
Inside is nothing but a stone table and an old helmet.
Your lungs are burning. You need to surface soon.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/sign.txt << SIGN
=== NARROW CLIFF ===
 
You press yourself against the wall and inch along the ledge.
It takes a while but you make it across.
The passage opens up on the other side.
A a cold breeze comes from a large cavern ahead.
Just before the cavern is a small burrow in the wall.
 
  goblin_den/    - Checkout the burrow.
  cavern/        - Head towards the cold breeze.
SIGN
 
# ── GOBLIN DEN ───────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/sign.txt << SIGN
=== GOBLIN DEN ===
 
You follow the noise into a large cramped cave.
It is clearly a home of sorts, if a messy one.
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
  - fix the chair
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/treasure_room/sign.txt << SIGN
=== GOBLIN TREASURY ===
 
A small side cave packed with the goblins collection.
Piles of coins, trinkets, and stolen goods cover the floor.
Most of it is junk but there is a lot of it.
A locked chest sits in the corner. The key is nowhere to be found.
Wedged under the chest to stop it wobbling is a folded note.
 
  ../    - Back to the den.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/treasure_room/note.txt << SIGN
The note wedged under the chest reads:
 
  "dear goblin,
   sorry i took 3 of your coins
   ill give it back when we figure out what the password is
   I only know the last number is 6
   - the other goblin"
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/armory/sign.txt << SIGN
=== GOBLIN ARMORY ===
 
Calling it an armory is generous.
A collection of dull knives, bent spears, and cracked shields
leans against the cave wall in rough piles.
None of the weapons look sharp enough to cut bread.
A spear near the back has something tied to its handle.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/armory/spear_note.txt << SIGN
A scrap of cloth tied to the handle of a bent spear.
Written on it in charcoal:
 
  "THIS IS MY BEST SPEAR"
 
  It is very clearly not a good spear.
SIGN
 
# ── CAVERN ───────────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/cavern/sign.txt << SIGN
=== THE GREAT CAVERN ===
 
You step through the opening and catch your breath.
The cavern is enormous, the ceiling disappears into darkness far above.
The sound of dripping water echoes all around.
 
Across the cavern floor, a faint warm light glows in the distance.
As your eyes adjust you can make out the shape of a shrine.
To one side a tunnel opening is visible.
 
  shrine/    - Cross the cavern towards the light.
  tunnel/    - Enter tunnel.
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
But the last entry is in plain english.
The book seems very old and worn the page is very faded and scratched.
All you can make out is:
 
  "I found all five fragments.
   The password is .5...."
 
  Below that, a pressed flower and five small ink marks.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/sign.txt << SIGN
=== TUNNEL ===
 
A wide tunnel opening in the cavern wall.
Or at least it was wide once.
It is now blocked by a huge stone door with a rusty mechanism at the centre for you to enter the password.
You will not be allowed through until you have entered the password.
 
  /locked_door  - Attempt to open the door.
SIGN

# ── Ownership ────────────────────────────────────────────────────────────────
RUN chown -R student:student /home/student/MAZE
RUN find /home/student/MAZE -name "*.txt" -exec chown wizard:heroes {} \;

# ── Password ────────────────────────────────────────────────────────────────
COPY scripts/enter_password /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/enter_password
RUN chown wizard:heroes /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/enter_password
RUN chmod 4711 /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/enter_password

RUN chmod 000 /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/locked_door
RUN chown wizard:heroes /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/locked_door
 


COPY scripts/startup.sh /startup.sh
RUN chmod +x /startup.sh

USER student
WORKDIR /home/student

CMD ["/startup.sh"]