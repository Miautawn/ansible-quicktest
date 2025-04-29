#!/bin/bash

./bin/miautawn-setup

TARGET_EXIT_STATUS=$?
if [ ! $TARGET_EXIT_STATUS -eq 0 ]; then
    echo "Test script failed with exit status $TARGET_EXIT_STATUS."
    echo "Launching interactive bash shell for investigation."
    echo "Type 'exit' to return from the interactive session."

    /bin/bash -i
    exit 1
fi
echo "Test script completed successfully."
/bin/bash -i
exit 0
