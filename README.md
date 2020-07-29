# COMP2511-Dungeon-Level-Generator

# What does it do?

Given a file that represents your Dungeon with ASCII character, it automatically creates a .json file in the correct format to load into the game.

# Usage

```
$ cat shortDungeon
#####
#P..#
#.T.#
#..X#
#####

$ ./genDungeon.sh shortDungeon
Generating level 'shortDungeon.json'
Successfully created level 'shortDungeon.json'

$ head shortDungeon.json
{
  "width": 5,
  "height": 5,
  "entities": [
    {
      "x": 0,
      "y": 0,
      "type": "wall"
    },
    {
    
$
```

**NOTE**: **IDs of 'doors', 'key' and 'portal' entities are all set to 1 by default**, and so must be configured manually for other values.

**NOTE**: **Goal condition is set to 'exit' by default**, and so  must be configured manually for other conditions.

1. Create a file that follows the conditions (refer to **'exampleDungeon'** as an example):
   * It has the name of the level you want to generate. 
   * It is filled with a rectangular grid of the following characters, representing one tile of your dungeon:
   * NOTE: File extension can be anything, it won't be read.

| Character | Entity Type |
| --------- |:------------:|
|'.'| (doesn't do anything)|
|'#'| 'wall'|
|'P'| 'player'|
|'E'| 'enemy'|
|'S'| 'sword'|
|'I'| 'invincibility Potion'|
|'X'| 'exit'|
|'T'| 'treasure'|
|'B'| 'boulder'|
|'F'| 'floor switch'|
|'D'| 'door'|
|'K'| 'key'|
|'O'| 'portal'|


2. Run the shell script with the file(s) like so:
```
$ ./genDungeon.sh dungeonFile
Generating level 'dungeonFile.json'
Successfully created level 'dungeonFile.json'
```


## Adding More Entities / Editing the entity types:

If the shell script isn't creating the correct 'type' in the JSON for each entity, or you want to add more of your own entities, **edit the switch-case code at around line 120 and add a case manually**:

``` 
...
case "$char" in
    # BASIC ENTITIES
    "#" )
        entityType="wall";;
    "P" )
        entityType="player";;
    "E" )
        entityType="enemy";;
    ...
```
