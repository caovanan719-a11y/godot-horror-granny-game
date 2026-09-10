# UI Manager - Handle HUD and menus
extends CanvasLayer

# UI References
@onready var keys_label = Label.new()
@onready var health_label = Label.new()
@onready var fear_vignette = ColorRect.new()
@onready var danger_indicator = Control.new()

func _ready():
	# Create HUD elements
	setup_hud()

func setup_hud():
	"""Setup HUD elements"""
	# Keys display
	keys_label.text = "Keys: 0/1"
	keys_label.add_theme_font_size_override("font_size", 32)
	add_child(keys_label)
	keys_label.position = Vector2(20, 20)
	
	# Health display
	health_label.text = "Health: 100"
	health_label.add_theme_font_size_override("font_size", 32)
	add_child(health_label)
	health_label.position = Vector2(20, 70)

func update_keys_display(collected: int, needed: int):
	"""Update keys counter"""
	keys_label.text = "Keys: %d/%d" % [collected, needed]

func update_health_display(health: int):
	"""Update health bar"""
	health_label.text = "Health: %d" % health
	if health <= 30:
		health_label.add_theme_color_override("font_color", Color.RED)
	elif health <= 60:
		health_label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		health_label.add_theme_color_override("font_color", Color.WHITE)

func show_message(message: String):
	"""Show temporary message on screen"""
	print("Message: ", message)

func show_fear_effect():
	"""Show red vignette when ghost is close (fear effect)"""
	print("👻 FEAR EFFECT!")

func show_danger_indicator():
	"""Show danger indicator when ghost is chasing"""
	print("⚠️ DANGER - GHOST CHASING!")

func show_warning_indicator():
	"""Show warning when ghost is nearby"""
	print("⚠️ WARNING - Ghost nearby!")

func show_pause_menu(paused: bool):
	"""Show/hide pause menu"""
	if paused:
		print("=== GAME PAUSED ===")
		print("Press ESC to resume")
	else:
		print("Game Resumed")

func show_win_screen(level: int):
	"""Show victory screen"""
	print("\n🎉 LEVEL ", level, " COMPLETED! 🎉")
	
func show_lose_screen():
	"""Show game over screen"""
	print("\n💀 GAME OVER - CAUGHT BY GHOST! 💀")
