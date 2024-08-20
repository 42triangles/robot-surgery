extends Area2D

@export var velocity: Vector2 = 3000 * Vector2.UP
@export var cooldown: float = 1

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var cooldown_remaining: float = 0

var entered: Array[PhysicsBody2D] = []

func _process(delta: float) -> void:
	if cooldown_remaining > 0:
		cooldown_remaining -= delta

func _on_body_entered(body: Node2D) -> void:
	if cooldown_remaining <= 0:
		if body is Player:
			body.velocity += velocity
			sprite.play("activate")
			cooldown_remaining = cooldown
