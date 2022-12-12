extends Node

export (PackedScene) var penguin_scene = preload("res://Penguin.tscn")

func _ready():
	randomize()

	for i in 100:
		var n1 = randf()
		var n2 = randf()
		var max_distance = 500
		var angle = n1*2*PI
		var radius = pow(n2, 1.0/3.0)*max_distance
		var x = cos(angle)*radius
		var z = sin(angle)*radius
		var location = Vector3(x, 0, z)
		
		var loops = rand_range(5, 10)
		for j in loops:
			var penguin = penguin_scene.instance()
			var randx = rand_range(-10, 10)
			var randz = rand_range(-10, 10)
			location.x += randx
			location.z += randz
			add_child(penguin)
			penguin.intitialize(location)
		
		
	

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Win.visible: 
		get_tree().reload_current_scene()
		#get_tree().set_pause(false)

func _on_Player_win():
	#get_tree().set_pause(true)
	$UserInterface/Win.show()

func _on_PenguinTimer_timeout():
	var penguin = penguin_scene.instance()

	var penguin_spawn_location = $SpawnPath/SpawnLocation
	penguin_spawn_location.unit_offset = randf()

	add_child(penguin)
	penguin.intitialize(penguin_spawn_location.translation)

