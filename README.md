# 🏚️ House of Shadows - A 3D First-Person Horror Game

**Built with Godot Engine 4.7.2**

Escape from a haunted house while being hunted by a terrifying ghost! Navigate through dark rooms, solve puzzles, find the exit key, and survive!

## 🎮 Game Overview

### Story
You wake up trapped in an old, abandoned house. Something sinister lurks in the shadows. Your only goal: **ESCAPE** before the ghost catches you!

### Gameplay
- 🚪 Explore the haunted house
- 🔑 Find keys and objects to unlock doors
- 👻 Avoid the terrifying ghost that hunts you
- 🎯 Reach the exit and survive
- 📊 Complete levels with increasing difficulty

## 🕹️ Controls

| Key | Action |
|-----|--------|
| **W/A/S/D** | Move forward/left/back/right |
| **Space** | Jump |
| **Mouse** | Look around |
| **E** | Interact with objects |
| **ESC** | Pause Menu |
| **Left Click** | Pick up items |

## 📁 Project Structure

```
godot-horror-granny-game/
├── project.godot              # Godot project config
├── scenes/
│   ├── main.tscn              # Main game scene
│   ├── player.tscn            # Player (camera controller)
│   ├── ghost.tscn             # Enemy ghost AI
│   ├── house.tscn             # House environment
│   ├── key.tscn               # Collectible key item
│   ├── door.tscn              # Interactive door
│   └── ui.tscn                # Game UI (HUD, menus)
├── scripts/
│   ├── player.gd              # Player movement & interaction
│   ├── ghost.gd               # Ghost AI behavior
│   ├── game_manager.gd        # Game logic & state
│   ├── door.gd                # Door interaction
│   ├── key.gd                 # Key item logic
│   └── ui_manager.gd          # UI/HUD management
├── assets/
│   ├── models/                # 3D models (if added)
│   ├── materials/             # Materials & textures
│   └── sounds/                # Audio files
└── README.md                  # This file
```

## 🚀 How to Run

