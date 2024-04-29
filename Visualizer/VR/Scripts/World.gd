extends Node3D

# variables
var interface : XRInterface
var projection: MeshInstance3D
var teleportMesh: Area3D
var Player
var orgin: Node3D
var trees: Array
var active: int = 0
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
	
	# get refrences to child nodes
	projection = get_node("TeleportMesh/TeleportOrgin/TeleportProjection")
	teleportMesh = get_node("TeleportMesh")
	orgin = get_node("TeleportMesh/TeleportOrgin")
	
	trees.append(get_node("TeleportMesh/TeleportOrgin/Lorenzo"))
	trees.append(get_node("TeleportMesh/TeleportOrgin/Humans"))
	trees.append(get_node("TeleportMesh/TeleportOrgin/Dinosaurs"))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # using timer instead to control how often pos is updated

# transforms point cords to align with world mesh
func convertPos():
	var current: Vector3 = Player.teleportPos
	var scale: Vector3 = teleportMesh.scale
	return current * (scale * .25)

# checks if player is trying to teleport
func _on_timer_timeout():
	var ready = Player.meshEntered
	if (ready): # dict refrence so value is passed by refrence rather than value
		var pos = convertPos()
		projection.position = pos
		projection.visible = true
		var teleporting = Player.teleporting
		if (teleporting):
			Player.global_position = projection.global_position
		Player.teleporting = false
	else:
		projection.visible = false


func _on_player_swap_tree(index):
	active = index
	setTree()
	pass # Replace with function body.

func setTree():
	for t in trees:
		t.visible = false
	trees[active%len(trees)].vivisible = true
