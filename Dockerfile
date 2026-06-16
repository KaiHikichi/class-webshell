FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    vim \
    less \
    tree \
    gcc \
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

# ── Ownership ────────────────────────────────────────────────────────────────
COPY MAZE/ /home/student/MAZE/

# ── Ownership ────────────────────────────────────────────────────────────────
RUN chown -R student:student /home/student/MAZE

RUN find /home/student/MAZE -name "*.txt" -exec chown wizard:heroes {} \; && \
    find /home/student/MAZE -name "*note*.txt" -path "*goblin_den*" -exec chown goblin:monsters {} \; && \
    find /home/student/MAZE -name "box.txt" -path "*mushroom_grove*" -exec chown wizard:heroes {} \;

RUN find /home/student/MAZE -name "message.txt" -exec chown troll:monsters {} \; && \
    find /home/student/MAZE -name ".helmet.txt" -exec chown troll:monsters {} \; && \
    find /home/student/MAZE -path "*.trapdoor*" -name "note2.txt" -exec chown troll:monsters {} \; && \
    find /home/student/MAZE -path "*.portal_frame*" -name "note1.txt" -exec chown troll:monsters {} \;

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
 
# ── Potions ────────────────────────────────────────────────────────────────
RUN mkdir -p /home/student/POTIONS/potions
COPY scripts/cauldron.c /home/student/POTIONS/cauldron.c
COPY scripts/recipe_book.txt /home/student/POTIONS/recipe_book.txt
RUN chown student:student /home/student/POTIONS && \
    chown student:student /home/student/POTIONS/potions && \
    chown wizard:heroes /home/student/POTIONS/cauldron.c && \
    chown wizard:heroes /home/student/POTIONS/recipe_book.txt


RUN chmod 777 /home/student/POTIONS/cauldron.c && \
    chmod 777 /home/student/POTIONS/recipe_book.txt

# ── Startup ────────────────────────────────────────────────────────────────
COPY scripts/startup.sh /startup.sh
RUN chmod +x /startup.sh

USER student
WORKDIR /home/student

CMD ["/startup.sh"]