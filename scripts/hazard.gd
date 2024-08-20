extends Area2D

func entered(body: Node2D) -> void:
	if body is Player:
		body.die()
