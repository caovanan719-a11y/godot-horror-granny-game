# Player Controller - First-person camera and movement
extends CharacterBody3D

# Movement variables
@export var walk_speed = 7.0
@export var sprint_speed = 12.0
@export var acceleration = 20.0
@export var friction = 15.0
@export var jump_force = 5.0
@export var gravity = 9.8

# Camera variables
@export var mouse_sensitivity = 0.003
@onready var camera = $Camera3D

# State variables
var is_sprinting = false
var is_at_exit = false
var inventory = []
var current_speed = 0.0

func _ready():
	# Lock mouse to game window
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	# Handle input
	handle_movement_input(delta)
	handle_interaction_input()
	# Apply physics
	apply_gravity(delta)
	move_and_slide()

func _input(event):
	# Handle mouse look
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		handle_camera_look(event)

func handle_movement_input(delta):
	"""Handle WASD movement and jumping"""
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var target_speed = walk_speed
	
	# Check if sprinting
	if Input.is_action_pressed("ui_shift"):
		is_sprinting = true
		target_speed = sprint_speed
	else:
		is_sprinting = false
	
	# Calculate movement direction
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Smooth acceleration
	if direction.length() > 0:
		current_speed = lerp(current_speed, target_speed, acceleration * delta)
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		current_speed = lerp(current_speed, 0.0, friction * delta)
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
		velocity.z = lerp(velocity.z, 0.0, friction * delta)
	
	# Handle jumping
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = jump_force

func apply_gravity(delta):
	"""Apply gravity to player"""
	if not is_on_floor():
		velocity.y -= gravity * delta


func handle_camera_look(event: InputEventMouseMotion):
	"""Handle mouse looking around"""
	rotate_y(-event.relative.x * mouse_sensitivity)
	camera.rotate_x(-event.relative.y * mouse_sensitivity)
	camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

func handle_interaction_input():
	"""Handle E key for interacting with objects"""
	if Input.is_action_just_pressed("ui_focus_next"):
		interact_with_nearby_objects()

func interact_with_nearby_objects():
	"""Check for nearby interactable objects"""
	# Cast a ray in front of player
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(
		global_position + Vector3.UP * 1.5,
		global_position + global_transform.basis.z * 3 + Vector3.UP * 1.5
	)
	query.collide_with_areas = true
	
	var result = space_state.intersect_ray(query)
	if result:
		var collider = result.collider
		if collider.has_method("interact"):
			collider.interact(self)

func add_to_inventory(item):
	"""Add item to player inventory"""
	inventory.append(item)
	print("Picked up: ", item)

func check_exit():
	"""Called when player reaches exit"""
	is_at_exit = true
