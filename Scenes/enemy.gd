extends CharacterBody2D
@onready var toaster_sprite = $ToasterSprite
@onready var munching = $Munching
@onready var animation_player = $AnimationPlayer
@onready var nav_collision = $CollisionShape2D
@onready var hurtbox_collision = $Hurtbox/CollisionShape2D
@onready var hitbox_collision = $Hitbox/CollisionShape2D

@export var health := 3

# hurtbox - place that can be hit by crumbs
# monitoring a mask
# it only listens to incoming crumb area hitbox

# hitbox - the area that player can be hit with
# monitorable on a layer
# it is detectable by player hurtbox

func _ready() -> void:
	munching.visible = false
	toaster_sprite.play("idle")

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
	print('enemy hit!')


func _on_hurtbox_area_entered(area):
	# will only work on bullets
	if health > 1:
		health -= 1
		blink()
	else:
		die()
