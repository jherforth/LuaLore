# Sky Folk Passive NPC System

## Overview
Sky Folk are peaceful, passive humanoid NPCs that inhabit floating islands and sky fortresses. They use the standard SAM character model with ethereal, flowing robe textures (white, blue, gold, green variants). They add life to the sky biomes through wandering, farming, crafting, and trading.

Sky Folk are **protected by Valkyrie Sentinels**: If a Sky Folk takes damage (from player or environment), nearby Valkyries enter a defensive rage mode (increased speed, damage, and pursuit). This creates high-stakes interactions—players can trade peacefully or risk triggering Valkyrie boss fights.

## Sky Folk Types

### Aether Harvesters (Common – ~50% of spawns)
**Role**: Humble farmers collecting "aether crops" from floating vines and cloud plants.  
**Appearance**: White flowing robes, basket accessory, soft glow overlay.  
**Behaviors**:  
- Slowly wanders and harvests nearby aether nodes (custom nodes).  
- Right-click → Trade: emeralds for aether shards, slow-fall seeds, potions.  
- Plays soft humming sound when idle.  
**Protection**: Killing or damaging one alerts all nearby Valkyries (especially Red Fury Sentinels).  
**Drops (on death)**: 1-3 bread, 1-2 feathers, occasional aether shard.

### Cloud Weavers (Uncommon – ~20%)
**Role**: Artisans weaving cloud silk into gliders and parachutes.  
**Appearance**: Blue hooded robes, spindle tool in hand texture.  
**Behaviors**:  
- Works at "cloud loom" nodes (crafting stations).  
- Right-click → Trade: string/silk for basic gliders, wind charms (jump boost), banners.  
**Protection**: White Gale Valkyrie prioritizes guarding weaving areas.  
**Drops**: 1-3 string, occasional silk.

### Star Scribes (Uncommon – ~20%)
**Role**: Scholars recording sky prophecies and star maps.  
**Appearance**: Gold-trimmed robes, book/scroll prop, starry eye overlay.  
**Behaviors**:  
- Reads from book nodes or stands thoughtfully.  
- Right-click → Trade: paper/ink for treasure maps, night vision potions, lore books.  
**Protection**: Gold Thunder Valkyrie patrols scribe towers; nearby scribes can temporarily buff Valkyrie HP.  
**Drops**: 1-2 paper, occasional book.

### Mist Healers (Rare – ~10%)
**Role**: Gentle healers brewing storm elixirs and antidotes.  
**Appearance**: Green misty robes, leaf-tipped staff.  
**Behaviors**:  
- Emits regen aura (5-block radius) to nearby players/Sky Folk.  
- Right-click → Trade: herbs for healing potions, Valkyrie curse antidotes.  
**Protection**: Black Eclipse Valkyrie shields healer groves; harming one triggers Shadow Veil on the attacker.  
**Drops**: 1-2 glowberries, occasional herb.

## Core Stats & Mechanics (All Types)
- **HP**: 20-30  
- **Armor**: 50  
- **Damage**: 0 (never attacks)  
- **Speed**: Wander 1.0 | Flee 2.0 (when hurt)  
- **Interaction**: Right-click opens simple trade formspec (villager-style).  
- **AI**: Pathfinds on islands, avoids edges, hides in huts at night.  
- **Protection Trigger**: If HP drops below 50% or damage taken, broadcasts alert → nearby Valkyries (within 40 blocks) gain:  
  - +50% speed  
  - +2 melee damage  
  - Teleport-dash to player  
- **Spawn**: 4-8 per sky village/fortress, once per structure (mod storage tracked).  

## Spawn Mechanics

### Automatic Spawning
- Spawns in sky villages/fortresses on floating islands (Y > 100).  
- Requires 50+ cloudstone/aether blocks to detect structure.  
- Integrated with floating_buildings.lua generation.  
- One-time per fortress (saved in mod storage).  
- Positioned around central Valkyrie circle, near huts/farms/looms.

### Manual Spawning (Testing/Admin)
Players with "give" privilege can use:

**Spawn single Sky Folk:**
/spawn_skyfolk <type>

Where `<type>` is: harvester, weaver, scribe, healer

Examples:
- `/spawn_skyfolk harvester`
- `/spawn_skyfolk healer`

**Spawn full sky village:**
/spawn_skyvillage

Spawns 10-15 Sky Folk + 4 Valkyries + basic huts (for testing).

## Trading & Progression
- Uses extended villager trade system (see villagers/HOW_TO_MODIFY_TRADES.md).  
- Trades unlock sky-themed items: slow-fall potions, basic gliders, aether gear, antidotes.  
- Griefing (killing Sky Folk) can lock trades in that area or anger Valkyries permanently.

## Combat & Protection Strategy
- **Peaceful Play**: Trade, help farms → earn rewards.  
- **Risky Play**: Attack Sky Folk → trigger Valkyrie defense (group boss fight).  
- **Tips**: Use ranged attacks from afar, or lure Valkyries away before griefing.  
- **Kid-Friendly Note**: Emphasizes strategy, exploration, and consequences over violence.

## Files Modified/Created

### New Files (in valkyrie/)
- `sky_folk.lua`          – Entity definitions, registration, AI  
- `sky_villages.lua`      – Sky village/fortress generation & spawning  
- `sky_trades.lua`        – Trade tables and formspec logic  
- `SKY_FOLK_SYSTEM.md`    – This documentation file  

### Modified Files
- `init.lua`                  – Load sky_folk.lua, sky_villages.lua, sky_trades.lua  
- `valkyrie/sky_valkyrie.lua` – Add protection AI (on_damage callback, alert system)  
- `valkyrie/valkyrie_strikes.lua` – Optional: Valkyrie buffs when protecting  
- `valkyrie/floating_buildings.lua` – Add Sky Folk huts to fortress schematics  
- `villagers/systems/villagers.lua` – Optional: Reuse mood/sound code if compatible  

## Technical Details
- **Base**: Extends mobs_redo (like villagers and Valkyries).  
- **Textures**: SAM model variants in textures/ (e.g., skyfolk_harvester.png, skyfolk_robe.png).  
- **Particles/Sounds**: Soft wind chimes (sounds/), sparkle bursts on trade (particles).  
- **Storage**: Mod storage tracks spawned villages to prevent respawns. Saves every 60s.  
- **Integration**: Sky Folk can use villagers/systems/npcmood.lua for idle sounds/moods.

## Dependencies
- `mobs_redo` (NPC base)  
- `default` (items, particles)  
- Existing floating islands / Valkyrie systems  

## Notes
- Encourages peaceful sky exploration with risk/reward.  
- Unique trades reward aerial adventures.  
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
│   ├── sky_villages.lua             # Sky village / fortress spawning & generation logic
│   └── sky_trades.lua               # Sky Folk trade tables, formspecs, and interactions
├── models/                           # 3D models (.b3d)
├── textures/                         # Textures and sprites
├── sounds/                           # Sound effects (.ogg)
└── schematics/                       # Building structures (.mts)
