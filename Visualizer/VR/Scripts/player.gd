extends Node3D

# variables:
var teleportPoint: Node3D
var teleportMesh: Area3D
var meshEntered: bool = false
var teleportOrgin: Node3D
var teleportPos: Vector3
var timer: Timer
var teleport: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	teleportPoint = get_node("XROrigin3D/Right Controller/MeshInstance3D/TeleportPoint/TPPoint")
	teleportMesh = get_node("XROrigin3D/Left Controller/MeshInstance3D/TeleportMesh")
	teleportOrgin = get_node("XROrigin3D/Left Controller/MeshInstance3D/TeleportMesh/TeleportOrgin")
	# initalize timer to control how often we check the pos of teleport point
	
	meshEntered = false # for whatever reason this is intialized to True at start
	
	# setup dictonary to pass vars to world scene
	teleport = {
		"teleportPos":teleportPos,
		"meshEntered":meshEntered
	}
	pass


# called by timer node created in _ready()
func _timeout():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass  # using timer signal rather than delta


func getPos():
	var scale = teleportMesh.scale
	var pos = teleportPoint.global_position.direction_to(teleportOrgin.global_position) / scale
	return pos


# called when teleport point on right hand enters teleport mesh on right
func _on_teleport_point_area_entered(area):
	meshEntered = true
	


# called when teleport point on right hand exits teleport mesh on left
func _on_area_3d_area_exited(area):
	meshEntered = false


func _on_right_controller_button_pressed(name):
	if name == "ax_button": # right A button
		pass
	if name == "by_button": # right B button 
		pass
	pass # Replace with function body.



func _on_timer_timeout():
	if (meshEntered == true):
		teleportPos = getPos()
	pass 
