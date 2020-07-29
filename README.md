# COMP2511-Dungeon-Level-Generator
Dungeon level generator for COMP2511's Dungeon Game Assignment

# What does it do?

Automatically generates a dungeon .json file if you give it a file that has your dungeon represented in ASCII.

# Usage

**NOTE**: **IDs of 'doors', 'key' and 'portal' entities are all set to 1**, and so must be configured manually for other values.

**NOTE**: **Goal condition is set to 'exit' by default**, and so  must be configured manually for other conditions.

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

1. Create a file that follows the conditions (refer to 'coolDungeon' as an example):
   * It has the name of the level you want to generate. 
   * It is filled with a rectangular grid of the following characters, representing one tile of your dungeon:

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
