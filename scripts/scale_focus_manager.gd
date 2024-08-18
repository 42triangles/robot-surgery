extends Node

@export var scale_layers: Array[ScaleLayer] = []
@export var scale_containers: Array[ScaleContainer] = []

var current_focus: int = 1:
	set(new_value):
		if new_value != current_focus:
			var scale_increasing = (new_value > current_focus)
			
			scale_layers[current_focus].unfocused.emit()
			scale_containers[current_focus].fade(false, scale_increasing)
			
			current_focus = new_value
			
			scale_layers[current_focus].focused.emit()
			scale_containers[current_focus].fade(true, scale_increasing)

func _ready() -> void:
	for scale_layer in scale_layers.slice(0, current_focus):
		scale_layer.unfocused.emit()
	for scale_container in scale_containers.slice(0, current_focus):
		scale_container.start(true, false)
	scale_layers[current_focus].focused.emit()
	for scale_layer in scale_layers.slice(current_focus + 1):
		scale_layer.unfocused.emit()
	for scale_container in scale_containers.slice(current_focus + 1):
		scale_container.start(true, true)

func toggle_focus() -> void:
	if current_focus == 0:
		current_focus = 1
	else:
		current_focus = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_scale"):
		toggle_focus()
