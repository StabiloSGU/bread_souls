extends Node

var game_scene = load("res://Scenes/world.tscn")
var fail_slide = load("res://Scenes/fail_slide.tscn")
var ending_slide = load("res://Scenes/ending_slide.tscn")

var maze : TileMap
var player : CharacterBody2D
var player_alive : bool :
	get = is_player_alive

func is_player_alive() -> bool:
	if player.health > 0:
		return true
	else:
		return false

func start_game() -> void:
	get_tree().change_scene_to_packed(game_scene)

func fail() -> void:
	get_tree().change_scene_to_packed(fail_slide)
	
func win() -> void:
	get_tree().change_scene_to_packed(ending_slide)
