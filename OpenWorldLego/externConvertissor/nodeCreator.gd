static func createBasicNodeOnPlayer(file_path, playerPos):
	var scene = load(file_path)
	var instance = scene.instantiate()
	instance.set_scale(Vector3(62.5, 62.5, 62.5))
	instance.position = Vector3(playerPos.x, playerPos.y, playerPos.z)
	return instance

static func createGravityNodeOnPlayer(file_path, playerPos):
	var scene = load(file_path)
	var instance = scene.instantiate()
	var gravity = GravityNode.new(instance)
	gravity.position = Vector3(playerPos.x+5, playerPos.y, playerPos.z)
	return gravity
