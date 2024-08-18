extends TextureRect

@export var target_viewport: Viewport

func _draw() -> void:
	texture = target_viewport.get_texture()
