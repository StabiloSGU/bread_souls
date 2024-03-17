extends CharacterBody2D
@onready var toaster_sprite = $ToasterSprite
@onready var munching = $Munching
@onready var animation_player = $AnimationPlayer
@onready var nav_collision = $CollisionShape2D
@onready var hurtbox_collision = $Hurtbox/CollisionShape2D
@onready var hitbox_collision = $Hitbox/CollisionShape2D
@onready var particles = $Particles
@onready var enemy_state_machine = $EnemyStateMachine
@onready var nav_agent = $NavigationAgent2D
@onready var state = $State
@onready var rage_light = $RageLight

@onready var right_scanner = $Scanners/RightScanner
@onready var left_scanner = $Scanners/LeftScanner

@export var speed := 100
@export var health := 3


# store players last known position
var last_known_position : Vector2

# target to wander to
var wander_target : Vector2

# hurtbox - place that can be hit by crumbs
# monitoring a mask
# it only listens to incoming crumb area hitbox

# hitbox - the area that player can be hit with
# monitorable on a layer
# it is detectable by player hurtbox

func _ready() -> void:
	reset_scanners()
	particles.emitting = false
	
	enemy_state_machine.init(self)
	munching.visible = false
	toaster_sprite.play("idle")
	
func reset_scanners() -> void:
	right_scanner.get_node("CollisionPolygon2D").disabled = true
	right_scanner.get_node("Line2D").visible = false
	left_scanner.get_node("CollisionPolygon2D").disabled = true
	left_scanner.get_node("Line2D").visible = false

func eat_player() -> void:
	animation_player.play("munching")

func die() -> void:
	nav_collision.disabled = true
	hurtbox_collision.disabled = true
	hitbox_collision.disabled = true
	toaster_sprite.play("death")
	await toaster_sprite.animation_finished
	queue_free()

func blink() -> void:
	pass


func _on_hurtbox_area_entered(_area):
	# will only work on bullets
	if health > 1:
		health -= 1
		blink()
	else:
		die()

func _process(delta: float) -> void:
	state.text = enemy_state_machine.current_state.name
	if health == 0:
		die()
	enemy_state_machine.process(delta)

func _physics_process(delta: float) -> void:
	enemy_state_machine.physics_process(delta)
