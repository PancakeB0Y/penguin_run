extends Spatial

export var camrot_h = 0
export var camrot_v = 0
var cam_v_max = 75
var cam_v_min = -55
var h_sensitivity = 0.1
var v_sensitivity = 0.1
var h_acceleration = 80
var v_acceleration = 10

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$h/v/Camera.add_exception(get_parent())
	
func _input(event):
	if event is InputEventMouseMotion:
		camrot_h += -event.relative.x * h_sensitivity
		camrot_v += -event.relative.y * v_sensitivity
		camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
		$h.rotation_degrees.y = lerp($h.rotation_degrees.y, camrot_h, 1.0/60.0 * h_acceleration)
		$h/v.rotation_degrees.x = lerp($h/v.rotation_degrees.x, camrot_v, 1.0/60.0 * v_acceleration)
		
