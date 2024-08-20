class_name CustomRemoteTransform2D
extends Node2D

@export var target_path: NodePath
@export var relative_scale: float = 1

@onready var target: Node2D = get_node(target_path)

var offset: Vector2

func recalculate_offset() -> void:
	offset = target.global_position - relative_scale * global_position

func _ready() -> void:
	if is_instance_valid(target):
		recalculate_offset()

func _process(_delta: float) -> void:
	if is_instance_valid(target):
		target.global_rotation = global_rotation
		target.global_position = offset + relative_scale * global_position
