extends Control
@onready var counter = $Health/Counter

var player : CharacterBody2D


func update() -> void:
	counter.text = str(player.health)
