extends Control

# This node is the main container for the inventory user interface. 
# It contains a reference to the PlayerInventory scene and defines a method 
# for setting the player's inventory data.

@onready var player_inventory : PanelContainer = $PlayerInventory


func set_player_inventory_data(inventory_data : InventoryData) -> void : 
	player_inventory.set_inventory_data(inventory_data)
