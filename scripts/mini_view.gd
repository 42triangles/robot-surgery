class_name MiniView extends TextureRect

@export var target_viewport: Viewport

var tween: Tween

func fade(is_visible: bool) -> void:
	var target_modulate: Color
	if is_visible:
		modulate = Color.TRANSPARENT
		target_modulate = Color.WHITE
	else:
		modulate = Color.WHITE
		target_modulate = Color.TRANSPARENT
	
	if is_instance_valid(tween):
		tween.stop()
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", target_modulate, 0.2)
	
	show()
	if not is_visible:
		tween.tween_callback(self.hide)

func _draw() -> void:
	texture = target_viewport.get_texture()
