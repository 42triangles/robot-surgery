class_name Player
extends CharacterBody2D

signal jumping
signal died(old_position: Vector2, new_position: Vector2)

@export var movement_scale: float = 100
@export var friction: float = 50
@export var max_speed: float = 600
@export var jump_power: float = 2000
@export_custom(PROPERTY_HINT_NONE, "suffix:°") var move_tip: float = 0
@export var checkpoint: Checkpoint
@export var has_to_flip: Array[Node2D] = []

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var movement: float = 0
var facing_left: bool = false:
	set(new_value):
		if new_value != facing_left:
			facing_left = new_value
			for i in has_to_flip:
				i.scale.x = -i.scale.x
				i.position.x = -i.position.x
			sprite.flip_h = facing_left
			sprite.play_backwards("rotate")

func _ready() -> void:
	sprite.animation_looped.connect(_on_sprite_animation_looped)
	sprite.animation_finished.connect(_on_sprite_animation_finished)
	
	if checkpoint == null:
		checkpoint = load("res://scenes/checkpoint.tscn").instantiate()
		checkpoint.position = position
		checkpoint.facing_left = facing_left
		get_parent().find_child("Environment").add_child(checkpoint)

func _process(delta: float) -> void:
	velocity += get_gravity()
	
	velocity.x += movement * movement_scale * (delta * 60)
	
	var speed_x = abs(velocity.x)
	if is_on_floor() and abs(movement) < 0.01:
		speed_x -= friction * (delta * 60)
	speed_x = clamp(speed_x, 0, max_speed)
	
	velocity.x = speed_x * sign(velocity.x)
	
	rotation_degrees = velocity.x / max_speed * move_tip
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("move_left") or event.is_action("move_right"):
		movement = Input.get_axis("move_left", "move_right")
		
		if movement > 0:
			facing_left = false
		elif movement < 0:
			facing_left = true
		
		if movement != 0 and sprite.animation == "default":
			sprite.play("walk")
		get_viewport().set_input_as_handled()
	
	if event.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = -1 * jump_power
			if sprite.animation == "jump":
				sprite.stop()
			sprite.play("jump")
			jumping.emit()
		get_viewport().set_input_as_handled()

func _on_scale_layer_unfocused() -> void:
	movement = 0

func _on_sprite_animation_finished() -> void:
	if movement != 0:
		sprite.play("walk")
	else:
		sprite.play("default")

func _on_sprite_animation_looped() -> void:
	if sprite.animation == "walk" and movement == 0:
		sprite.play("default")

func _on_interaction_area_interacting() -> void:
	sprite.play("interact")

func die() -> void:
	var old_position = global_position
	
	global_position = checkpoint.global_position
	velocity = Vector2.ZERO
	rotation = 0
	movement = 0
	facing_left = checkpoint.facing_left
	
	died.emit(old_position, global_position)