### Requirements
- **Godot Engine 4.7.2+** (Download from https://godotengine.org/)
- Computer with decent graphics (supports 3D rendering)

### Setup Steps

1. **Download Godot Engine**
   ```bash
   # Go to https://godotengine.org/ and download version 4.7.2 or higher
   ```

2. **Clone/Download This Project**
   ```bash
   git clone https://github.com/caovanan719-a11y/godot-horror-granny-game.git
   cd godot-horror-granny-game
   ```

3. **Open in Godot**
   - Open Godot Engine
   - Click "Import" and select this project folder
   - Click "Import & Edit"

4. **Run the Game**
   - Press **F5** or click the Play button (▶️) in the top-right
   - Game will launch in a window

5. **Stop the Game**
   - Press **ESC** or close the game window

## 🎮 Game Mechanics

### Player
- First-person camera
- WASD movement with smooth acceleration
- Mouse look for camera control
- Can jump and crouch
- Health system (ghost catches = damage)
- Inventory for collecting keys

### Ghost Enemy
- AI-driven pursuit behavior
- Patrols rooms when player not visible
- Chases player when detected
- Speed increases with difficulty level
- Makes creepy sounds when near

### Environment
- Multi-room haunted house
- Dark atmosphere with dynamic lighting
- Interactive doors (locked/unlocked)
- Collectible keys and items
- Puzzle elements

### Objectives
1. **Level 1**: Find 1 key to unlock main door → ESCAPE
2. **Level 2**: Find 2 keys in complex house → ESCAPE
3. **Level 3**: Find 3 keys while ghost is faster → SURVIVE

## 🧛 Ghost AI Behavior

```
┌─────────────────┐
│   PATROLLING    │  → Wandering house randomly
└────────┬────────┘
         ↓
   [Player spotted?]
         ↓
┌─────────────────┐
│    CHASING      │  → Running after player at high speed
└────────┬────────┘
         ↓
   [Player escaped?]
         ↓
┌─────────────────┐
│   SEARCHING     │  → Looking for player in last seen area
└────────┬────────┘
         ↓
   [Timeout?]
         ↓
  Back to PATROLLING
```

## 🌟 Features Explained

### Physics
- Gravity-based movement
- Jump and fall mechanics
- Collision detection for walls and obstacles
- Dynamic rigidbody interactions

### AI System
- Ghost pathfinding (A* algorithm)
- Line-of-sight detection
- Sound-based detection (movement noise)
- Intelligent hunting behavior

### Audio
- Ambient background music (horror theme)
- Ghost growls and screams
- Footstep sounds (player and ghost)
- Door unlock sounds
- Jump scare effects

### Visuals
- 3D geometric house design
- Dynamic shadows and lighting
- Fog for atmosphere
- Particle effects for eerie ambiance
- Red vignette when ghost is near (fear indicator)

## 🎯 Tips for Playing

1. **Listen carefully** - You'll hear the ghost before you see it
2. **Hide in closets** - Safe spots where ghost can't reach (temporarily)
3. **Move quietly** - Running makes more noise
4. **Explore thoroughly** - Keys are hidden in hard-to-find places
5. **Manage your fear** - Red screen means ghost is VERY close
6. **Use doors** - Close them behind you to slow the ghost

## 🧠 Learning Path

### Beginner Concepts
- ✅ 3D scene setup
- ✅ CharacterBody3D for movement
- ✅ First-person camera control
- ✅ Input handling

### Intermediate Concepts
- ✅ Simple AI (pathfinding)
- ✅ State machines (ghost behavior)
- ✅ Collision detection
- ✅ UI management
- ✅ Scene transitions

### Advanced Concepts
- ✅ Audio management
- ✅ Particle effects
- ✅ Dynamic lighting
- ✅ Performance optimization

## 🔧 Customization

### Easy Modifications

**Make the ghost faster/slower:**
```gdscript
# In ghost.gd
var PATROL_SPEED = 3.0  # Change this value
var CHASE_SPEED = 8.0   # Change this value
```

**Adjust game difficulty:**
```gdscript
# In game_manager.gd
var difficulty = 1  # 1=Easy, 2=Medium, 3=Hard
```

**Change house size/layout:**
- Edit the house.tscn in the 3D editor
- Add/remove rooms as desired
- Adjust lighting and atmosphere

**Add more keys/objectives:**
- Duplicate key.tscn in the FileSystem
- Place in new locations
- Update game_manager to require more keys

## 🐛 Troubleshooting

### Problem: Game won't start
**Solution:** Make sure `main.tscn` exists in `res://scenes/`

### Problem: Player can't move
**Solution:** Check that Input Map has W/A/S/D keys configured

### Problem: Ghost doesn't appear
**Solution:** Verify ghost.tscn is instantiated in main.tscn

### Problem: Low FPS/Laggy
**Solution:** Reduce lighting complexity or use simpler models

## 📚 GDScript Concepts Used

- Classes and inheritance
- Physics bodies (CharacterBody3D, RigidBody3D)
- Signals (event system)
- State machines
- Vector math
- Raycasting
- Timers
- Scene management

## 🎓 Next Steps to Improve

1. **Add Sound Effects**
   - Ghost screams
   - Footsteps
   - Door creaks
   - Key pickup sound

2. **Improve Graphics**
   - Better 3D models
   - Textures and materials
   - Particle effects
   - Post-processing effects

3. **Add More Content**
   - More rooms
   - More puzzles
   - Boss ghost encounter
   - Multiple endings

4. **Polish Gameplay**
   - Difficulty settings
   - Pause menu
   - Settings (volume, graphics)
   - High score tracking

## 📖 Resources

- **Godot Documentation**: https://docs.godotengine.org/
- **GDScript Reference**: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/index.html
- **3D in Godot**: https://docs.godotengine.org/en/stable/tutorials/3d/index.html
- **Game Design**: https://www.gamasutra.com/

## 💡 Tips for Learning

1. **Understand the structure** - Read through all script files
2. **Run and play** - Experience the game first
3. **Modify values** - Change speed, difficulty, etc.
4. **Add features** - Extend the game with new ideas
5. **Break things** - Don't be afraid to experiment!

## 🎬 Credits

**Built with:**
- Godot Engine 4.7.2
- GDScript
- ❤️ and lots of horror vibes

**Inspired by:**
- Granny (Dennis Proshutinsky)
- Five Nights at Freddy's
- Resident Evil
- Amnesia: The Dark Descent

## 📝 License

Free to use, modify, and distribute for learning and personal projects!

---

## 🚀 Have Fun!

**Can you escape from the House of Shadows?**

Good luck! 👻
