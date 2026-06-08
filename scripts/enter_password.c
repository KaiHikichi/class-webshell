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
        printf("Wrong password. The door remains tightly shut.\n");
        return 1;
    }

    //Check the password safely
    if (strcmp(argv[1], "45A#6") == 0) {
        printf("Correct password! You hear a heavy stone mechanism grinding...\n");

        if (rmdir("locked_door") != 0) {
            perror("Error removing old door");
        }

        if (mkdir("locked_door", 0755) == 0) {
            printf("The door is now open.\n");

            FILE *chest = fopen("locked_door/treasure.txt", "w");
            if (chest != NULL) {
                fprintf(chest, "***********************************************\n");
                fprintf(chest, "* You found a bunch of gold! Congratulations! *\n");
                fprintf(chest, "***********************************************\n");
                fclose(chest);
            } else {
                perror("The treasure chest failed to spawn");
            }


        } else {
            perror("Error creating the new passage");
        }
    } else {
        printf("Wrong password. The door remains tightly shut.\n");
    }

    return 0;
}