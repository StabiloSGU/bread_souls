extends Node2D

@onready var light = $Light
@onready var shadow = $Shadow
@onready var timer = $Timer
@onready var sounds = $Sounds

var rng = RandomNumberGenerator.new()
var current_state := false

func _ready() -> void:
	switch(current_state)

func switch(state) -> void:
	if state:
		sounds.play_random_sound()
	light.visible = state
	shadow.visible = state




func _on_timer_timeout():
	current_state = !current_state
	timer.wait_time = rng.randf_range(0.1, 1.0)
	timer.start()
	switch(current_state)
