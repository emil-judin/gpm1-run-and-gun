extends Node

@export_file("*.tscn") var mainMenuScene

func load_main_menu():
	get_tree().call_deferred("change_scene_to_file", mainMenuScene)
