extends RigidBody

export var speed = 1
export var jumpHeight = 2

var direction = Vector3()

func _ready(): pass

remote func _set_position(pos):
	global_transform = pos

func _physics_process(delta):
	direction = Vector3()
	
	if Input.is_key_pressed(KEY_A): direction -= transform.basis.x
	elif Input.is_key_pressed(KEY_D): direction += transform.basis.x
	
	if Input.is_key_pressed(KEY_W): direction += transform.basis.y
	elif Input.is_key_pressed(KEY_S): direction -= transform.basis.y
	
	direction = direction.normalized()
	if is_network_master():
		translate(direction * speed)
		rpc_unreliable("_set_position", global_transform)
#	if direction != Vector3():
	pass
