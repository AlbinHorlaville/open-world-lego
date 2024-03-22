extends Control

class_name Inventory # class de notre inventaire

var item_list : Array = []


class ItemAmount :
		
	var amount = 0
	var item = null
	
	func _init(_amount : int, _item : dirt) -> void:
		amount = _amount
		item = _item
		

# Ajoute un item dans l'invenaire
func _append_item(item : dirt, amount : int = 1) -> void :
	var item_amount_id = _find_item_id(item)
	if item_amount_id == -1:
		item_list.append(ItemAmount.new(amount, item))
	else :
		item_list[item_amount_id].amount += amount
	

# Recherche si l'item est déjà present dans l'inventaire
func _find_item_id(item) : 
	for i in range(item_list.size()):
		var amount = item_list[i]
		if amount.item == item : 
			return i
	return -1
	
	

func _remove_item(item : dirt, amount  : int = 1) -> void:
	var item_amount_id = _find_item_id(item)
	
	if item_amount_id == -1:
		push_error("%s Objet introuve dans l'inventaire donc impossible de le removed : " % item.item_name)
	else : 
		item_list[item_amount_id].amount -= amount
		if item_list[item_amount_id].amount <= 0 :
			item_list.remove_at(item_amount_id)
			
			
			

# FAIRE UNE MÉTHODE TESTER L'INVENTAIRE QUAND LES ITEMS SERONT CRÉES
	
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
