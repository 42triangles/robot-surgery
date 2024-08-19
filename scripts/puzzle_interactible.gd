class_name PuzzleInteractible extends Area2D

@export var signal_name: StringName
@export var toggleable: bool
@export var state: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var active: bool = false

func interact() -> void:
	if toggleable:
		state = !state
		if state == true:
			sprite.play("activate")
		else:
			sprite.play_backwards("activate")
		PuzzleRelay.emit_signal(signal_name, state)
	else:
		sprite.play("activate")
		if not sprite.animation_finished.is_connected(_auto_deactivate):
			sprite.animation_finished.connect(_auto_deactivate)
		PuzzleRelay.emit_signal(signal_name)

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if toggleable and (state == true):
		sprite.frame = sprite.sprite_frames.get_frame_count("activate") - 1
	else:
		sprite.frame = 0

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

func _auto_deactivate() -> void:
	sprite.play_backwards("activate")
	sprite.animation_finished.disconnect(_auto_deactivate)
