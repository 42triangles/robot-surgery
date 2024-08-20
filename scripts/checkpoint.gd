class_name Checkpoint
extends Area2D

@export var facing_left: bool = false


func entered(body: Node2D) -> void:
	if body is Player:
		body.checkpoint = self
