# Ghost AI - Enemy behavior and hunting logic
extends CharacterBody3D

# Movement variables
@export var patrol_speed = 3.0
@export var chase_speed = 6.0
@export var turn_speed = 2.0

# State variables
var current_state = "patrol"
var target_position = Vector3.ZERO
var last_seen_position = Vector3.ZERO
var patrol_timer = 0.0
var patrol_interval = 3.0

# Waypoints for patrol
var waypoints = []
var current_waypoint = 0

func _ready():
	# Setup patrol waypoints around the house
	setup_waypoints()
	randomize()

func _process(delta):
	if current_state == "patrol":
		patrol(patrol_speed)
	elif current_state == "chase":
		if global_position.distance_to(last_seen_position) < 1.0:
			current_state = "search"
			patrol_timer = 5.0
	
func setup_waypoints():
	"""Setup patrol waypoints"""
	# These are example waypoints - adjust for your house layout
	waypoints = [
		Vector3(-10, 1, -10),
		Vector3(10, 1, -10),
		Vector3(10, 1, 10),
		Vector3(-10, 1, 10),
		Vector3(0, 1, 0)
	]

target_position = waypoints[0]

func patrol(speed: float):
	"""Patrol behavior - walk between waypoints"""
	patrol_timer += get_physics_process_delta_time()
	
	if patrol_timer >= patrol_interval:
		current_waypoint = (current_waypoint + 1) % waypoints.size()
		target_position = waypoints[current_waypoint]
		patrol_timer = 0.0
	
	# Move towards waypoint
	move_towards(target_position, speed)

func start_chase(player_pos: Vector3, speed: float):
	"""Start chasing the player"""
	if current_state != "chase":
		current_state = "chase"
		last_seen_position = player_pos
		play_chase_sound()
	
	target_position = player_pos
	move_towards(target_position, speed)

func move_towards(target: Vector3, speed: float):
	"""Move ghost towards target position"""
	var direction = (target - global_position).normalized()
	
	# Look at target
	look_at(target, Vector3.UP)
	
	# Move forward
	velocity = direction * speed
	velocity.y -= 9.8 * get_physics_process_delta_time()  # Gravity
	
	move_and_slide()

func play_chase_sound():
	"""Play scary sound when chasing"""
	print("👻 GHOST SOUND: RRRAAAAAHHHHH!")

func on_ghost_visible():
	"""Called when ghost becomes visible to player"""
	print("Ghost spotted! Running away!")
