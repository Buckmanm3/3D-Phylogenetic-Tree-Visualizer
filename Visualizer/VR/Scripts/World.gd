extends Node3D

# variables
var interface : XRInterface
var projection: MeshInstance3D
var teleportMesh: Area3D
var teleport: Dictionary
var Player
var orgin: Node3D
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
	Player = get_node("Player")
	teleport = Player.teleport
	
	# get refrences to child nodes
	projection = get_node("TeleportProjection")
	teleportMesh = get_node("TeleportMesh")
	orgin = get_node("TeleportMesh/TeleportOrgin")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # using timer instead to control how often pos is updated

# transforms point cords to align with world mesh
func convertPos():
	var newPos: Vector3
	var current: Vector3 = Player.teleportPos
	var scale: Vector3 = teleportMesh.scale
	newPos = current.direction_to(orgin.global_position) * scale
	return newPos


# checks if player is trying to teleport
func _on_timer_timeout():
	var ready = Player.meshEntered
	if (ready): # dict refrence so value is passed by refrence rather than value
		projection.position = convertPos()
		projection.visible = true
	else:
		projection.visible = false
