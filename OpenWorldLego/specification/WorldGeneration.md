The world in the OpenWorldLego project is proceduraly generated, dynamicaly. The ground is separate into chunks, wich are regions of 16x16x16 LEGO's bricks. The player is the center of the viewing world. Each frame, the program scans the neighboors of the chunk where is located the player. In a circle (the viewing range can be change in the script Player.gd) arround the player, the chunks are instanciate if there are not already existing and add to the game tree. All chunks are separate into 3 parts :
- Chunks charged;
- Chunks not charged;
- Chunks that need to be charged.

This structure permits to update quickly the game tree and delay the chunk's instanciation. Indeed, instanciate 16x16x16 blocks is huge and take time, so to avoid droping framerate during the loading of several chunks, we limit the instanciation at 1 chunk every 4 frames. When a chunk is uncharged, it does not die and is saved in the last category. This allows to the player to come back to a chunk where he add a block for exemple and find his changes.
