extends Control
@onready var counter = $Health/Counter
@onready var animation_player = $AnimationPlayer

var player : CharacterBody2D


func update() -> void:
	counter.text = str(player.health)

func fade_in() -> void:
	animation_player.play("fadein")
