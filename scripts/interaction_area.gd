extends Area2D

signal interacting

@onready var interact_audio: AudioStreamPlayer = $AudioStreamPlayer

var active_interactibles: Array[Area2D] = []

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if not active_interactibles.is_empty():
			active_interactibles[0].interact()
			interacting.emit()
			interact_audio.play()
		get_viewport().set_input_as_handled()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("interactibles"):
		active_interactibles.append(area)

func _on_area_exited(area: Area2D) -> void:
	if area in active_interactibles:
		active_interactibles.erase(area)
