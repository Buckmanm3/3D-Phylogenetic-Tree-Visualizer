extends Node3D

# variables
var interface : XRInterface
var timer: Timer 
var projection: MeshInstance3D
var teleportMesh: Area3D
var teleport: Dictionary

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
	teleport = player.teleport
	timer = player.timer
	timer.connect("timeout", _timeout)
	
	# get refrences to child nodes
	projection = get_node("TeleportProjection")
	teleportMesh = get_node("TeleportMesh")
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# called when player's tiemr runs out
func _timeout():
	# check if mesh is entered if so toggle visible, update pos
	if (teleport["meshEntered"]):
		projection.position = convertPos()
		projection.visible = true
	else:
		projection.visible = false


# transforms point cords to align with world mesh
func convertPos():
	var newPos: Vector3
	var scale = teleportMesh.scale
	var pointPos = teleport["teleportPos"]
	newPos.x = pointPos.x * scale.x
	newPos.y = pointPos.y * scale.y
	newPos.z = pointPos.z * scale.z
	return newPos
	
