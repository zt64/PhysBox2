extends Spatial

var players = { }

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")

	players[get_tree().get_network_unique_id()] = preload("res://scenes/Player.tscn").instance()

	for id in players:
		var playerInfo = players[id]
		var player = preload("res://scenes/Player.tscn").instance()

		player.transform = playerInfo.transform
		player.name = str(id)
		player.set_network_master(id)
		add_child(player)

func _player_connected(id): 
	print("Player connected: ", id)
	var player = preload("res://scenes/Player.tscn").instance()

	player.name = str(id)
	player.set_network_master(id)
	add_child(player)
	players[id] = player
	rpc_id(id, "register_player")
	
remote func register_player():
	var id = get_tree().get_rpc_sender_id()
	var player = preload("res://scenes/Player.tscn").instance()
	
	player.name = str(id)
	player.set_network_master(id)
	add_child(player)
	players[id] = player
