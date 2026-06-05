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
    mkdir -p /home/student/MAZE/entrance/left/up && \
    mkdir -p /home/student/MAZE/entrance/left/down/river/swim && \
    mkdir -p /home/student/MAZE/entrance/left/down/river/follow && \
    mkdir -p /home/student/MAZE/entrance/left/down/river/follow/cave && \
    mkdir -p /home/student/MAZE/entrance/left/down/river/follow/cave/treasure_room && \
    mkdir -p /home/student/MAZE/entrance/right/rope_swing/pool/surface && \
    mkdir -p /home/student/MAZE/entrance/right/rope_swing/pool/deeper && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/market && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/market/back_room
 
# ── Signs ─────────────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/sign.txt << 'SIGN'
=== ENTRANCE ===
 
You stand at the entrance of a dark maze.
Two tunnels stretch before you.
 
  left/    - A dimly lit passage. Cool air drifts out.
  right/   - A wider tunnel. A low rumbling echoes from within.
 
A stone tablet on the wall reads:
  "Five fragments of the password are hidden in the maze.
   Find them all to escape."
SIGN

#   left
 
RUN cat > /home/student/MAZE/entrance/left/sign.txt << 'SIGN'
=== LADDER ROOM ===
 
A small stone room with a wooden ladder in the centre.
Faint light filters down from above.
The sound of rushing water rises from below.
 
  up/    - The ladder leads up towards the light.
  down/  - The ladder descends into darkness.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/sign.txt << 'SIGN'
=== SURFACE ===
 
You climb out into the open air.
A grey sky stretches overhead. There is nothing here but
an old scarecrow and an empty field.
 
You feel watched.
 
  ../    - Climb back down.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/scarecrow.txt << 'SIGN'
A battered scarecrow. Sewn into its chest is a scrap of paper.
The paper reads:
 
  PASSWORD FRAGMENT 1:  "dragon"
 
  ../    - Head back down.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/sign.txt << 'SIGN'
=== UNDERGROUND RIVER ===
 
The air is cold and damp. A fast-moving river cuts through
the cave floor, glowing faintly blue.
 
  river/    - Approach the river.
  ../       - Climb back up.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/sign.txt << 'SIGN'
=== THE RIVER BANK ===
 
The river roars past. The current looks strong.
A narrow path follows the river deeper into the cave.
 
  swim/     - Jump in and swim across.
  follow/   - Follow the path along the river bank.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/swim/sign.txt << 'SIGN'
=== SWEPT AWAY ===
 
You leap into the river. The current is overwhelming.
You are swept downstream and deposited, soaking wet,
back at the entrance of the maze.
 
  ../../../../    - Back to the entrance.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/sign.txt << 'SIGN'
=== RIVER PATH ===
 
The path winds deeper into the cave. Strange glowing moss
lights the way. You notice scratches on the wall —
someone has been here before.
 
  cave/    - Continue into the cave.
  ../      - Turn back.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/cave/sign.txt << 'SIGN'
=== THE DEEP CAVE ===
 
The cave opens into a larger chamber. Stalactites hang
from the ceiling. In the far wall you can see a heavy door.
 
  treasure_room/    - Try the heavy door.
  ../               - Head back.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/cave/note.txt << 'SIGN'
A crumpled note on the cave floor. It reads:
 
  PASSWORD FRAGMENT 2:  "slays"
 
  (scrawled underneath)
  "The treasure room door is unlocked. I already took the gold.
   Sorry."
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/cave/treasure_room/sign.txt << 'SIGN'
=== TREASURE ROOM ===
 
The room is empty. Whoever left the note was not lying.
All that remains is a wooden chest with a broken lock.
Inside the chest is a small scroll.
 
  ../    - Leave the treasure room.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/cave/treasure_room/scroll.txt << 'SIGN'
The scroll reads:
 
  PASSWORD FRAGMENT 3:  "the"
 
  Beneath the text is a rough map. It seems to point
  towards the market on the other side of the chasm.
SIGN
 
#   right
 
RUN cat > /home/student/MAZE/entrance/right/sign.txt << 'SIGN'
=== THE CHASM ROOM ===
 
