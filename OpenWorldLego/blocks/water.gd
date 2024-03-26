extends Brick

@export var material_water_trans:Material

# Set the transparency of the block of water
func changeTransparency():
	var mesh_inst = $brick2x2.get_child(0)
	mesh_inst.set_surface_override_material(0, material_water_trans)

# Movement of the sea waves
var t:float=0
func _process(delta: float) -> void:
	if t>2*PI*100:
		t=0
	t+=delta
	position.y = 0.5*(sin((position.x+t)/2)*sin((t-position.z))/2)
	
func getMesh():
	return $brick2x2.get_children()[0]
