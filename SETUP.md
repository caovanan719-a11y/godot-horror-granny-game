# 🎮 Setup Guide - House of Shadows

## Quick Start (5 minutes)

### Step 1: Download & Install Godot
1. Go to https://godotengine.org/download
2. Download **Godot Engine 4.7.2 (Standard)** for your OS
3. Extract and run the executable

### Step 2: Import This Project
1. Open Godot Engine
2. Click **Import** at the top of the Project Manager
3. Browse to this folder `godot-horror-granny-game/`
4. Click **Open**
5. Click **Import & Edit**

### Step 3: Run the Game
1. In the Godot editor, make sure `main.tscn` is open
2. Press **F5** or click ▶️ (Play) button at top-right
3. The game will launch!

### Step 4: Play!
- **W/A/S/D** - Move
- **Mouse** - Look around
- **Space** - Jump
- **E** - Interact with objects
- **ESC** - Pause

---

## 🛠️ Project Structure Explained

```
godot-horror-granny-game/
├── project.godot           # Project configuration
├── scenes/                 # All game scenes and scripts
│   ├── main.gd            # Game manager & logic
│   ├── player.gd          # Player controller
│   ├── ghost.gd           # Ghost AI
│   ├── ui_manager.gd      # UI/HUD
│   ├── door.gd            # Door interaction
│   └── key.gd             # Key collection
└── README.md              # Full documentation
```

---

## 🎯 How Scenes Work in Godot

### What is a Scene?
A **scene** is a container for game objects (nodes). Think of it like a theater stage:
- Players, props, and enemies are **nodes**
- The stage they're on is a **scene**
- Multiple scenes = multiple levels

### Scene Hierarchy
```
main.tscn (Main Scene)
├── Player (CharacterBody3D)
│   └── Camera3D
├── Ghost (CharacterBody3D)
├── House (StaticBody3D)
│   ├── Door 1
│   ├── Door 2
│   └── ...
├── Keys
│   ├── Key 1
│   ├── Key 2
│   └── ...
└── UIManager (CanvasLayer)
```

---

## 📝 Understanding the Code

### Player Movement (player.gd)
```gdscript
func handle_movement_input(delta):
    # Get WASD input
    var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    
    # Convert to 3D direction
    var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    
    # Apply movement
    velocity.x = direction.x * walk_speed
    velocity.z = direction.z * walk_speed
```

**What it does:**
1. Reads keyboard input (W/A/S/D)
2. Converts 2D input to 3D movement
3. Applies velocity to move the player

### Ghost AI (ghost.gd)
```gdscript
func patrol(speed: float):
    # Move between waypoints
    move_towards(waypoints[current_waypoint], speed)
    
func start_chase(player_pos: Vector3, speed: float):
    # Chase the player!
    move_towards(player_pos, speed)
```

**What it does:**
1. Ghost walks around the house (patrol mode)
2. When it sees the player, it starts chasing
3. Uses waypoints to navigate

### Key Collection (key.gd)
```gdscript
func collect(player):
    # Add key to player's inventory
    player.add_to_inventory(key_name)
    
    # Tell game manager
    game_manager.add_key()
    
    # Remove from scene
    queue_free()
```

**What it does:**
1. Detects when player touches key
2. Adds to inventory
3. Updates game state
4. Removes key from scene

---

## 🔧 Customization Ideas

### Change Player Speed
```gdscript
# In player.gd, change these values:
@export var walk_speed = 7.0      # Current speed
@export var sprint_speed = 12.0   # When running
```

### Make Ghost Faster
```gdscript
# In main.gd, change ghost behavior:
var ghost_speed = 5.0  # Increase this number
```

### Add More Rooms
1. In Godot editor, open `main.tscn`
2. Right-click on **House** node
3. Click **Add Child Node** → **StaticBody3D**
4. Add a MeshInstance3D as child
5. Create/assign a box mesh
6. Position and size it as a new room

### Add More Keys
1. In Godot editor, right-click on **Keys** node
2. Add new Area3D node
3. Attach the **key.gd** script
4. Position it in a room
5. Add a MeshInstance3D as visual

---

## 🐛 Common Issues & Fixes

### "No main scene set"
**Problem:** Game won't start
**Fix:** 
1. Go to Project → Project Settings
2. Find "Application" → "Main Scene"
3. Set it to `res://scenes/main.tscn`

### Player falls through floor
**Problem:** Physics collision broken
**Fix:**
1. Select Player node
2. Add **CollisionShape3D** as child
3. Set shape to Capsule
4. Adjust height to match player size

### Ghost doesn't move
**Problem:** AI script not working
**Fix:**
1. Select Ghost node
2. Add **CollisionShape3D** as child
3. Set shape to Box
4. Check that ghost.gd is attached as script

### Can't pick up keys
**Problem:** Area detection broken
**Fix:**
1. Check key nodes are Area3D type
2. Add **CollisionShape3D** as child
3. Set shape to Box or Sphere
4. Ensure area_entered signal is connected

---

## 🎓 Learning Path

### Week 1: Basics
- [ ] Play the game - understand mechanics
- [ ] Read through all script files
- [ ] Understand node hierarchy
- [ ] Modify values (speed, health, etc.)

### Week 2: Customization
- [ ] Add new rooms to house
- [ ] Add more keys/collectibles
- [ ] Change ghost behavior
- [ ] Modify player abilities

### Week 3: Features
- [ ] Add sound effects (footsteps, ghost sounds)
- [ ] Add visual effects (particle effects, lighting)
- [ ] Create new levels
- [ ] Add power-ups (healing items, invincibility)

### Week 4: Polish
- [ ] Create menus (main menu, settings)
- [ ] Add difficulty settings
- [ ] Improve graphics
- [ ] Add leaderboard/high scores

---

## 📚 GDScript Resources

**Official Documentation:**
- https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/index.html

**Key Concepts:**
- `_ready()` - Called when node enters scene
- `_process(delta)` - Called every frame
- `func name()` - Define a function
- `var name = value` - Create a variable
- `@export` - Make variable editable in editor

**Common Functions:**
```gdscript
# Movement
move_and_slide()        # Move character
rotate_y(angle)         # Rotate around Y axis

# Input
Input.is_action_pressed()    # Check if button pressed
Input.get_vector()           # Get directional input

# Signals
Signal name              # Create event
emit_signal("name")      # Trigger event
connect("name", func)    # Listen for event
```

---

## 🎮 Next Steps

1. **Run the game** - Get familiar with it
2. **Read the code** - Understand how it works
3. **Make changes** - Customize values
4. **Add features** - Extend the game
5. **Share** - Show your friends!

---

## ❓ Need Help?

- **Godot Docs**: https://docs.godotengine.org/
- **Godot Community**: https://godotengine.org/community
- **YouTube Tutorials**: Search "Godot 4 tutorial"
- **Discord**: Join Godot community servers

---

**Happy game developing!** 🚀👻
