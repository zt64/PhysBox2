extends RigidBody

export var speed = 5
export var jumpHeight = 2

remote func _set_transform(pos): transform = pos

func _process(delta):
	var direction = Vector3()
	
	if Input.is_key_pressed(KEY_A): direction += Vector3.LEFT
	elif Input.is_key_pressed(KEY_D): direction += Vector3.RIGHT
	
	if Input.is_key_pressed(KEY_W): direction += Vector3.FORWARD
	elif Input.is_key_pressed(KEY_S): direction += Vector3.BACK
	
	direction = direction.normalized()
	if is_network_master(): 
		add_central_force(direction * speed)
		rpc_unreliable("_set_transform", transform)

func _input(event):
	if event is InputEventMouseMotion: pass
	
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == 2: Input.set_mouse_mode(0) # Free the mouse
		else: Input.set_mouse_mode(2)
