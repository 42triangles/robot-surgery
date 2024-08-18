extends Node2D

signal focused
signal unfocused

func focus(scale_increasing: bool) -> void:
	focused.emit()
	show()
	
func unfocus(scale_increasing: bool) -> void:
	unfocused.emit()
	hide()
