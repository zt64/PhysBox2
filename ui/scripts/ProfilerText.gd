extends RichTextLabel

var fps = "0"
var frametime = "0s"
var objsinframe = "1"
var vertsinframe = "5"

func _ready(): pass

func _process(_delta):
	fps = str(Performance.get_monitor(Performance.TIME_FPS))
	frametime = str(Performance.get_monitor(Performance.TIME_PROCESS)) + "s"
	objsinframe = str(Performance.get_monitor(Performance.RENDER_OBJECTS_IN_FRAME))
	vertsinframe = str(Performance.get_monitor(Performance.RENDER_VERTICES_IN_FRAME))

	fps = "[b]FPS:[/b] " + fps + "\n"
	frametime = "[b]FrameTime:[/b] " + frametime + "\n"
	objsinframe = "[b]ObjsInFrame:[/b] " + objsinframe + "\n"
	vertsinframe = "[b]VertsInFrame:[/b] " + vertsinframe

	bbcode_text = fps + frametime + objsinframe + vertsinframe