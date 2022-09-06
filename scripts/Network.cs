using Godot;

public class Network : Node {
    private readonly PackedScene _playerResource = (PackedScene) GD.Load("res://scenes/Player.tscn");

    public override void _Ready() {
        var tree = GetTree();

        tree.Connect("network_peer_connected", this, "OnNetworkPeerConnected");
        tree.Connect("network_peer_disconnected", this, "OnNetworkPeerDisconnected");
        tree.Connect("connected_to_server", this, "OnConnectedToServer");
        tree.Connect("server_disconnected", this, "OnServerDisconnected");
    }

    private void CreateServer(int port) {
        var peer = new NetworkedMultiplayerENet();

        peer.CreateServer(port);

        GetTree().NetworkPeer = peer;

        LoadGame();
    }

    private void JoinServer(string ip, int port, string username) {
        var peer = new NetworkedMultiplayerENet();

        peer.CreateClient(ip, port);

        GetTree().NetworkPeer = peer;
    }

    private async void LoadGame() {
        GetTree().ChangeScene("res://scenes/Game.tscn");

        await ToSignal(GetTree().CreateTimer(0.01f), "timeout");

        SpawnPlayer(GetTree().GetNetworkUniqueId());
    }

    private void SpawnPlayer(int id) {
        var playerInstance = _playerResource.Instance();

        playerInstance.Name = id.ToString();
        // playerInstance.translate(Vector3(0, 10, 0))
        playerInstance.SetNetworkMaster(id);

        // This line stays commented becauses it causes problems for some reason
        // GetNode("/root/Game/World/Players").AddChild(playerInstance);
        AddChild(playerInstance);
    }

    private void OnNetworkPeerConnected(int id) {
        SpawnPlayer(id);
    }

    private void OnNetworkPeerDisconnected(int id) {
        GetTree().Root.FindNode(id.ToString(), true, false).QueueFree();
    }

    private void OnConnectedToServer() {
        LoadGame();
    }

    private void OnServerDisconnected() {
        GetTree().ChangeScene("res://scenes/Main.tscn");
    }
}