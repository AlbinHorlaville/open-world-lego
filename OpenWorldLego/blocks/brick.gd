class_name Brick extends Node3D

# The color of the lego brick
var color:Color
# The biome where it is located, to applicate some shaders
var biome:int # from 0 to the number of biomes
# The solidity of the lego brick, it impacts the time needed to destroy it for example
var solidity:int # from 1 to 5
# The weight of the lego brick
var weight:int # from 1 to 5
# The pourcentage of density of the lego brick. it impacts the way the other bricks can pass through.
var density:int # from 0 to 100
