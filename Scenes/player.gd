extends CharacterBody2D

@onready var sprite = $Sprite
@onready var gun = $Gun
@onready var player_camera = $PlayerCamera
@onready var gui = $PlayerCamera/GuiLayer/GUI
@onready var collision_shape = $CollisionShape2D
@onready var hurtbox = $Hurtbox

@export var speed := 150.0
@export var health := 12
var _initial_health : float
var _initial_speed : float
var size_multiplier : float = 1.0 :
	get = get_size_multiplier

# hurtbox is an area that can be hit by enemy
# monitoring a mask
# it only listens to incoming enemy hitboxes

func get_size_multiplier() -> float:
	return size_multiplier

func _ready() -> void:
	Manager.player = self
	_initial_health = health
	_initial_speed = speed
	gui.player = self
	player_camera.player = self
	
func _process(_delta: float) -> void:
	gui.update()
	player_camera.update()

func _physics_process(_delta):
	if health > 0:
		update_size_and_speed()
		
		if Input.is_action_just_pressed("shoot"):
			handle_shoot()
		
		var direction = Input.get_vector("left", "right", "up", "down")
		if direction:
			velocity = direction * speed
			
			sprite.play("walking")
			if velocity.x > 0:
				sprite.flip_h = false
				gun.position.x = 22
			elif velocity.x < 0:
				sprite.flip_h = true
				gun.position.x = -22
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)
			
			sprite.play("idle")

		move_and_slide()

func die() -> void:
	health = 0
	set_process_input(false)
	set_process_unhandled_input(false)
	visible = false
	collision_shape.disabled = true
	hurtbox.get_node("CollisionShape2D").disabled = true

func _on_hurtbox_body_entered(body):
	# will only work on enemies
	body.eat_player()
	call_deferred("die")

func handle_shoot() -> void:
	if health > 1:
		health -= 1
		gun.shoot()

func update_size_and_speed() -> void:
	size_multiplier = health / _initial_health
	scale = Vector2(1.0, 1.0) * size_multiplier
	speed = _initial_speed + _initial_speed * size_multiplier * 2
