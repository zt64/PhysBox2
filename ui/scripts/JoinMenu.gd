extends VBoxContainer

func _ready():
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("connection_failed", self, "_connected_fail")

func _client_connected(id): get_tree().change_scene("res://scenes/Game.tscn")
func _connected_fail(id): print("Failed to connect")

func _on_BackButton_pressed(): get_tree().change_scene("res://scenes/Main.tscn")
func _on_JoinButton_pressed():
	var ip = $VBoxContainer/IPAddressInput/PanelContainer/LineEdit.text
	var port = $VBoxContainer/PortInput/PanelContainer/LineEdit.text

	Network.JoinServer(ip, int(port), "Test")
