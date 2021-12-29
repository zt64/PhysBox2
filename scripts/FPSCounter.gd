extends Label


# Declare member variables here. Examples:
var fps = "0"


# Called when the node enters the scene tree for the first time.
# I don't think we have to do anything here?
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fps = Performance.get_monitor(Performance.TIME_FPS)
	fps = str(fps)
	set_text(fps + " FPS")
