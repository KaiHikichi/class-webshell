#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char *argv[]) {
    //Check if the player actually provided a password
    if (argc < 2) {
        printf("Wrong glyph. The portal remains silent.\n");
        return 1;
    }

    //Check the password safely
    if (strcmp(argv[1], "~[*]~") == 0) {    //if basic password correct

        if (mkdir("activated_portal", 0755) == 0) {
            printf("Correct glyph! The portal activates with a bright flash.\n");

            FILE *vault = fopen("activated_portal/magic_vault.txt", "w");
            if (vault != NULL) {
                fprintf(vault, "***********************************************\n");
                fprintf(vault, "* You step through the portal to find the Wizards hidden stash. *\n");
                fprintf(vault, "* It is full of magical items, ingredients, and books.*\n");
                fprintf(vault, "* Congratulations you found all the secrets of the maze!!!*\n");
                fprintf(vault, "***********************************************\n");
                fclose(vault);
            } else {
                perror("The vault failed to spawn");
            }
        } else {
            perror("Error creating the new passage");
        }
    }
    else {
        printf("Wrong glyph. The portal remains silent.\n");
    }

    return 0;
}