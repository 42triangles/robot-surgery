extends Area2D

@export var scene: PackedScene

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_packed.call_deferred(scene)
