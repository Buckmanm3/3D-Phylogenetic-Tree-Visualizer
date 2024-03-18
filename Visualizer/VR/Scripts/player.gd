extends Node3D
var teleportPoint: Area3D
var teleportMesh: Area3D
var meshEntered: bool = false
var teleportOrgin: Node3D
var teleportPos: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	teleportPoint = get_node("XROrigin3D/Right Controller/MeshInstance3D/Area3D")
	teleportMesh = get_node("XROrigin3D/Left Controller/MeshInstance3D/Area3D")
	teleportOrgin = get_node("XROrigin3D/Left Controller/MeshInstance3D/TeleportMesh/TeleportOrgin")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (meshEntered):
		print_debug("area entered")
		# getPos() currently crashes the application lol
	pass 


# TODO get position of teleport relative to 
func getPos():
	var pos = teleportPoint.global_position.distance_to(teleportOrgin.global_position)
	var scale = teleportMesh.scale
	# divide cordinates by the scale of our teleport mesh
	#pos.x = pos.x / scale.x
	#pos.y = pos.y / scale.y
	#pos.z = pos.z / scale.z
	# when translating to world mesh we will multiply the points by it's scale
	return pos


# called when teleport point on right hand enters teleport mesh on right
func _on_teleport_point_area_entered(area):
	meshEntered = true
	

# called when teleport point on right hand exits teleport mesh on left
func _on_area_3d_area_exited(area):
	meshEntered = false
