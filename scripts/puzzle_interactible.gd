class_name PuzzleInteractible extends Area2D

@export var signal_name: StringName
@export var toggleable: bool
@export var one_time_use: bool = false
@export var state: bool = false
@export var interact_on_collision: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var was_used: bool = false

func actual_interact() -> void:
	audio.play()
	if toggleable:
		state = !state
		if state == true:
			sprite.play("activate")
		else:
			sprite.play_backwards("activate")
		PuzzleRelay.emit_signal(signal_name, state)
	else:
		sprite.play("activate")
		if not one_time_use:
			if not sprite.animation_finished.is_connected(_auto_deactivate):
				sprite.animation_finished.connect(_auto_deactivate)
		PuzzleRelay.emit_signal(signal_name)
	if one_time_use:
		remove_from_group("interactibles")
	
func interact() -> void:
	if not interact_on_collision:
		if not one_time_use or not was_used:
			was_used = true
			actual_interact()

func _ready() -> void:
	if toggleable and (state == true):
		sprite.frame = sprite.sprite_frames.get_frame_count("activate") - 1
	else:
		sprite.frame = 0

func _auto_deactivate() -> void:
	sprite.play_backwards("activate")
	sprite.animation_finished.disconnect(_auto_deactivate)


func _on_body_entered(body: Node2D) -> void:
	if interact_on_collision and (body is Player or body is Box):
		actual_interact()


func _on_body_exited(body: Node2D) -> void:
	if interact_on_collision and not one_time_use and state:
		if get_overlapping_bodies().all(func (x): return x is not Player and x is not Box):
			actual_interact()
