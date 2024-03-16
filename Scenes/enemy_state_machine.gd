class_name EnemyStateMachine
extends Node

@export var current_state : BaseState

func init(target_node: CharacterBody2D) -> void:
	for child in get_children():
		child.target_node = target_node
		child.state_manager = self
	if current_state:
		change_state(current_state.name)

func change_state(new_state: String) -> void:
	current_state.exit()
	current_state = get_node(new_state)
	current_state.enter()

func _input(event: InputEvent) -> void:
	current_state.input(event)

func process(delta: float) -> void:
	current_state.process(delta)

func physics_process(delta: float) -> void:
	current_state.physics_process(delta)
