# Main Game Manager - Handles game logic, levels, and state
extends Node3D

# Scene references
@onready var player = $Player
@onready var ghost = $Ghost
@onready var ui_manager = $UIManager

# Game state variables
var level = 1
var keys_collected = 0
var keys_needed = 1
var game_over = false
var game_won = false
var player_health = 100
var is_paused = false

# Ghost behavior variables
var ghost_speed = 3.0
var ghost_detection_range = 20.0

func _ready():
	# Initialize game
	set_level_difficulty(level)
	update_hud()
	print("Game Started - Level ", level)

func _process(delta):
	if not game_over and not game_won:
		# Check win condition
		if keys_collected >= keys_needed and player.is_at_exit:
			win_game()
	
		# Update ghost behavior
		update_ghost_behavior(delta)
	
		# Check ghost collision with player
		if ghost.global_position.distance_to(player.global_position) < 2.0:
			player_take_damage(10)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func set_level_difficulty(lv):
	"""Set difficulty based on level"""
	if lv == 1:
		keys_needed = 1
		ghost_speed = 3.0
		ghost_detection_range = 15.0
	elif lv == 2:
		keys_needed = 2
		ghost_speed = 4.5
		ghost_detection_range = 20.0
	elif lv >= 3:
		keys_needed = 3
		ghost_speed = 6.0
		ghost_detection_range = 25.0

func add_key():
	"""Called when player collects a key"""
	keys_collected += 1
	print("Key collected! ", keys_collected, "/", keys_needed)
	update_hud()
	if keys_collected >= keys_needed:
		ui_manager.show_message("Find the exit!")

func player_take_damage(damage):
	"""Handle player taking damage from ghost"""
	player_health -= damage
	update_hud()
	ui_manager.show_fear_effect()
	
	if player_health <= 0:
		lose_game()

func update_ghost_behavior(delta):
	"""Update ghost hunting behavior"""
	var distance_to_player = ghost.global_position.distance_to(player.global_position)
	
	# Check if ghost can see player
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ghost.global_position, player.global_position)
	var result = space_state.intersect_ray(query)
	
	if result and distance_to_player < ghost_detection_range:
		# Ghost sees player - start chasing
		ghost.start_chase(player.global_position, ghost_speed)
		ui_manager.show_danger_indicator()
	else:
		# Ghost doesn't see player - patrol
		ghost.patrol(ghost_speed)
		if distance_to_player < 5.0:
			ui_manager.show_warning_indicator()

func update_hud():
	"""Update UI with current game state"""
	ui_manager.update_keys_display(keys_collected, keys_needed)
	ui_manager.update_health_display(player_health)

func toggle_pause():
	"""Pause/Unpause game"""
	is_paused = !is_paused
	get_tree().paused = is_paused
	ui_manager.show_pause_menu(is_paused)

func win_game():
	"""Win condition reached"""
	game_won = true
	get_tree().paused = true
	print("LEVEL ", level, " COMPLETED!")
	ui_manager.show_win_screen(level)


func lose_game():
	"""Lose condition reached"""
	game_over = true
	get_tree().paused = true
	print("Game Over - Ghost caught you!")
	ui_manager.show_lose_screen()

func restart_game():
	"""Restart current level"""
	get_tree().reload_current_scene()

func next_level():
	"""Load next level"""
	level += 1
	get_tree().reload_current_scene()
