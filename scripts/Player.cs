using Godot;

public class Player : RigidBody {
    [Export] public int JumpHeight = 2;
    [Export] public int Speed = 10;

    [Remote]
    public new void SetTransform(Transform transform) {
        Transform = transform;
    }

    public override void _PhysicsProcess(float delta) {
        var direction = Vector3.Zero;

        if (Input.IsKeyPressed((int) KeyList.A)) direction += Vector3.Left;
        else if (Input.IsKeyPressed((int) KeyList.D)) direction += Vector3.Right;

        if (Input.IsKeyPressed((int) KeyList.W)) direction += Vector3.Forward;
        else if (Input.IsKeyPressed((int) KeyList.S)) direction += Vector3.Back;

        direction = direction.Normalized();

        if (!IsNetworkMaster()) return;

        AddCentralForce(direction * Speed);
        RpcUnreliable("set_transform", Transform);
    }

    public override void _Input(InputEvent @event) {
        if (@event.IsActionPressed("ui_cancel"))
            Input.MouseMode = Input.MouseMode == Input.MouseModeEnum.Captured
                ? Input.MouseModeEnum.Visible
                : Input.MouseModeEnum.Captured;
    }
}