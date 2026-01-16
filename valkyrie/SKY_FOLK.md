# Sky Folk Passive NPC System

## Overview
Sky Folk are peaceful, passive humanoid NPCs that inhabit floating islands and sky fortresses. They use the standard SAM character model with ethereal, flowing robe textures (white, blue, gold, green variants). They add life to the sky biomes through wandering, farming, crafting, and trading.

Sky Folk are **protected by Valkyrie Sentinels**: If a Sky Folk takes damage (from player or environment), nearby Valkyries enter a defensive rage mode (increased speed, damage, and pursuit). The sky folk are not friendly and will also attack with a melee attack. 

## Sky Folk

**Behaviors**:  
- Plays soft humming sound when idle.  
**Protection**: Killing or damaging one alerts all nearby Valkyries (especially Red Fury Sentinels).  
**Drops (on death)**: 1-3 bread, 1-2 feathers, occasional aether shard.

## Core Stats & Mechanics (All Types)
- **HP**: 20-30  
- **Armor**: 50  
- **Damage**: 4 (will melee attack if you come into range, they are not friendly
- **Speed**: Wander 2.0 
- **AI**: Pathfinds on islands, avoids edges, hides in huts at night.  
- **Protection Trigger**: If HP drops below 50% or damage taken, broadcasts alert → nearby Valkyries (within 40 blocks) gain:  
  - +50% speed  
  - +2 melee damage  
  - Teleport-dash to player  
- **Spawn**: 2 per sky house per sky village/fortress (mod storage tracked).  

## Spawn Mechanics

### Automatic Spawning
- Spawns in sky villages/fortresses on floating islands (Y > 500).
- Biome specific: Everness Crystal Forest
- Requires 50+ Everness:dirt_with_crystal_grass blocks to detect structure.  
- Integrated with floating_buildings.lua generation.  
- One-time per fortress (saved in mod storage).  
- Positioned around central Valkyrie sky castle.

### Manual Spawning (Testing/Admin)
Players with "give" privilege can use:

**Spawn single Sky Folk:**
/spawn_skyfolk

**Spawn full sky village:**
/spawn_skyvillage

Spawns 10-15 Sky Folk + 1 Valkyries + basic houses (for testing).

## Combat & Protection Strategy
- **Risky Play**: Attack Sky Folk → trigger Valkyrie defense (group boss fight).  
- **Tips**: Use ranged attacks from afar, or lure Valkyries away before griefing.  
- **Kid-Friendly Note**: Emphasizes strategy, exploration, and consequences over violence.

## Files Modified/Created

### New Files (in valkyrie/)
- `sky_folk.lua`          – Entity definitions, registration, AI  
- `sky_villages.lua`      – Sky village/fortress generation & spawning  
- `SKY_FOLK_SYSTEM.md`    – This documentation file  

### Modified Files
- `init.lua`                  – Load sky_folk.lua, sky_villages.lua, sky_trades.lua  
- `valkyrie/sky_valkyrie.lua` – Add protection AI (on_damage callback, alert system)  
- `valkyrie/valkyrie_strikes.lua` – Optional: Valkyrie buffs when protecting  
- `valkyrie/floating_buildings.lua` – Add Sky Folk houses to fortress schematics  
- `villagers/systems/villagers.lua` – Optional: Reuse mood/sound code if compatible  

## Technical Details
- **Base**: Extends mobs_redo (like villagers and Valkyries).  
- **Textures**: SAM model texture/ (e.g., sky_folk.png).   
- **Storage**: Mod storage tracks spawned villages to prevent respawns. Saves every 60s. 

## Dependencies
- `mobs_redo` (NPC base)  
- `default` (items, particles)
- Everness
- Existing floating islands / Valkyrie systems  

## Notes
- Valkyrie protection creates dynamic, story-like encounters.  
- Easy to expand: Add more types or biome variants later.

## Directory tree update
lualore/
├── init.lua                          # Main mod initialization and load order
├── mod.conf                          # Mod metadata and dependencies
├── intllib.lua                       # Internationalization library
├── villagers/                        # All villager and village systems
│   ├── HOW_TO_MODIFY_TRADES.md      # Trading system documentation
│   ├── REPOPULATE_VILLAGERS.md      # Villager spawning guide
│   ├── blocks/                       # Biome-specific decorative blocks
│   │   ├── jungleblocks.lua
│   │   ├── savannablocks.lua
│   │   ├── arcticblocks.lua
│   │   ├── grasslandblocks.lua
│   │   ├── lakeblocks.lua
│   │   └── desertblocks.lua
│   ├── buildings/                    # Biome-specific building generators
│   │   ├── junglebuildings.lua
│   │   ├── savannabuildings.lua
│   │   ├── icebuildings.lua
│   │   ├── grasslandbuildings.lua
│   │   ├── lakebuildings.lua
│   │   └── desertbuildings.lua
│   ├── systems/                      # Core villager and village systems
│   │   ├── npcmood.lua              # Mood and sound system
│   │   ├── villagers.lua            # Villager definitions and behavior
│   │   ├── villager_behaviors.lua   # NPC AI and interaction logic
│   │   ├── house_spawning.lua       # Villager spawn system
│   │   ├── village_noise.lua        # Village generation parameters
│   │   ├── village_commands.lua     # Admin commands
│   │   ├── smart_doors.lua          # Automatic door system
│   │   └── witch_magic.lua          # Witch abilities
│   └── extras/                       # Optional fun content
│       ├── explodingtoad.lua        # Explosive toad entity
│       └── loot.lua                 # Loot tables and drops
├── wizards/                          # Cave wizard system
│   ├── WIZARD_SYSTEM.md             # Wizard documentation
│   ├── cave_wizards.lua             # Wizard entity definitions
│   ├── wizard_magic.lua             # Wizard abilities
│   └── cavebuildings.lua            # Underground structures
├── valkyrie/                         # Sky valkyrie + sky folk system
│   ├── VALKYRIE_SYSTEM.md           # Valkyrie boss fight documentation
│   ├── SKY_FOLK_SYSTEM.md           # Sky Folk passive NPCs documentation
│   ├── sky_valkyrie.lua             # Valkyrie entity definitions & registration
│   ├── valkyrie_strikes.lua         # Valkyrie abilities & effects
│   ├── floating_buildings.lua       # Sky fortress / floating island structure generation
│   ├── sky_folk.lua                 # Sky Folk entity definitions, behaviors, AI
│   └── sky_villages.lua             # Sky village / fortress spawning & generation logic
├── models/                           # 3D models (.b3d)
├── textures/                         # Textures and sprites
├── sounds/                           # Sound effects (.ogg)
└── schematics/                       # Building structures (.mts)