A vast room with a deep chasm splitting the floor in two.
On the far side you can see a door leading to a market.
The rumbling is louder here — something stirs below.
 
  rope_swing/      - A thick rope hangs above the chasm. Risky.
  narrow_cliff/    - A narrow ledge runs along the wall. Slow but steady.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/sign.txt << 'SIGN'
=== ROPE SWING ===
 
You grab the rope and launch yourself across the chasm.
Halfway across, the rope snaps.
 
You plummet into the darkness below and land with a
tremendous splash in an underground pool.
 
  pool/    - Look around the pool.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/sign.txt << 'SIGN'
=== THE UNDERGROUND POOL ===
 
The pool is enormous. The water is icy cold.
The river from the other side of the maze feeds into it here.
Two options present themselves.
 
  surface/    - Swim to a rocky ledge and climb out.
  deeper/     - Dive deeper into the pool.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/surface/sign.txt << 'SIGN'
=== ROCKY LEDGE ===
 
You haul yourself out of the water. A narrow tunnel
leads upward — it comes out near the entrance of the maze.
 
Wedged in a crack in the rock is something shiny.
 
  ../../../../../    - Back to the entrance.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/surface/coin.txt << 'SIGN'
A gold coin with writing engraved on its face:
 
  PASSWORD FRAGMENT 4:  "knight"
 
  On the back: "The merchant knows the final word."
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/deeper/sign.txt << 'SIGN'
=== THE DEEP ===
 
You dive down. The water gets darker and colder.
There is nothing here but an old boot and some gravel.
 
You surface, disappointed.
 
  ../    - Back to the pool.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/sign.txt << 'SIGN'
=== NARROW CLIFF ===
 
You press yourself against the wall and inch along the ledge.
It takes a while but you make it across safely.
The door on the other side opens into a bustling underground market.
 
  market/    - Enter the market.
  ../        - Shimmy back across.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/market/sign.txt << 'SIGN'
=== THE UNDERGROUND MARKET ===
 
Torches line the walls. Strange vendors sell stranger things.
In the corner, a hooded merchant sits behind a cluttered stall.
 
  back_room/    - Slip through a curtain behind the merchant stall.
  ../           - Leave the market.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/market/back_room/sign.txt << 'SIGN'
=== BACK ROOM ===
 
A small dusty room behind the stall. Crates are stacked
to the ceiling. On a crate in the middle of the room
sits a sealed envelope addressed to "the brave adventurer."
 
  ../    - Return to the market.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/market/back_room/envelope.txt << 'SIGN'
The envelope is unsealed. Inside is a single card:
 
  PASSWORD FRAGMENT 5:  "darkness"
 
  "You have found all five fragments. The password is:
   the five words in the order you found them.
   Good luck."
SIGN
 
# ── Ownership ─────────────────────────────────────────────────────────────────
RUN chown -R student:student /home/student/MAZE
 
RUN chown wizard:heroes /home/student/MAZE/entrance/sign.txt && \
    chown wizard:heroes /home/student/MAZE/entrance/right/sign.txt && \
    chown wizard:heroes /home/student/MAZE/entrance/right/rope_swing/sign.txt && \
    chown wizard:heroes /home/student/MAZE/entrance/right/rope_swing/pool/deeper/sign.txt
 
RUN chown wizard:heroes /home/student/MAZE/entrance/left/sign.txt && \
    chown wizard:heroes /home/student/MAZE/entrance/left/down/sign.txt && \
    chown wizard:heroes /home/student/MAZE/entrance/left/down/river/follow/cave/sign.txt && \
    chown wizard:heroes /home/student/MAZE/entrance/left/down/river/follow/cave/treasure_room/sign.txt
 
RUN chown wizard:heroes /home/student/MAZE/entrance/right/rope_swing/pool/sign.txt && \
    chown wizard:heroes /home/student/MAZE/entrance/right/rope_swing/pool/surface/sign.txt
 
RUN chown wizard:heroes /home/student/MAZE/entrance/right/narrow_cliff/market/sign.txt && \
    chown wizard:heroes /home/student/MAZE/entrance/right/narrow_cliff/market/back_room/sign.txt && \
    chown wizard:heroes /home/student/MAZE/entrance/right/narrow_cliff/market/back_room/envelope.txt

RUN chown -R student:student /home/student
 
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

USER student
WORKDIR /home/student

CMD ["/startup.sh"]