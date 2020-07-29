# COMP2511-Dungeon-Level-Generator

![Example Dungeon represented in ASCII, versus it loaded in the Dungeon Game](/exampleDungeon.png)

# What does it do?

Given a file that represents your Dungeon with ASCII character, it automatically creates a .json file in the correct format to load into the game.

# Usage

**NOTE**: **IDs of 'doors', 'key' and 'portal' entities are all set to 1 by default**, and so must be configured manually for other values.

**NOTE**: **Goal condition is set to 'exit' by default**, and so  must be configured manually for other conditions.

1. Create a file that has the following (refer to **'exampleDungeon'** as an example):
   * It has the name of the level you want to generate. (File extension doesn't matter; it won't be read)
   * It is filled with a rectangular grid consisting of the ASCII characters corresponding to entities (**table down below**).

2. Run the shell script with the file(s) like so:

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

## Entities

| Character | Entity Type |
| --------- |:------------:|
|'.'| (empty tile)|
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
