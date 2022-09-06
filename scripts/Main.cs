using Godot;

public class Main : Control {
    public void OnHostButtonPressed() {
        GetTree().ChangeScene("res://ui/menus/Host.tscn");
    }

    public void OnJoinButtonPressed() {
        GetTree().ChangeScene("res://ui/menus/Join.tscn");
    }

    public void OnExitButtonPressed() {
        GetTree().Notification(NotificationWmQuitRequest);
    }
}