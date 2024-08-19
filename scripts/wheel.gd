extends Sprite2D

func _process(delta: float) -> void:
	rotation += owner.velocity.x * delta
