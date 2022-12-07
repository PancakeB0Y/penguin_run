extends KinematicBody

export var min_speed = 2.0
export var max_speed = 4.0
export var fall_acceleration = 70
export var clothes = true
var velocity = Vector3.ZERO

onready var player = get_node("/root/Main/Player")
var distance = 0
var player_pos = Vector3.ZERO
var update_counter = 0;

func _physics_process(delta):	
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	
	update_counter += 1
	if update_counter >= 20:
		player_pos = player.transform.origin
		distance = sqrt(pow(player_pos.x - translation.x, 2) + pow(player_pos.z - translation.z, 2))
		update_counter = 0
	
	if translation.y < -15:
		queue_free()
		
	if distance > 100:
		#set_physics_process(false) 
		set_pause_mode(false)
	
func intitialize(start_position):
	translation = start_position
	rotate_y(randf()*2*PI)
	
	var random_speed = rand_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
