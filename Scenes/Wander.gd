extends BaseState

# in this state enemy should walk to a random point
# enemy should wander around for wandering_time seconds
# then switch back to idle for new instructions
# wandering time could be generated at random
@export var wandering_time : float = 5.0
var rng = RandomNumberGenerator.new()

func enter() -> void:
	get_new_map_target()
	rng.randomize()
	target_node.nav_agent.target_position = target_node.wander_target
	target_node.nav_agent.connect('target_reached', done_wandering)

func exit() -> void:
	target_node.nav_agent.disconnect('target_reached', done_wandering)

func done_wandering() -> void:
	state_manager.change_state("Idle")

func physics_process(_delta: float) -> void:
	var dir = target_node.to_local(target_node.nav_agent.get_next_path_position()).normalized()
	target_node.velocity = dir * target_node.speed
	target_node.move_and_slide()

func get_new_map_target() -> void:
	target_node.wander_target = Manager.maze.get_random_point_in_radius(target_node.global_position)
