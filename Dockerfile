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
    mkdir -p /home/student/MAZE/entrance/left/down/river/swim && \
    mkdir -p /home/student/MAZE/entrance/left/down/river/mushroom_grove && \
    mkdir -p /home/student/MAZE/entrance/left/down/river/follow/cave/treasure_room && \
    mkdir -p /home/student/MAZE/entrance/left/down/river/follow/cave/side_tunnel/shrine && \
    mkdir -p /home/student/MAZE/entrance/right/rope_swing/pool/surface/tunnel && \
    mkdir -p /home/student/MAZE/entrance/right/rope_swing/pool/deeper/ruins && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/treasure_room && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/armory && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/cavern/shrine && \
    mkdir -p /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel
 
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
In the distance you can see a barn and an old well.
 
  field/    - Walk into the field.
  ../       - Climb back down.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/field/sign.txt << SIGN
=== THE FIELD ===
 
The field is overgrown and quiet.
A battered scarecrow stands in the middle.
To the east is a rotting barn.
 
Sewn into the scarecrows chest is a scrap of paper.
 
  barn/    - Head to the barn.
  ../      - Head back to the ladder.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/field/scarecrow.txt << SIGN
A battered scarecrow stares blankly ahead.
Sewn into its chest is a scrap of paper.
The paper reads:
 
  PASSWORD FRAGMENT 1:  "dragon"
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/field/barn/sign.txt << SIGN
=== THE BARN ===
 
The barn doors hang open. Inside it is dark and musty.
Rusted farm tools line the walls.
A crow watches you from the rafters.
 
There is nothing useful here.
 
  ../    - Leave the barn.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/up/field/barn/crow_note.txt << SIGN
Tied to the crows leg is a tiny note.
You convince it to hold still long enough to read it.
 
  "Turn back. The well is dangerous."
 
  (The crow flies away before you can ask any questions.)
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/sign.txt << SIGN
=== UNDERGROUND RIVER ===
 
The air is cold and damp. A fast-moving river cuts through
the cave floor, glowing faintly blue.
 
  river/    - Approach the river.
  ../       - Climb back up.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/sign.txt << SIGN
=== THE RIVER BANK ===
 
The river roars past. The current looks strong.
A narrow path follows the river deeper into the cave.
To the left the path passes through a grove of glowing mushrooms.
 
  swim/           - Jump in and swim across.
  follow/         - Follow the path along the river bank.
  mushroom_grove/ - Step into the mushroom grove.
  ../             - Head back.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/swim/sign.txt << SIGN
=== SWEPT AWAY ===
 
You leap into the river. The current is overwhelming.
You are swept downstream and deposited, soaking wet,
back at the entrance of the maze.
 
  ../../../../    - Back to the entrance.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/mushroom_grove/sign.txt << SIGN
=== MUSHROOM GROVE ===
 
Enormous glowing mushrooms fill the cave.
The air smells sweet and strange.
You feel slightly dizzy but otherwise fine.
 
Sitting on the largest mushroom is a small box.
 
  ../    - Back to the river bank.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/mushroom_grove/box.txt << SIGN
A small wooden box, unlocked.
Inside is a folded piece of parchment.
 
  PASSWORD FRAGMENT 2:  "slays"
 
  Written in tiny letters at the bottom:
  "The treasure room is ahead. Someone got there first.
   Check carefully."
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/sign.txt << SIGN
=== RIVER PATH ===
 
The path winds deeper into the cave.
Strange glowing moss lights the way.
You notice scratches on the wall.
Someone has been here before.
 
  cave/    - Continue into the cave.
  ../      - Turn back.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/cave/sign.txt << SIGN
=== THE DEEP CAVE ===
 
The cave opens into a large chamber.
Stalactites hang from the ceiling.
In the far wall is a heavy door.
To the side a narrow tunnel leads somewhere darker.
 
  treasure_room/    - Try the heavy door.
  side_tunnel/      - Enter the narrow side tunnel.
  ../               - Head back.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/cave/note.txt << SIGN
