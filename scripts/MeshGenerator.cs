using Godot;
using Godot.Collections;

[Tool]
public class MeshGenerator : MeshInstance {
    [Export] public int RadialSegments = 10;
    [Export] public float Radius = 1;
    [Export] public int Rings = 10;

    public override void _Process(float delta) {
        var mesh = (ArrayMesh) Mesh;
        var arr = new Array();

        var verts = new Array<Vector3>();
        var uvs = new Array<Vector2>();
        var normals = new Array<Vector3>();
        var indices = new Array<int>();

        var thisRow = 0;
        var prevRow = 0;
        var point = 0;

        mesh.ClearSurfaces();

        for (var i = 0; i < Rings + 1; i++) {
            var v = i / Rings;
            var w = Mathf.Sin(Mathf.Pi * v);
            var y = Mathf.Cos(Mathf.Pi * v);

            for (var j = 0; j < RadialSegments; j++) {
                var u = j / RadialSegments;
                var x = Mathf.Sin(u * Mathf.Pi * 2f);
                var z = Mathf.Cos(u * Mathf.Pi * 2f);
                var vert = new Vector3(x * Radius * w, y, z * Radius * w);

                verts.Add(vert);
                normals.Add(vert.Normalized());
                uvs.Add(new Vector2(u, v));

                point++;

                if (i <= 0 || j <= 0) continue;

                indices.Add(prevRow + j - 1);
                indices.Add(prevRow + j);
                indices.Add(prevRow + j - 1);
                indices.Add(prevRow + j);
                indices.Add(prevRow + j);
                indices.Add(prevRow + j - 1);
            }

            if (i > 0) {
                indices.Add(prevRow + RadialSegments - 1);
                indices.Add(prevRow);
                indices.Add(thisRow + RadialSegments - 1);
                indices.Add(prevRow);
                indices.Add(prevRow + RadialSegments);
                indices.Add(thisRow + RadialSegments - 1);
            }

            prevRow = thisRow;
            thisRow = point;
        }

        arr[(int) Mesh.ArrayType.Vertex] = verts;
        arr[(int) Mesh.ArrayType.TexUv] = uvs;
        arr[(int) Mesh.ArrayType.Normal] = normals;
        arr[(int) Mesh.ArrayType.Index] = indices;

        mesh.AddSurfaceFromArrays(Mesh.PrimitiveType.Triangles, arr);
    }
}