extends RichTextLabel


# Declare member variables here. Examples:
var fps = "0"
var frametime = "0s"
var objsinframe = "1"
var vertsinframe = "5"
var final_text = "..."


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	final_text = ""
	fps = str(Performance.get_monitor(Performance.TIME_FPS))
	frametime = str(Performance.get_monitor(Performance.TIME_PROCESS)) + "s"
	objsinframe = str(Performance.get_monitor(Performance.RENDER_OBJECTS_IN_FRAME))
	vertsinframe = str(Performance.get_monitor(Performance.RENDER_VERTICES_IN_FRAME))
	fps = "[b]FPS:[/b] " + fps + "\n"
	frametime = "[b]FrameTime:[/b] " + frametime + "\n"
	objsinframe = "[b]ObjsInFrame:[/b] " + objsinframe + "\n"
	vertsinframe = "[b]VertsInFrame:[/b] " + vertsinframe
	
	bbcode_text = fps + frametime + objsinframe + vertsinframe
