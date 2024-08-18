extends CharacterBody2D

@export var movement_scale: float = 100
@export var friction: float = 50
@export var max_speed: float = 600
@export var jump_power: float = 2000

var movement: float

func _ready() -> void:
	set_process_unhandled_input(false)

func _process(delta: float) -> void:
	velocity += get_gravity()
	
	var speed_x = abs(velocity.x)
	if is_on_floor():
		speed_x -= friction * (delta * 60)
	speed_x = clamp(speed_x, 0, max_speed)
	
	velocity.x = speed_x * sign(velocity.x)
	
	velocity.x += movement * movement_scale * (delta * 60)
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("move_left") or event.is_action("move_right"):
		movement = Input.get_axis("move_left", "move_right")
		get_viewport().set_input_as_handled()
	
	if event.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = -1 * jump_power
		get_viewport().set_input_as_handled()

func _on_scale_layer_focused() -> void:
	set_process_unhandled_input(true)

func _on_scale_layer_unfocused() -> void:
	set_process_unhandled_input(false)
