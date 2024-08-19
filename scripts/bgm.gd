extends AudioStreamPlayer

@export var time_factor: float = 0.2
var tween: Tween

func _on_focusing(index: int) -> void:
	if is_instance_valid(tween):
		tween.stop()
	tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	var target_volume_a: float
	var target_volume_b: float
	var tween_time_a: float
	var tween_time_b: float
	
	if index == 0:
		target_volume_a = -60
		target_volume_b = 0
		tween_time_a = time_factor * 20
		tween_time_b = time_factor
	else:
		target_volume_a = 0
		target_volume_b = -60
		tween_time_a = time_factor
		tween_time_b = time_factor * 20
	
	tween.tween_method(set_stream_a_volume, stream.get_sync_stream_volume(0), target_volume_a, tween_time_a)
	tween.tween_method(set_stream_b_volume, stream.get_sync_stream_volume(1), target_volume_b, tween_time_b)

func set_stream_a_volume(db: float) -> void:
	stream.set_sync_stream_volume(0, db)

func set_stream_b_volume(db: float) -> void:
	stream.set_sync_stream_volume(1, db)
