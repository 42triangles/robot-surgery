extends AudioStreamPlayer

@export var default_volume_db: float

var tween: Tween

func _process(delta: float) -> void:
	if abs(owner.movement) > 0 and not playing:
		play()
		if is_instance_valid(tween):
			tween.stop()
		tween = get_tree().create_tween()
		volume_db = -60
		tween.tween_property(self, "volume_db", default_volume_db, 0.2)
	elif owner.movement == 0 and playing:
		stop()
