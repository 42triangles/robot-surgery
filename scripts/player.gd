extends CharacterBody2D


func _physics_process(delta: float) -> void:
	velocity += get_gravity()
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_right"):
		velocity.x = 50
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -50
	else:
		velocity.x = 0
	
	if Input.is_action_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = -500
