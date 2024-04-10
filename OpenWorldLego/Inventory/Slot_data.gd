extends Resource
class_name SlotData

# This resource is used to store the data for an individual slot, 
# including the element it contains and the quantity of that element.


const MAX_STACK_SIZE : int = 99

@export var item_data : ItemData
@export_range(1, MAX_STACK_SIZE) var quantity : int  = 1



