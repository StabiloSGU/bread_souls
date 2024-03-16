extends Area2D

var direction : Vector2
@export var speed := 500.0
@onready var crumb_sprite = $CrumbSprite

func _ready():
	top_level = true
	crumb_sprite.play("flying")
	look_at(position + direction)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(_body):
	queue_free()
