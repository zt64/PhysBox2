extends VBoxContainer

func _ready():
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("connection_failed", self, "_connected_fail")

func _on_BackButton_pressed(): get_tree().change_scene("res://ui/menus/Main.tscn")

func _on_HostButton_pressed():
	var ip = $VBoxContainer/IPAddressInput/PanelContainer/LineEdit.text
	var port = $VBoxContainer/PortInput/PanelContainer/LineEdit.text
	
	var peer = NetworkedMultiplayerENet.new()
	
	match peer.create_client(ip, int(port)):
		OK: print("Client created")
		ERR_CANT_CREATE: return print("Failed to create client")
		ERR_ALREADY_IN_USE: return print("Already in use")
	
	get_tree().network_peer = peer

func _client_connected(id): get_tree().change_scene("res://scenes/Game.tscn")
	
func _connected_fail(id): print("Failed to connect")

func _on_LineEdit_text_changed(new_text):
	pass # Replace with function body.
