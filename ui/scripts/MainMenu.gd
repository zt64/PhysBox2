extends VBoxContainer

func _on_HostButton_pressed(): get_tree().change_scene("res://ui/menus/Host.tscn")
func _on_JoinButton_pressed(): get_tree().change_scene("res://ui/menus/Join.tscn")
func _on_ExitButton_pressed(): get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
