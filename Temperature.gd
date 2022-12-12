extends Label

export var temp = 100.5
export var starting_z = 400
export var distance = 0
export var PlayerPos = Vector3.ZERO

func _physics_process(_delta):
	PlayerPos = get_node("/root/Main/Player").transform.origin
	#distance = sqrt(pow(PlayerPos.x - world_origin[0], 2) + pow(PlayerPos.z - world_origin[2], 2))
	
	temp -= 0.0001 * abs(PlayerPos.z - starting_z)
	temp = clamp(temp, 0, 100.9)
	text = "Temperature: %s" % floor(temp)



