extends SubViewportContainer

@export var tween_time: float = 0.2
@export var large_scale: Vector2 = Vector2(4, 4)

var tween: Tween

func fade(fade_in: bool, scale_increasing: bool) -> void:
	var target_modulate: Color
	var target_scale: Vector2
	
	if fade_in:
		modulate = Color.TRANSPARENT
		target_modulate = Color.WHITE
		target_scale = Vector2.ONE
		if scale_increasing:
			scale = Vector2.ZERO
		else:
			scale = large_scale
	else:
		modulate = Color.WHITE
		target_modulate = Color.TRANSPARENT
		scale = Vector2.ONE
		if scale_increasing:
			target_scale = large_scale
		else:
			target_scale = Vector2.ZERO
	
	if is_instance_valid(tween):
		tween.stop()
	tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(self, "modulate", target_modulate, tween_time)
	tween.tween_property(self, "scale", target_scale, tween_time)
	
	if fade_in:
		show()
	else:
		tween.tween_callback(self.hide).set_delay(tween_time)
