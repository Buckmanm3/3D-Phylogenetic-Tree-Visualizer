extends Node3D

# vavariables:
var teleportPoint: Node3D
var meshEntered: bool = false
var teleportOrgin: Node3D
var teleportPos: Vector3
var teleporting: bool = false
var trees:Array
var active:int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	# teleport point and orgin
	teleportPoint = get_node("XROrigin3D/Right Controller/MeshInstance3D/TeleportPoint/TPPoint")
	teleportOrgin = get_node("XROrigin3D/Left Controller/MeshInstance3D/TeleportMesh/TeleportOrgin")
	
	# trees
	trees.append(get_node("XROrigin3D/Left Controller/MeshInstance3D/TeleportMesh/TeleportOrgin/Lorenzo"))
	trees.append(get_node("XROrigin3D/Left Controller/MeshInstance3D/TeleportMesh/TeleportOrgin/Humans"))
	trees.append(get_node("XROrigin3D/Left Controller/MeshInstance3D/TeleportMesh/TeleportOrgin/Dinosaurs"))
	trees.append(get_node("XROrigin3D/Left Controller/MeshInstance3D/TeleportMesh/TeleportOrgin/MMcLaurin"))

# called by timer node created in _ready()
func _timeout():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass  # using timer signal rather than delta

func setTree():
	for t in trees:
		t.visible = false
	trees[active%len(trees)].visible = true

func getPos():
	return ((teleportOrgin.global_position - teleportPoint.global_position) / scale) * -1


# called when teleport point on right hand enters teleport mesh on right
func _on_teleport_point_area_entered(area):
	meshEntered = true


# called when teleport point on right hand exits teleport mesh on left
func _on_area_3d_area_exited(area):
	meshEntered = false


func _on_right_controller_button_pressed(name):
	if name == "ax_button": # right A button
		teleporting = true
		return
	if name == "by_button": # right B button 
		active += 1
		setTree()
		swap_tree.emit(active)


func _on_timer_timeout():
	if (meshEntered == true):
		teleportPos = getPos()
	return 

signal swap_tree(index: int)
	
