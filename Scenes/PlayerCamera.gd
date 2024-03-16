extends Camera2D

var player : CharacterBody2D
var _initial_zoom : Vector2
@export var scale_multiplier : float = 0.9


func _ready() -> void:
	_initial_zoom = zoom

func update() -> void:
	zoom = _initial_zoom - Vector2(scale_multiplier, scale_multiplier) * player.size_multiplier