A crumpled note on the cave floor reads:
 
  "I took the gold. The chest is empty. Sorry.
   - A fellow adventurer"
 
  Scrawled on the back:
  "Check the side tunnel if you want something useful."
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/cave/treasure_room/sign.txt << SIGN
=== TREASURE ROOM ===
 
The room is empty. The note was telling the truth.
All that remains is a wooden chest with a broken lock
and a small scroll tucked under the lid.
 
  ../    - Leave the treasure room.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/cave/treasure_room/scroll.txt << SIGN
The scroll reads:
 
  PASSWORD FRAGMENT 3:  "the"
 
  Below that, a rough map with an arrow pointing right.
  It is labelled: "market this way."
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/cave/side_tunnel/sign.txt << SIGN
=== SIDE TUNNEL ===
 
The tunnel is low and narrow. You have to crouch to walk.
After a short distance it opens into a small stone chamber.
Candles are burning. Someone was here recently.
 
  shrine/    - Look at the shrine.
  ../        - Head back to the cave.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/cave/side_tunnel/shrine/sign.txt << SIGN
=== THE SHRINE ===
 
A small shrine to an unknown god.
Offerings of coins and flowers are laid out neatly.
A leather journal sits open on a stone pedestal.
 
  ../    - Leave the shrine.
SIGN
 
RUN cat > /home/student/MAZE/entrance/left/down/river/follow/cave/side_tunnel/shrine/journal.txt << SIGN
The journal is open to the last written page.
 
  "Day 34. I have been lost in this maze for weeks.
   I found the four fragments but the fifth eludes me.
   The merchant in the market knows something.
   I am sure of it."
 
  Pressed between the last two pages is a small card.
 
  The card reads:  "Fragment 4 is at the bottom of the pool."
SIGN
 
# ── RIGHT PATH ───────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/right/sign.txt << SIGN
=== THE CHASM ROOM ===
 
A vast room with a deep chasm splitting the floor in two.
On the far side you can see a door.
The rumbling is louder here.
 
  rope_swing/      - A thick rope hangs above the chasm. Risky.
  narrow_cliff/    - A narrow ledge runs along the wall. Slow but steady.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/sign.txt << SIGN
=== ROPE SWING ===
 
You grab the rope and launch yourself across the chasm.
Halfway across the rope snaps.
 
You plummet into darkness and land with a splash
in an underground pool far below.
 
  pool/    - Look around the pool.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/sign.txt << SIGN
=== THE UNDERGROUND POOL ===
 
The pool is enormous. The water is icy cold.
The river from the other side feeds into it here.
 
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
A gold coin with writing engraved on its face:
 
  PASSWORD FRAGMENT 4:  "knight"
 
  On the back:  "The merchant knows the final word."
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/surface/tunnel/sign.txt << SIGN
=== TUNNEL ===
 
A low crawlspace that smells of damp earth.
After a few minutes of crawling you emerge
near the entrance of the maze.
 
  ../../../../../../    - Back to the entrance.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/deeper/sign.txt << SIGN
=== THE DEEP ===
 
You dive down. The water gets darker and colder.
Through the murk you can make out the outline of old ruins.
 
  ruins/    - Swim towards the ruins.
  ../       - Surface.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/deeper/ruins/sign.txt << SIGN
=== UNDERWATER RUINS ===
 
The ruins of a small building sit on the pool floor.
A stone door hangs open.
Inside is nothing but a stone table and an old helmet.
Your lungs are burning. You need to surface soon.
 
  ../    - Swim back up.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/rope_swing/pool/deeper/ruins/helmet.txt << SIGN
An old iron helmet sitting on a stone table.
Inside the helmet someone has scratched a message:
 
  "Turned back. Not worth it. Fragment is with the merchant."
 
  You are running out of air. Time to go.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/sign.txt << SIGN
