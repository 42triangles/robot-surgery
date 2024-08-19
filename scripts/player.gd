class_name Player
extends CharacterBody2D

@export var movement_scale: float = 100
@export var friction: float = 50
@export var max_speed: float = 600
@export var jump_power: float = 2000
@export_custom(PROPERTY_HINT_NONE, "suffix:°") var move_tip: float = 0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var movement: float = 0
var facing_left: bool = false:
	set(new_value):
		if new_value != facing_left:
			facing_left = new_value
			sprite.flip_h = facing_left
			sprite.play_backwards("rotate")

func _ready() -> void:
	sprite.animation_looped.connect(_on_sprite_animation_looped)
	sprite.animation_finished.connect(_on_sprite_animation_finished)

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
