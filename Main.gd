extends Node

export (PackedScene) var penguin_scene = preload("res://Penguin.tscn")

func _ready():
	randomize()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Win.visible: 
		get_tree().reload_current_scene()
		get_tree().set_pause(false)

func _on_Player_win():
	get_tree().set_pause(true)
	$UserInterface/Win.show()

func _on_PenguinTimer_timeout():
	var penguin = penguin_scene.instance()
	
	var penguin_spawn_location = $SpawnPath/SpawnLocation
	penguin_spawn_location.unit_offset = randf()
	
	add_child(penguin)
	penguin.intitialize(penguin_spawn_location.translation)

