#!/bin/sh

# Author: Created by 8veStory, 29/07/2020, to assist in the process of creating levels for COMP2511's Dungeon Game assignment. 

# WHAT DOES IT DO?
# Automatically generates a dungeon .json file if you give it a file that has your dungeon
# represented in ASCII, e.g.:
# IMPORTANT: Check lines 109 onwards (the switch-case) and make sure the entity types
#            have the same names you chose.
# NOTE: If you add doors, keys or portals, the ids automatically be set to 1.
# NOTE: Goal is automatically set to 'exit', and so  must be configured manually.

# HOW TO USE:
# Create a file that follows the conditions (refer to 'coolDungeon' as an example):
# * It has the name of the level you want to generate. 
# * It is filled with a rectangular grid of the following characters, representing one tile of your dungeon:
    # BASIC ENTITIES
    # '.' - Nothing
    # '#' - Wall
    # 'P' - Player
    # 'E' - Enemy
    # 'S' - Sword
    # 'I' - Invincibility Potion
    # 'X' - Exit
    # 'T' - Treasure
    # 'B' - Boulder
    # 'F' - Floor switch
    # 'D' - Door
    # 'K' - Key
    # 'O' - Portal

# ADDING MORE ENTITIES:
# Go down to the 'case "$char" in' statement down in the code and manually add it.
# Should only need to add 2 lines.

##################
# IMPLEMENTATION #
##################
# Prints if verbosity [-v] is set.
verbose=0
verbosePrint() {
    if [ "$verbose" -eq 1 ]; then   
        echo -n "$1"
    fi
}

# Processes a file and create a .json dungeon level file out of it.
processFile() {
    filename=$1
    levelname=`echo "$filename" | cut -d'.' -f 1`
    levelFilename="$levelname.json"
    echo "Generating level '$levelFilename'..."
    
    # Loop through and check the width and height.
    width=0
    height=0
    first_hor_loop=1
    first_ver_loop=1
    while IFS= read -r line || [ -n "$line" ]; do
        line_width=$((`echo "$line" | wc -m` - 1))
        if [ $line_width -ge $width ]; then
            width=$line_width
        fi

        # Set height.
        height=$(($height + 1))
    done < "$filename"

    # Check if file already exists.
    if [ -f "$levelFilename" ]; then
        while true; do
            echo -n "$levelFilename already exists in the current directory. Are you sure you want to overwrite it (y/n)? "
            read input
            case "$input" in
                [Yy]* )
                    break;;
                [Nn]* )
                    echo "Aborting..."
                    exit 1;;
            esac
        done
    fi

    # Generate width and height.
    touch "$levelFilename"
    echo "{" > "$levelFilename"
    echo "  \"width\": $width," >> "$levelFilename"
    echo "  \"height\": $height," >> "$levelFilename"
    echo "  \"entities\": [" >> "$levelFilename"

    # Parse entities for each line. (While-read loop from https://unix.stackexchange.com/questions/418060/read-a-line-oriented-file-which-may-not-end-with-a-newline)
    currRow=0
    while IFS= read -r line || [ -n "$line" ]; do
        currCol=0

        # Check height isn't exceeded.
        if [ $currRow -ge $height ]; then
            continue
        fi

        verbosePrint "Row $currRow: $line\n"

        # Loop through each line and parse the output.
        tempLine="$line"
        while [ -n "$tempLine" ]; do
            # Check width isn't exceeded.
            if [ $currCol -ge $width ]; then
                break
            fi

            # Get the next character. (taken from https://stackoverflow.com/questions/51052475/how-to-iterate-over-the-characters-of-a-string-in-a-posix-shell-script)
            rest="${tempLine#?}"    # All but the first character of the string
            char="${tempLine%"$rest"}"    # Remove $rest to get first character.
            tempLine="$rest"

            verbosePrint "($currRow, $currCol) : '$char'" # DEBUG OUTPUT

            # Assign character to an entity if it exists.
            entityType=""
            case "$char" in
                # BASIC ENTITIES
                "#" )
                    entityType="wall";;
                "P" )
                    entityType="player";;
                "E" )
                    entityType="enemy";;
                "S" )
                    entityType="sword";;
                "I" )
                    entityType="invincibility";;
                "X" )
                    entityType="exit";;
                "T" )
                    entityType="treasure";;
                "B" )
                    entityType="boulder";;
                "F" )
                    entityType="switch";;
                "D" )
                    entityType="door";;
                "K" )
                    entityType="key";;
                "O" )
                    entityType="portal";;
            esac

            # If entityType is defined, then place it in the json.
            if ! [ -z "$entityType" ]; then
                verbosePrint "-> '$entityType'"

                # Add the entity's position.
                echo "    {" >> "$levelFilename"
                echo "      \"x\": $currCol," >> "$levelFilename"
                echo "      \"y\": $currRow," >> "$levelFilename"

                # Add its ID if it needs it.
                if [ \( "$entityType" = "door" -o "$entityType" = "key" \) -o \( "$entityType" = "portal" \) ]; then
                    echo "      \"id\": 1," >> "$levelFilename"
                fi

                # Add its entity type.
                echo "      \"type\": \"$entityType\"" >> "$levelFilename"

                # If last entity, then no trailing comma.
                if [ $currRow -eq $(($height - 1)) -a $currCol -eq $(($width - 1)) ]; then
                    echo "    }" >> "$levelFilename"
                else
                    echo "    }," >> "$levelFilename"
                fi
            fi
            verbosePrint "\n"

            currCol=$(($currCol + 1))
        done

        # Increment row by one.
        currRow=$(($currRow + 1))
    done < "$filename"

    # Finish entities array.
    echo "  ]," >> "$levelFilename"

    # Create goal condition with "exit" as the default goal.
    echo "  \"goal-condition\": {" >> "$levelFilename"
    echo "    \"goal\": \"exit\"" >> "$levelFilename"
    echo "  }" >> "$levelFilename"

    # Finish creating the file.
    echo "}" >> "$levelFilename"

    echo "Successfully created level '$levelFilename'"
}

main() {
    # Check correct number of arguments.
    if [ $# -le 0 ]; then
        echo "Usage: $0 [-v Verbose] <files>"
        exit 1
    fi

    # Set verbosity option.
    for arg in "$@";  do
        case "$arg" in
            "-v" )
                verbose=1
                shift;;
        esac
    done

    # Check all files exist first.
    for filename in "$@"; do
        if ! [ -f "$filename" ]; then
            echo "File '$filename' doesn't exist."
            exit 1
        fi
    done

    # Process each file.
    for filename in "$@"; do
        processFile "$filename"
    done
}

main $@


