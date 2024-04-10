extends Resource
class_name InventoryData

# This resource is used to store player inventory data, 
# including an array of slot data and a signal to detect when 
# the player interacts with the inventory. 
# It also defines a method for retrieving data from an individual slot.


signal inventory_interact(inventory_data : InventoryData, index : int, button : int)

@export var slot_datas : Array[SlotData]


func on_slot_clicked(index : int, button : int) -> void :
	inventory_interact.emit(self, index, button)


func grab_slot_data(index : int) -> SlotData:
	var slot_data = slot_datas[index]
	
	if slot_data:
		return slot_data
	else : 
		return null
	
	
	
