static func createBasicNodeOnPlayer(file_path, playerPos):
	print("Trigger B")
	var scene = load(file_path)
	var instance = scene.instantiate()
	instance.set_scale(Vector3(62.5, 62.5, 62.5))
	instance.position = Vector3(playerPos.x, playerPos.y, playerPos.z)
	return instance

static func createGravityNodeOnPlayer(file_path, playerPos):
	print("Trigger G")
	var scene = load(file_path)
	var instance = scene.instantiate()
	instance.set_scale(Vector3(62.5, 62.5, 62.5))
	instance.position = Vector3(playerPos.x, playerPos.y + 10, playerPos.z)
	return instance

