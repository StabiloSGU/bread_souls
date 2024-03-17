extends BaseState

# in this state enemy should be thinking about what to do next, wander or search for player
# enemy would idle for idling_time seconds
# then decide to either search for player or wander around
# searching will only be available if the enemy has last known position
@export var idling_time : float = 2.0
var rng = RandomNumberGenerator.new()

func enter() -> void:
	# would need rework for more than one enemy type
	target_node.toaster_sprite.play("idle")
	#target_node.thinking_sprite.play("thinking")
	await get_tree().create_timer(idling_time).timeout
	make_decision()

func make_decision() -> void:
	rng.randomize()
	var actions = ['Idle', 'Wander', 'SearchPlayer']
	var decision = actions[rng.randi() % actions.size()]
	state_manager.change_state(decision)
	
