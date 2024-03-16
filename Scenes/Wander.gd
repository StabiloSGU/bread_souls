extends BaseState

# in this state enemy should walk to a random point
# enemy should wander around for wandering_time seconds
# then switch back to idle for new instructions
# wandering time could be generated at random
@export var wandering_time : float = 5.0
var rng = RandomNumberGenerator.new()

func enter() -> void:
	#target_node.get_new_map_target()
	rng.randomize()
	wandering_time = rng.randf_range(3.0, 7.0)
	print('im going to wander for ', wandering_time)
	await get_tree().create_timer(wandering_time).timeout
	done_wandering()

func done_wandering() -> void:
	state_manager.change_state("Idle")

func physics_process(_delta: float) -> void:
	# move to target
	pass
