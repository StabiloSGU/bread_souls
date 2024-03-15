extends CharacterBody2D

@onready var sprite = $Sprite
@onready var gun = $Gun

const SPEED = 300.0

# hurtbox is an area that can be hit by enemy
# monitoring a mask
# it only listens to incoming enemy hitboxes

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		gun.shoot()
	
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = direction * SPEED
		
		sprite.play("walking")
		sprite.flip_h = velocity.x > 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
		sprite.play("idle")

	move_and_slide()

func die() -> void:
	queue_free()


func _on_hurtbox_body_entered(body):
	# will only work on enemies
	body.eat_player()
	die()
