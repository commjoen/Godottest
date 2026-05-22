# Godottest

A minimal **Godot 4** underwater exploration game (first playable version) configured for **Web export** and automated **GitHub Pages deployment**.

## What is implemented

- Godot 4 project scaffold (`project.godot`)
- Prototype 3D underwater scene with a simple objective loop (`scenes/Main.tscn`)
- Player swim controller (`scripts/player_controller.gd`)
- Landmark objective manager and mission UI (`scripts/game_manager.gd`)
- Web export preset (`export_presets.cfg`)
- GitHub Actions workflow to build and publish to GitHub Pages (`.github/workflows/deploy-pages.yml`)

## Controls

- Move: `WASD` / Arrow keys
- Swim up: `E`
- Swim down: `Q`
- Look: Mouse
- Toggle mouse capture: `Esc`
- Goal: find all underwater landmarks

## Run locally (Godot editor)

1. Open the repository folder in Godot 4.2+.
2. Press **Play**.

## Export locally (Web)

1. Ensure Web export templates are installed in Godot.
2. Run:

```bash
godot --headless --path . --export-release "Web" build/web/index.html
```

3. Serve `build/web` with a local static server.

## GitHub Pages publishing

The workflow in `.github/workflows/deploy-pages.yml`:

1. Runs on pushes to `main` (and manually via `workflow_dispatch`).
2. Builds the Web export using a Godot CI container.
3. Uploads `build/web` as the Pages artifact.
4. Deploys to GitHub Pages.

After enabling **Pages** in repository settings (source: **GitHub Actions**), each successful run updates the hosted game.

Published site URL format:

`https://<your-github-username>.github.io/Godottest/`
