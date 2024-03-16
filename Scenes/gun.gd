extends Node2D

var crumb_scene := load("res://Scenes/crumb.tscn")
var player : CharacterBody2D

func _ready():
	player = get_parent()


func shoot() -> void:
	var new_crumb = crumb_scene.instantiate()
	new_crumb.global_position = global_position
	new_crumb.direction = player.global_position.direction_to(global_position)
	add_child(new_crumb)
