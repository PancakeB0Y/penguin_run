extends Node

func _ready():
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Win.visible: 
		get_tree().reload_current_scene()
		get_tree().set_pause(false)

func _on_Player_win():
	get_tree().set_pause(true)
	$UserInterface/Win.show()
