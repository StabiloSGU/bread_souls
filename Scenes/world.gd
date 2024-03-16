extends Node2D
@onready var camera_2d = $Camera2D
@onready var player = $Player


func _process(delta: float) -> void:
	if has_node("Player"):
		camera_2d.global_position = player.global_position
