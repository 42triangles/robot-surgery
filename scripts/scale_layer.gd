extends Node2D

signal focused
signal unfocused

func focus() -> void:
	focused.emit()
	show()
	
func unfocus() -> void:
	unfocused.emit()
	hide()
