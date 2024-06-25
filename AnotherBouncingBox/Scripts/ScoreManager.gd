extends Node

var currentScore: int
var highscoreList: ScoreList = ScoreList.new()

@export var highscoreDisplay: RichTextLabel
@export_file("*.tscn") var mainMenuScene

const filePath: String = "user://saves/"
const fileName: String = "highscores.tres"

func _ready():
	if !DirAccess.dir_exists_absolute(filePath):
		DirAccess.make_dir_absolute(filePath)
	
	load_highscores()
	update_highscore_display()
	
func load_highscores():
	if ResourceLoader.exists(filePath + fileName):
		highscoreList = ResourceLoader.load(filePath + fileName) as ScoreList
	
func update_highscore_display():
	highscoreDisplay.text = ""
	
	for i:int in range(0, highscoreList.names.size()):
		highscoreDisplay.text += highscoreList.names[i] + ": " + str(Layout.get_time(highscoreList.scores[i])) + "\n"
		
func load_main_menu():
	get_tree().call_deferred("change_scene_to_file", mainMenuScene)
