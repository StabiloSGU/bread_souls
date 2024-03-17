extends BaseState

# in this state enemy should scan area to the left and to the right of it
# with visual indication
# if it finds player, it stores player position and moves there hastly
# if no player is found it switches to idle

func enter() -> void:
	search()

func search() -> void:
	if Manager.is_player_alive():
		# turn on right scanner
		# check if player is already there
		var player_pos_right_cone_local : Vector2 = target_node.right_scanner.to_local(Manager.player.global_position)
		var right_col_poly : PackedVector2Array = target_node.right_scanner.get_node("CollisionPolygon2D").get_polygon() 
		if Geometry2D.is_point_in_polygon(player_pos_right_cone_local, right_col_poly):
			#if yes, switch to enraged state
			player_detected(Manager.player)
			return
		else:
			#if no play scanning animation
			target_node.animation_player.play("scanning_right")
			# connect to on body entered signal		
			target_node.right_scanner.connect('body_entered', player_detected)
			await target_node.animation_player.animation_finished
			target_node.right_scanner.disconnect('body_entered', player_detected)
		# the same to the left
		
		var player_pos_left_cone_local : Vector2 = target_node.left_scanner.to_local(Manager.player.global_position)
		var left_col_poly : PackedVector2Array = target_node.left_scanner.get_node("CollisionPolygon2D").get_polygon()
		if Geometry2D.is_point_in_polygon(player_pos_left_cone_local, left_col_poly):
			#if yes, switch to enraged state
			player_detected(Manager.player)
			return
		else:
			#if no play scanning animation
			target_node.animation_player.play("scanning_left")
			# connect to on body entered signal		
			target_node.left_scanner.connect('body_entered', player_detected)
			await target_node.animation_player.animation_finished
			target_node.left_scanner.disconnect('body_entered', player_detected)
		# if nothing happened change state to idle
	state_manager.change_state("Idle")

func player_detected(body) -> void:
	# if player enters vision cone during the scan play the animation RESET
	target_node.last_known_position = body.global_position
	target_node.animation_player.call_deferred("stop")
	target_node.call_deferred("reset_scanners")
	# then change state to enraged
	state_manager.change_state("Enraged")
