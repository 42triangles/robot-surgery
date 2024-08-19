extends AnimatedSprite2D

@export var walk_sfx_frames: Array[int] = []

@onready var steps_audio: AudioStreamPlayer = $StepsAudio

func _ready() -> void:
	frame_changed.connect(_on_frame_changed)
	animation_changed.connect(_on_animation_changed)

func _on_frame_changed() -> void:
	if animation == "walk" and frame in walk_sfx_frames:
		steps_audio.play()
	elif frame == 0 and animation == "jump":
		steps_audio.play()

func _on_animation_changed() -> void:
	if animation == "jump" or animation == "rotate":
		steps_audio.play()
