extends Node

var maze : TileMap
var player : CharacterBody2D
var player_alive : bool :
	get = is_player_alive

func is_player_alive() -> bool:
	if player.health > 0:
		return true
	else:
		return false
