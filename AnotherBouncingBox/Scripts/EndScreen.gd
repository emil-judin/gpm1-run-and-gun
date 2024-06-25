extends Node

var highscoreList: ScoreList = ScoreList.new()
const filePath: String = "user://saves/"
const fileName: String = "highscores.tres"
@export var yourScoreLabel: RichTextLabel
@export var nameInput: TextEdit
@export_file("*.tscn") var mainMenuScene
var endTime: float

func _ready():
	endTime = Time.get_ticks_msec() - Layout.gameStartTime
	yourScoreLabel.text += str(Layout.get_time(endTime))
	load_highscores()

func load_highscores():
	if ResourceLoader.exists(filePath + fileName):
		highscoreList = ResourceLoader.load(filePath + fileName) as ScoreList

func save_highscores():
	if nameInput.text == "":
		return

	highscoreList.add_score_entry(nameInput.text, endTime)
	ResourceSaver.save(highscoreList, filePath + fileName)
	get_tree().call_deferred("change_scene_to_file", mainMenuScene)
