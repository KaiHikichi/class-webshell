#include <stdio.h>
#include <string.h>

// ============================================================
// POTION WORKSHOP
// ============================================================
// Add ingredients to brewPotion() to brew a potion.
// Each ingredient adds one step to your recipe.
// Compile and run to see what you made!
//
// To compile:   gcc potions.c -o potions
// To run:       ./potions
// ============================================================

#define MAXSTEPS 16

char steps[MAXSTEPS + 1] = "";

// forward declarations
void cook();
void add_newt();
void add_four_leaf_clover();
void add_golden_carrot();
void add_thick_root();
void add_mushrooms();
void add_moth_wings();
void add_spider_eye();
void add_dragons_breath();
void add_cave_salt();
void stir();


// ============================================================
// ADD YOUR INGREDIENTS HERE
// ============================================================

/*
INGREDIENTS:

add_newt();
add_four_leaf_clover();
add_golden_carrot();
add_thick_root();
add_mushrooms();
add_moth_wings();
add_spider_eye();
add_dragons_breath();
add_cave_salt();
stir();

*/
void brewPotion() {
    
}


// ============================================================
// DO NOT EDIT BELOW THIS LINE
// ============================================================

int main() {
    brewPotion();
    cook();
    return 0;
}

void cook() {

    // health potion: mushrooms, golden carrot, cave salt, stir
    if (strcmp(steps, "mgat") == 0) {
        FILE *f = fopen("potions/health_potion.txt", "w");
        if (f != NULL) {
            fprintf(f, "=== HEALTH POTION ===\n\n");
            fprintf(f, "Drinking this will instantly heal any wounds.\n");
            fprintf(f, "An essential companion for any long adventure.\n");
            fclose(f);
            printf("The cauldron glows gold. Something worked!\n");
        } else { perror("Error: Potion failed"); }

    // invisibility potion: moth wings, spider eye, stir, cave salt
    } else if (strcmp(steps, "wsat") == 0) {
        FILE *f = fopen("potions/invisibility_potion.txt", "w");
        if (f != NULL) {
            fprintf(f, "=== INVISIBILITY POTION ===\n\n");
            fprintf(f, "Drinking this will make you invisble for one hour.\n");
            fprintf(f, "Great for sneaking around.\n");
            fclose(f);
            printf("The cauldron hisses and the steam vanishes. Something worked!\n");

        } else { perror("Error: Potion failed"); }

    // strength potion: thick root, dragons breath, stir, stir
    } else if (strcmp(steps, "rdtt") == 0) {
        FILE *f = fopen("potions/strength_potion.txt", "w");
        if (f != NULL) {
            fprintf(f, "=== STRENGTH POTION ===\n\n");
            fprintf(f, "Drinking this will double your strength for thirty minutes.\n");
            fprintf(f, "Use with caution.\n");
            fclose(f);
            printf("The cauldron shakes and glows red. Something worked!\n");

        } else { perror("Error: Potion failed"); }

    // night vision potion: mushrooms, cave salt, stir, moth wings
    } else if (strcmp(steps, "matw") == 0) {
        FILE *f = fopen("potions/night_vision_potion.txt", "w");
        if (f != NULL) {
            fprintf(f, "=== NIGHT VISION POTION ===\n\n");
            fprintf(f, "Drinking this lets you see clearly in complete darkness.\n");
            fprintf(f, "Effect lasts two hours. Great for cave exploration\n");
            fclose(f);
            printf("The cauldron glows pale blue. Something worked!\n");

        } else { perror("Error: Potion failed"); }

    // luck potion: four leaf clover, stir, golden carrot, cave salt
    } else if (strcmp(steps, "ctga") == 0) {
        FILE *f = fopen("potions/luck_potion.txt", "w");
        if (f != NULL) {
            fprintf(f, "=== POTION OF LUCK ===\n\n");
            fprintf(f, "Drinking this tips the odds in your favour for one hour.\n");
            fprintf(f, "Results may vary. Great for card games.\n");
            fclose(f);
            printf("The cauldron pops and turns green. Something worked!\n");

        } else { perror("Error: Potion failed"); }

    // courage potion: thick root, golden carrot, stir, newt
    } else if (strcmp(steps, "rgtn") == 0) {
        FILE *f = fopen("potions/courage_potion.txt", "w");
        if (f != NULL) {
            fprintf(f, "=== POTION OF COURAGE ===\n\n");
            fprintf(f, "Drinking this lets you face your fears without flinching.\n");
            fprintf(f, "It tastes absolutely terrible.\n");
            fclose(f);
            printf("The cauldron roars and blazes orange. Something worked!\n");

        } else { perror("Error: Potion failed"); }

    // speed potion: newt, spider eye, stir, dragons breath
    } else if (strcmp(steps, "nstd") == 0) {
        FILE *f = fopen("potions/speed_potion.txt", "w");
        if (f != NULL) {
            fprintf(f, "=== POTION OF SPEED ===\n\n");
            fprintf(f, "Drinking this lets you move twice as fast for twenty minutes.\n");
            fprintf(f, "Side effects include hiccups and talking too fast.\n");
            fclose(f);
            printf("The cauldron whistles and spins. Something worked!\n");

        } else { perror("Error: Potion failed"); }

    // water breathing potion: cave salt, mushrooms, stir, spider eye
    } else if (strcmp(steps, "amts") == 0) {
        FILE *f = fopen("potions/water_breathing_potion.txt", "w");
        if (f != NULL) {
            fprintf(f, "=== WATER BREATHING POTION ===\n\n");
            fprintf(f, "Drinking this lets you breathe underwater for thirty minutes.\n");
            fprintf(f, "Useful for exploring submerged ruins.\n");
            fclose(f);
            printf("The cauldron turns teal and bubbles slowly. Something worked!\n");

        } else { perror("Error: Potion failed"); }

    // awkward potion (wrong ingredients)
    } else {
        FILE *f = fopen("potions/awkward_potion.txt", "w");
        if (f != NULL) {
            fprintf(f, "=== AWKWARD POTION ===\n\n");
            fprintf(f, "The cauldron lets out a sad gurgle and goes cold.\n");
            fprintf(f, "You have brewed an Awkward Potion.\n\n");
            fprintf(f, "This potion has no effect whatsoever.\n");
            fprintf(f, "It smells terrible though.\n");
            fprintf(f, "Try a different combination of ingredients.\n");
            fclose(f);
            printf("The cauldron gurgles sadly. That did not work.\n");

        } else { perror("Error: Potion failed"); }
    }

    memset(steps, 0, sizeof(steps));
}

// ── ingredient functions ──────────────────────────────────────

void add_newt() {
    strncat(steps, "n", sizeof(steps) - strlen(steps) - 1);
}

void add_four_leaf_clover() {
    strncat(steps, "c", sizeof(steps) - strlen(steps) - 1);
}

void add_golden_carrot() {
    strncat(steps, "g", sizeof(steps) - strlen(steps) - 1);
}

void add_thick_root() {
    strncat(steps, "r", sizeof(steps) - strlen(steps) - 1);
}

void add_mushrooms() {
    strncat(steps, "m", sizeof(steps) - strlen(steps) - 1);
}

void add_moth_wings() {
    strncat(steps, "w", sizeof(steps) - strlen(steps) - 1);
}

void add_spider_eye() {
    strncat(steps, "s", sizeof(steps) - strlen(steps) - 1);
}

void add_dragons_breath() {
    strncat(steps, "d", sizeof(steps) - strlen(steps) - 1);
}

void add_cave_salt() {
    strncat(steps, "a", sizeof(steps) - strlen(steps) - 1);
}

void stir() {
    strncat(steps, "t", sizeof(steps) - strlen(steps) - 1);
}