# COMP2511-Dungeon-Level-Generator

![Example Dungeon represented in ASCII, versus it loaded in the Dungeon Game](/exampleDungeon.png)

Given a file that represents your Dungeon with ASCII characters, it automatically creates a .json file in the correct format to load into the game. Script is POSIX compliant (well, at least /bin/dash says so).


# Usage

1. Create a file that satisfies the following: (e.g. refer to **'exampleDungeon'**)
   * Is **filename is the name of the level**. (file extension doesn't matter)
   * It contains a **rectangular grid consisting of the ASCII characters corresponding to the entities** (**table down below**).

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

**NOTE**: **IDs of 'doors', 'key' and 'portal' entities are all set to 1 by default**.

**NOTE**: **Goal condition is set to 'exit' by default**.


## Entities

| Character | Entity Type |
| --------- |:------------:|
|'.'| (empty tile)|
|'#'| 'wall'|
|'P'| 'player'|
|'E'| 'enemy'|
|'S'| 'sword'|
|'I'| 'invincibility'|
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
