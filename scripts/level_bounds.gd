extends Area2D

func exited(body: Node2D) -> void:
	if body is Player:
		body.die()
