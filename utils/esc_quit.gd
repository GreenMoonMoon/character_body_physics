extends Node
class_name EscQuit

func _unhandled_input(event):
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		get_tree().quit()
