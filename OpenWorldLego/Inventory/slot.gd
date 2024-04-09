extends PanelContainer

# This node is the scene for an individual slot in the inventory grid. 
# It contains a texture to display the item icon, a label to display the item quantity 
# and a signal to detect when the player clicks on the slot. It also defines a method 
# for setting slot data.


signal slot_clicked(index : int, button : int)

@onready var texture_rect = $MarginContainer/TextureRect
@onready var quantity_label : Label = $QuantityLabel


func set_slot_data(slot_data : SlotData) -> void:
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
		
	tooltip_text = "%s\n%s" % [item_data.item_name, item_data.item_description]
	

	if slot_data.quantity > 1 : 
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.show()


func _on_gui_input(event):
	if event is InputEventMouseButton and (event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT) and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
