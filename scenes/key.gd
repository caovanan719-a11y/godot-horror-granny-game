# Key Script - Collectible key item
extends Area3D

@export var key_name = "Key"
var player_ref = null

func _ready():
	# Connect area signals
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	"""Called when player touches key"""
	if body.name == "Player":
		collect(body)

func collect(player):
	"""Collect this key"""
	if player.has_method("add_to_inventory"):
		player.add_to_inventory(key_name)
		
		# Notify game manager
		var game_manager = get_tree().root.get_child(0)
		if game_manager.has_method("add_key"):
			game_manager.add_key()
	
	print("🔑 Collected: ", key_name)
	# Remove from scene
	queue_free()
