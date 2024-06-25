extends Resource
class_name ScoreList

@export var names: Array[String]
@export var scores: Array[int]

func add_score_entry(name: String, score: int):
	names.append(name)
	scores.append(score)
