extends Node2D

@export var relative_scale: float = 1

@onready var target: Node2D = $"/root/World/Scale0Container/Scale0Viewport/Scale0/Environment"

var offset: Vector2

func _ready() -> void:
	if is_instance_valid(target):
		offset = target.position - relative_scale * global_position

func _process(delta: float) -> void:
	if is_instance_valid(target):
		target.global_rotation = global_rotation
		target.global_position = offset + relative_scale * global_position
