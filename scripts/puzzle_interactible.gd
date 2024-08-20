class_name PuzzleInteractible extends Area2D

@export var signal_name: StringName
@export var one_time_use: bool = false
@export var interact_on_collision: bool = false
@export var state: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var was_used: bool = false

func interact() -> void:
	if not one_time_use or not was_used:
		was_used = true
		audio.play()
		state = !state
		if state:
			sprite.play("activate")
		else:
			sprite.play_backwards("activate")
		PuzzleRelay.emit_signal(signal_name, state)

func _ready() -> void:
	if state:
		sprite.frame = sprite.sprite_frames.get_frame_count("activate") - 1
	else:
		sprite.frame = 0

func _auto_deactivate() -> void:
	sprite.play_backwards("activate")
	sprite.animation_finished.disconnect(_auto_deactivate)

func _on_body_entered(body: Node2D) -> void:
	if interact_on_collision and body is Player:
		interact()


func _on_body_exited(body: Node2D) -> void:
	if interact_on_collision and body is Player and state:
		interact()
