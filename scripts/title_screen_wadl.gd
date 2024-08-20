extends AnimatableBody2D

@export var time_between_impulses: float = 3
@export var shake_scale: float = 50

var tween: Tween
var elapsed: float = 0

func _process(delta: float) -> void:
	elapsed += delta
	if elapsed >= time_between_impulses:
		elapsed = 0
		shake()

func shake() -> void:
	var direction: Vector2 = Vector2(randf_range(-1, 1), randf_range(-1, 0)).normalized()
	var offset: Vector2 = direction * shake_scale
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", position + offset, 0.1)
	tween.tween_property(self, "position", position, 0.1)
