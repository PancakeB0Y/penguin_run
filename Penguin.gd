extends KinematicBody

export var min_speed = 2.0
export var max_speed = 4.0
export var clothes = true

var velocity = Vector3.ZERO

func _physics_process(_delta):
	move_and_slide(velocity, Vector3.UP)
	
func intitialize(start_position):
	translation = start_position
	rotate_y(PI)
	
	var random_speed = rand_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
