extends Node

@export var scale_layers: Array[ScaleLayer] = []
@export var scale_containers: Array[ScaleContainer] = []
@export var mini_views: Array[MiniView] = []

var current_focus: int = 1:
	set(new_value):
		if new_value != current_focus:
			var scale_increasing = (new_value > current_focus)
			
			scale_layers[current_focus].unfocused.emit()
			scale_containers[current_focus].fade(false, scale_increasing)
			mini_views[current_focus].fade(true)
			
			current_focus = new_value
			
			scale_layers[current_focus].focused.emit()
			scale_containers[current_focus].fade(true, scale_increasing)
			mini_views[current_focus].fade(false)

func _ready() -> void:
	assert(scale_layers.size() == scale_containers.size())
	assert(scale_layers.size() == mini_views.size())
	for index in range(scale_layers.size()):
		if index == current_focus:
			continue
		scale_layers[index].unfocused.emit()
		scale_containers[index].start(true, true)

func toggle_focus() -> void:
	if current_focus == 0:
		current_focus = 1
	else:
		current_focus = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_scale"):
		toggle_focus()
