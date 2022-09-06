extends VBoxContainer

onready var port = $PortInput/PanelContainer/LineEdit.text

func _on_HostButton_pressed(): Network.CreateServer(int(port))
func _on_BackButton_pressed(): 
	var err = get_tree().change_scene("res://scenes/Main.tscn")
	
	assert(err == OK)
