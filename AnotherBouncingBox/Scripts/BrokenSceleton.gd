extends Node2D
class_name BrokenSceleton

@export var initialVelocityMultiplier: float = 1

@export var head: RigidBody2D
@export var lung: RigidBody2D
@export var pelvis: RigidBody2D
@export var Arm1: RigidBody2D
@export var Arm2: RigidBody2D
@export var Leg1: RigidBody2D
@export var Leg2: RigidBody2D

func set_velocity(velocity):
	print(velocity)
	head.linear_velocity = velocity * initialVelocityMultiplier
	lung.linear_velocity = velocity * initialVelocityMultiplier
	pelvis.linear_velocity = velocity * initialVelocityMultiplier
	Arm2.linear_velocity = velocity * initialVelocityMultiplier
	Arm1.linear_velocity = velocity * initialVelocityMultiplier
	Leg1.linear_velocity = velocity * initialVelocityMultiplier
	Leg2.linear_velocity = velocity * initialVelocityMultiplier

func set_flip_h(flip_h):
	head.get_node("Sprite2D").flip_h = flip_h
	lung.get_node("Sprite2D").flip_h = flip_h
	pelvis.get_node("Sprite2D").flip_h = flip_h
	Arm2.get_node("Sprite2D").flip_h = flip_h
	Arm1.get_node("Sprite2D").flip_h = flip_h
	Leg1.get_node("Sprite2D").flip_h = flip_h
	Leg2.get_node("Sprite2D").flip_h = flip_h
