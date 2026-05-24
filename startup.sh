#!/bin/bash
# Save username to environment so .bashrc can use it
echo "export USERNAME=$USERNAME" >> /home/student/.bashrcv

exec /bin/bash