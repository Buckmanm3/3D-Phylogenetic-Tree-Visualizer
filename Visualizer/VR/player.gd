extends Node3D
var teleportPoint: Area3D
var teleportMesh: Area3D
var meshEntered: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	teleportPoint = get_node("XROrigin3D/Right Controller/MeshInstance3D/Area3D")
	teleportMesh = get_node("XROrigin3D/Left Controller/MeshInstance3D/Area3D")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (meshEntered):
		print_debug("area entered")
	pass 


# called when teleport point on right hand enters teleport mesh on right
func _on_area_3d_body_entered(body):
	meshEntered = true


# called when teleport point on right hand exits teleport mesh on left
func _on_area_3d_area_exited(area):
	meshEntered = false
