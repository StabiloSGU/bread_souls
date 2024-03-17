extends Area2D


@onready var audio_stream_player = $AudioStreamPlayer2D


func _on_body_entered(body):
	audio_stream_player.play()
	Manager.player.win()