=== NARROW CLIFF ===
 
You press yourself against the wall and inch along the ledge.
It takes a while but you make it across.
The passage opens up on the other side.
You can hear grunting and clanking from somewhere nearby,
and feel a cold breeze coming from a large opening ahead.
 
  goblin_den/    - Follow the noise.
  cavern/        - Head towards the cold breeze.
  ../            - Shimmy back across.
SIGN
 
# ── GOBLIN DEN ───────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/sign.txt << SIGN
=== GOBLIN DEN ===
 
You follow the noise into a large cramped cave.
It is clearly a home of sorts — if a messy one.
Scraps of food, broken furniture and stolen trinkets
cover every surface. A firepit smoulders in the centre.
The goblin does not seem to be home right now.
 
Doorways lead to what looks like a treasury and an armory.
 
  treasure_room/    - Enter the treasury.
  armory/           - Enter the armory.
  ../               - Leave the den.
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
   i took the key because you owe me three shiny rocks.
   you know where to find me.
   - the other goblin"
 
  On the back in different handwriting:
  "The merchant in the cavern market has the last password fragment.
   Do not tell the goblin."
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/armory/sign.txt << SIGN
=== GOBLIN ARMORY ===
 
Calling it an armory is generous.
A collection of dull knives, bent spears, and cracked shields
leans against the cave wall in rough piles.
None of the weapons look sharp enough to cut bread.
A spear near the back has something tied to its handle.
 
  ../    - Back to the den.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/goblin_den/armory/spear_note.txt << SIGN
A scrap of cloth tied to the handle of a bent spear.
Written on it in charcoal:
 
  "THIS IS MY BEST SPEAR"
 
  It is very clearly not a good spear.
  But tied around the shaft beneath the note
  is a small strip of paper:
 
  "The cavern to the west is worth exploring."
SIGN
 
# ── CAVERN ───────────────────────────────────────────────────────────────────
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/cavern/sign.txt << SIGN
=== THE GREAT CAVERN ===
 
You step through the opening and catch your breath.
The cavern is enormous — the ceiling disappears into darkness far above.
The sound of dripping water echoes all around.
 
Across the cavern floor, a faint warm light glows in the distance.
As your eyes adjust you can make out the shape of a shrine.
To one side a tunnel opening is visible but it is completely
blocked by a massive pile of rubble.
 
  shrine/    - Cross the cavern towards the light.
  tunnel/    - Examine the blocked tunnel.
  ../        - Head back.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/cavern/shrine/sign.txt << SIGN
=== THE SHRINE ===
 
A stone shrine sits in a pool of warm golden light
that seems to have no obvious source.
Offerings of flowers, coins and candles are arranged neatly.
The air here feels different — still and quiet.
 
A leather-bound book sits open on the altar.
 
  ../    - Leave the shrine.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/cavern/shrine/book.txt << SIGN
The book is open to a page near the end.
Most of it is written in a language you cannot read.
But the last entry is in plain common tongue:
 
  "I found all five fragments.
   The password is the five words in the order discovered.
 
   For those still searching:
   the merchant in the underground market holds the final piece.
   You are close."
 
  Below that, a pressed flower and five small ink marks.
SIGN
 
RUN cat > /home/student/MAZE/entrance/right/narrow_cliff/cavern/tunnel/sign.txt << SIGN
=== BLOCKED TUNNEL ===
 
A wide tunnel opening in the cavern wall.
Or at least it was wide once.
A massive collapse has filled it completely with rubble.
Boulders the size of carts are piled from floor to ceiling.
 
There is no way through.
 
  ../    - Head back to the cavern.
SIGN

 
# ── Ownership ────────────────────────────────────────────────────────────────
RUN chown -R student:student /home/student/MAZE
RUN find /home/student/MAZE -name "*.txt" -exec chown wizard:heroes {} \;

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

USER student
WORKDIR /home/student

CMD ["/startup.sh"]