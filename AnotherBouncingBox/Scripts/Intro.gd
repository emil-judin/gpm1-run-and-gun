extends Node

@export_file("*.tscn") var firstLevelScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed():
		Layout.reset_timer()
		get_tree().call_deferred("change_scene_to_file", firstLevelScene)
