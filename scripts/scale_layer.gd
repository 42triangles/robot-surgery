extends Node2D

signal focused
signal unfocused

func focus(scale_increasing: bool) -> void:
	focused.emit()
	$"../..".fade(true, scale_increasing)
	
func unfocus(scale_increasing: bool) -> void:
	unfocused.emit()
	$"../..".fade(false, scale_increasing)
