extends Node2D
@onready var flick_1 = $Flick1
@onready var flick_2 = $Flick2
@onready var flick_3 = $Flick3
@onready var flick_4 = $Flick4
@onready var flick_5 = $Flick5
@onready var flick_6 = $Flick6
@onready var flick_7 = $Flick7
@export var max_distance : int = 400
var rng = RandomNumberGenerator.new()

func _ready():
	for child in get_children():
		child.max_distance = max_distance

func play_random_sound() -> void:
	rng.randomize()
	var sounds = [flick_1, flick_2, flick_3, flick_4, flick_5, flick_6, flick_7]
	var sound = sounds[rng.randi() % sounds.size()]
	sound.play()
