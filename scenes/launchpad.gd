extends Area2D

@export var velocity: Vector2 = 3000 * Vector2.UP

var entered: Array[PhysicsBody2D] = []

func launch(object: PhysicsBody2D) -> void:
	if entered.has(object):
		return

	if object is CharacterBody2D:
		object.velocity += velocity
	elif object is RigidBody2D:
		object.linear_velocity += velocity
	
	entered.append(object)

func try_launch(object: Node2D) -> void:
	# TODO: There has to be a better way of handling this.... but as is, new types can just be added here
	if object is Player:
		launch(object)

func launch_done(body: Node2D) -> void:
	if body is PhysicsBody2D:
		entered.erase(body)
