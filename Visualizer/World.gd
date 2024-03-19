extends Node3D

var interface : XRInterface
var pointPos: Vector3
var timer: Timer 
var meshEntered: bool
var projection: MeshInstance3D
var teleportMesh: Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# initalize VR
	get_viewport().use_xr = true
	interface = XRServer.find_interface("OpenXR")
	if interface and interface.is_initialized():
		print("XR scene correctly launched")
	else:
		print("Error VR incorrectly launched")
		
	# get refrences to player's script variables
	var player = get_node("Player")
	meshEntered = player.meshEntered
	pointPos = player.teleportPos
	timer = player.timer
	timer.connect("timeout", _timeout)
	
	# get refrences to child nodes
	projection = get_node("TeleportProjection")
	teleportMesh = get_node("TeleportMesh")
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# called when player tiemr runs out
func _timeout():
	if (meshEntered):
		projection.position = convertPos()
		projection.visible = true
	else:
		projection.visible = false

# transforms point cords to align with world mesh
func convertPos():
	var newPos: Vector3
	var scale = teleportMesh.scale
	newPos.x = pointPos.x * scale.x
	newPos.y = pointPos.y * scale.y
	newPos.z = pointPos.z * scale.z
	return newPos
	
