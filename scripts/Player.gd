extends KinematicBody

export var speed = 5
export var jumpHeight = 2

var direction = Vector3()

func _ready(): pass

func _input(event):
	if event is InputEventKey: match ((event as InputEventKey).key):
		KEY_W: print("W")
		KEY_A: print("A")
		KEY_S: print("S")
		KEY_D: print("D")
	pass
