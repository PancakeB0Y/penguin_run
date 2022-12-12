extends KinematicBody

signal win
# How fast the player moves in meters per second.
export var speed = 50.0
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75.0
# Jump length in the Y dimension
export var jump_impulse = 20.0
export var in_interact_range = false
var cur_body

var velocity = Vector3.ZERO
func _physics_process(delta):
	# We create a local variable to store the input direction.
	var cam_direction = -$Camroot.camrot_h * PI/180
	var direction = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_forward"):
		direction += -Vector3(-sin(cam_direction), 0, cos(cam_direction))
	if Input.is_action_pressed("move_back"):
		direction += Vector3(-sin(cam_direction), 0, cos(cam_direction))
	if Input.is_action_pressed("move_left"):
		direction += -Vector3(cos(cam_direction), 0, sin(cam_direction))
	if Input.is_action_pressed("move_right"):
		direction += Vector3(cos(cam_direction), 0, sin(cam_direction))
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if is_on_floor() and Input.is_action_just_pressed("jump"): 
		direction.y += 1
		velocity.y += jump_impulse
	
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	#velocity.y = 0
	#$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse
	
	if in_interact_range:
		if cur_body.clothes == true:
			if Input.is_action_pressed("interact"):
				get_node("/root/Main/UserInterface/Temperature").temp += 10
				cur_body.clothes = false
				

func win():
	emit_signal("win")
	$Camroot/h/v/Camera.set_current(false)
	set_physics_process(false)

func _on_WinDetector_body_entered(_body):
	win()

func _on_InteractRange_body_entered(body):
	in_interact_range = true
	cur_body = body

func _on_InteractRange_body_exited(_body):
	in_interact_range = false
