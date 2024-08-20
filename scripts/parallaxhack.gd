extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"../Parallax2D".scroll_offset = global_position * $"../Parallax2D".scroll_scale
