class_name PuzzleInteractible extends Area2D

@export var signal_name: StringName
@export var toggleable: bool
@export var state: bool = false

var active: bool = false

func interact() -> void:
	if toggleable:
		state = !state
		PuzzleRelay.emit_signal(signal_name, state)
	else:
		PuzzleRelay.emit_signal(signal_name)

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		active = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		active = false

func _unhandled_input(event: InputEvent) -> void:
	if active:
		if event.is_action_pressed("interact"):
			interact()
			get_viewport().set_input_as_handled()
