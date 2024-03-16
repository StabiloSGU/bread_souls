extends BaseState


func enter() -> void:
	target_node.toaster_sprite.set_modulate(Color("df0000"))
	
func exit() -> void:
	target_node.toaster_sprite.set_modulate(Color("ffffff"))
	

func physics_process(_delta: float) -> void:
	target_node.velocity = target_node.position.direction_to(target_node.last_known_position) * target_node.speed
	if target_node.position.distance_to(target_node.last_known_position) > 10:
		target_node.move_and_slide()
	else:
		state_manager.change_state("SearchPlayer")
