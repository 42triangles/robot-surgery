extends Node

@export var scale_layers: Array[Node] = []

var current_focus: int = 1:
	set(new_value):
		if new_value != current_focus:
			var scale_increasing = (new_value > current_focus)
			scale_layers[current_focus].unfocus(scale_increasing)
			current_focus = new_value
			scale_layers[current_focus].focus(scale_increasing)

func _ready() -> void:
	for scale_layer in scale_layers:
		scale_layer.hide()
		scale_layer.unfocused.emit()
	scale_layers[current_focus].show()
	scale_layers[current_focus].focused.emit()

func toggle_focus() -> void:
	if current_focus == 0:
		current_focus = 1
	else:
		current_focus = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_scale"):
		toggle_focus()
