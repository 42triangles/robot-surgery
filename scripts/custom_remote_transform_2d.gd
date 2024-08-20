extends Node2D

@export var target_path: NodePath
@export var relative_scale: float = 1

@onready var target: Node2D = get_node(target_path)

var offset: Vector2

func _ready() -> void:
	if is_instance_valid(target):
		offset = target.global_position - relative_scale * global_position

func _process(_delta: float) -> void:
	if is_instance_valid(target):
		target.global_rotation = global_rotation
		target.global_position = offset + relative_scale * global_position

func update_offset_by_parent(old_position: Vector2, new_position: Vector2):
	offset -= new_position - old_position
