# Few words about **World Generation**

## General Structure

The world in the OpenWorldLego project is proceduraly generated, dynamicaly. The ground is separate into chunks, wich are regions of 16x16x16 LEGO's bricks. The player is the center of the viewing world. Each frame, the program scans the neighboors of the chunk where is located the player. In a circle (the viewing range can be change in the script Player.gd) arround the player, the chunks are instanciate if there are not already existing and add to the game tree. All chunks are separate into 3 parts :
- Chunks charged
- Chunks not charged
- Chunks that need to be charged

This structure permits to update quickly the game tree and delay the chunk's instanciation. Indeed, instanciate 16x16 blocks is huge and take time, so to avoid droping framerate during the loading of several chunks, we limit the instanciation at 1 chunk every 4 frames. When a chunk is uncharged, it does not die and is saved in the last category. This allows to the player to come back to a chunk where he add a block for exemple and find his changes.

## Scale and Dimensions

Something important to notice is that we choosed to enlarge lego bricks. This means that in Godot, every lego pieces are scaled by 62,5. This allows a 2x2 brick to mesure 1 m in width. The height of a 2x2 brick is 9.6/16 m.

## Player view

The player has an attribute called limit_view, which describes the distance at which charged blocks are displayed. The distance is a number of chunks. Be careful, increasing limit_view reduces performance exponentially.

| limit_view | Number of Chunks |
| :----: | :----: |
|     1      |        4         |
|     2      |       16         |
|     3      |       36         |
|     4      |       64         |
|   ...      |      ...         |

## Biomes

There are for now 4 biomes : Ocean, Plain, Mountain, Forest. To decide the location of each biome, we use 2 perlin noise : humidity and temperature. The main problem is the transition between biomes.

## What you can do to improve the generation ?

There are 2 ways that are in contradiction : **enrichment** of the world and the **performances**.

- **Montains** are cool and beautiful but a problem is that we charge a lot of bricks that the player do not see at all for that. Multiplication decreases performances, especially during instanciation of objects. We could imagine to instanciate only the 2 upper layers of bricks of the mountain and then create the others only if player start to dig it.

- **Bedrock** : It should be interressant to make a "bedrock layer" like in minecraft, to prohibit the player to fall in the void under the map.

- **water** : For now water is just some basic cube with a collision translated by (0,-1,0). We could add archimedean thrust to a deeper layer of water to permit flotation.

- **biomes transition** : Think about a way to produce the finale input of the perlin_noise function for generate ground would be nice as we could add some weight to our 4 noises (one for each biome) in function of the value the noises humidity+temperature. This could allows to smooth the transition between 2 biomes.

- **clouds** : with a noise, we could make a "cloud map" and print a brick or not in function of the value of the cell. This map could be update every second and give an impression of movement to the player. Or generate a 3D cloud by get a design and deform it with some noise.





