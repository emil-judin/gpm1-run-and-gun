extends Node

@export_file("*.tscn") var scenePath

func loadNextLevel(body):
	var player : Player = body as Player
	if player != null:
		get_tree().call_deferred("change_scene_to_file", scenePath)
