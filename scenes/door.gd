# Door Script - Interactive door that requires keys
extends StaticBody3D

@export var requires_keys = 1
@export var door_name = "Wooden Door"

var is_locked = true
var mesh_instance: MeshInstance3D

func _ready():
	# Get mesh for visual feedback
	mesh_instance = $MeshInstance3D
	update_visual_state()

func update_visual_state():
	"""Update door color based on lock state"""
	if mesh_instance:
		if is_locked:
			# Red tint for locked
			var material = StandardMaterial3D.new()
			material.albedo_color = Color.RED
			mesh_instance.set_surface_override_material(0, material)
		else:
			# Green tint for unlocked
			var material = StandardMaterial3D.new()
			material.albedo_color = Color.GREEN
			mesh_instance.set_surface_override_material(0, material)

func interact(player):
	"""Called when player interacts with door"""
	if is_locked:
		if player.inventory.size() >= requires_keys:
			unlock_door(player)
		else:
			print("Door is locked. Need ", requires_keys, " keys.")
	else:
		print("Door is open. You can pass.")

func unlock_door(player):
	"""Unlock door and remove keys from inventory"""
	for i in range(requires_keys):
		if player.inventory.size() > 0:
			player.inventory.pop_front()
	
	is_locked = false
	update_visual_state()
	print("🔓 Door unlocked!")
	# Play unlock animation here
