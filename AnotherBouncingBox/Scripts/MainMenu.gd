extends Node

@export_file("*.tscn") var startGameScene
@export_file("*.tscn") var leaderboardScene
@export_file("*.tscn") var creditsScene

func start_game():
	get_tree().call_deferred("change_scene_to_file", startGameScene)
	
func show_leaderboard():
	get_tree().call_deferred("change_scene_to_file", leaderboardScene)
	
func show_credits():
	get_tree().call_deferred("change_scene_to_file", creditsScene)
	
func quit_game():
	get_tree().quit()
