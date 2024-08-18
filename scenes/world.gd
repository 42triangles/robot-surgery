extends Node2D

func _ready() -> void:
	$Scale1Container/Scale1Viewport/Scale1/Player/CustomRemoteTransform2D.target = \
		$Scale0Container/Scale0Viewport/Scale0/Environment/TileMapLayer
