class_name BaseState
extends Node

var target_node : CharacterBody2D
var state_manager : EnemyStateMachine

func enter() -> void:
	pass

func exit() -> void:
	pass

func input(_event: InputEvent) -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass
