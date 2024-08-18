class_name ScaleContainer
extends SubViewportContainer

@export var tween_time: float = 0.2
@export var large_scale: Vector2 = Vector2(4, 4)

var tween: Tween
var target_modulate: Color
var target_scale: Vector2

func start(fade_in: bool, scale_increasing: bool) -> void:
	if fade_in:
		modulate = Color.TRANSPARENT
		target_modulate = Color.WHITE
		target_scale = Vector2.ONE
		if scale_increasing:
			scale = large_scale
		else:
			scale = Vector2.ZERO
	else:
		modulate = Color.WHITE
		target_modulate = Color.TRANSPARENT
		scale = Vector2.ONE
		if scale_increasing:
			target_scale = Vector2.ZERO
		else:
			target_scale = large_scale

func fade(fade_in: bool, scale_increasing: bool) -> void:
	start(fade_in, scale_increasing)
	
	if is_instance_valid(tween):
		tween.stop()
	tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(self, "modulate", target_modulate, tween_time)
	tween.tween_property(self, "scale", target_scale, tween_time)
