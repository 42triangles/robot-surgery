extends Node2D

@export var target: Node2D = null
@export var relative_scale: float = 1

var last_target: Node2D = null
var offset: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	if target != null:
		if target != last_target:
			last_target = target
			offset = target.position - relative_scale * global_position
		target.global_rotation = global_rotation
		target.global_position = offset + relative_scale * global_position
		#target.transform = Transform2D(rotation, offset + relative_scale * position)
