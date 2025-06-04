# 💎 diamond_uwu

A FiveM ESX-compatible script that powers an interactive **Uwu Café** experience with ambient cats, target interactions, zones, and society integration.

---

preview: https://streamable.com/15jcrs

youtube: https://www.youtube.com/@SnowMorales-diamond (follow my development journey in building my server)

## 📦 Features

- 🐾 **Cats** wander randomly and perform various idle animations (sleeping, stretching, walking).
- 🐾 Players can **pet cats**, which plays a synchronized animation and **reduces player stress** via `hud:server:RelieveStress`.
- 🎯 Integrated with `ox_target` for simple and intuitive interaction.
- 🧠 Custom cat names and animations per session (no repeated names).
- 📍 Uses `PolyZone` to define interaction or restricted areas.
- 🏢 Compatible with `esx_society` for Uwu Café job management and boss menus.

---

## 🧰 Dependencies

Ensure these resources are installed **before** using `diamond_uwu`:

```lua
dependencies {
    'PolyZone',
    'esx_society',
    'ox_target',
    'mythic_notify',
    'ox_lib',
}

these are included in the folder [dependencies] so you don't have to download it anymore.

optional dependencies:
 `wasabi_oxshops` https://github.com/wasabirobby/wasabi_oxshops

 for billing:
 I used 

## ⚙️ Setup Instructions

### Add to your `server.cfg`:
`cfg
ensure PolyZone  
ensure esx_society  
ensure ox_target  
ensure diamond_uwu 

🧠 Stress Relief Integration

Make sure stress relief is handled in your HUD system. Refer to your HUD documentation if you have stress enabled.

🔧 Configure config.lua:

    Set the job name for Uwu Café.

    (Optional) Customize cat spawn points and behavior patterns.

    🎥 Demo Features

    💤 Cats sleep, stretch, walk, and act independently.

    🐱 Each cat has a unique name and randomized animation cycle.

    🤲 Petting triggers synchronized animations for player and cat.

    🧘‍♂️ Reduces player stress during interaction for immersive RP.
