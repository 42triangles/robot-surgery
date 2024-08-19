extends Button

@export_file("*.tscn") var scene_path: String

func _ready() -> void:
	pressed.connect(_on_pressed)
	ResourceLoader.load_threaded_request(scene_path, "PackedScene")

func _on_pressed() -> void:
	var scene: PackedScene = ResourceLoader.load_threaded_get(scene_path)
	get_tree().change_scene_to_packed(scene)
