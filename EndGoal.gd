extends KinematicBody
var player_pos = Vector3.ZERO
var end_goal = self.transform.origin
var distance = 0.0
func _physics_process(_delta):
	player_pos = get_node("/root/Main/Player").transform.origin
	distance = sqrt(pow(player_pos.x - end_goal.x, 2) + pow(player_pos.z - end_goal.z, 2))
	if distance < 500:
		$LightRay.emitting = false
		$LightRay2.emitting = true
		$LightRay.process_material.gravity.y = 500
	if distance < 300:
		$LightRay2.emitting = false
		$LightRay3.emitting = true
		$LightRay.process_material.gravity.y = 300
	if distance < 100:
		$LightRay3.emitting = false
		$LightRay4.emitting = true
		$LightRay.process_material.gravity.y = 100
	#print(end_goal, "\n", distance)

