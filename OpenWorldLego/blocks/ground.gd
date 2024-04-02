class_name Ground extends Brick

func on_ready()->void:
	# Instance the StaticBody
	var body = StaticBody3D.new()
	self.add_child(body)
