extends Node2D

@export var signal_name: StringName
@export var toggleable: bool
@export var displacement: Vector2

@onready var start_position: Vector2 = position

var active: bool = false
var tween: Tween

func _ready() -> void:
	if toggleable:
		PuzzleRelay.connect(signal_name, _on_signal.unbind(1))
	else:
		PuzzleRelay.connect(signal_name, _on_signal)

func _on_signal() -> void:
	active = !active
	
	var target_position: Vector2 = start_position
	if active:
		target_position += displacement
	
	if is_instance_valid(tween):
		tween.stop()
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_position, 0.2)
