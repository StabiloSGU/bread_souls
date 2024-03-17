extends Node2D
@onready var munch_sound_1 = $MunchSound1
@onready var munch_sound_2 = $MunchSound2
@onready var munch_sound_3 = $MunchSound3
var rng = RandomNumberGenerator.new()

func play_random_sound() -> void:
	rng.randomize()
	var sounds = [munch_sound_1, munch_sound_2, munch_sound_3]
	var sound = sounds[rng.randi() % sounds.size()]
	sound.play()
