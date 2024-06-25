extends Node2D

@export var follow: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if follow == null:
		follow = get_node("../PlayerBody")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x = follow.global_position.x
