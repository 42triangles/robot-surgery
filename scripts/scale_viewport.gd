extends SubViewport

func _on_focused() -> void:
	gui_disable_input = false

func _on_unfocused() -> void:
	gui_disable_input = true
