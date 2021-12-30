extends VBoxContainer

onready var port = $PortInput/PanelContainer/LineEdit.text

func _on_HostButton_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(int(port), 16)
	get_tree().network_peer = peer
	print("Hosting server at ", IP.get_local_addresses()[0], ":", port)
	get_tree().change_scene("res://scenes/Game.tscn")

func _on_BackButton_pressed(): get_tree().change_scene("res://ui/menus/Main.tscn")
