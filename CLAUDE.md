# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a ZMK firmware user configuration repository for a **Corne split keyboard** using **nice!nano v2** controllers. Firmware is built via GitHub Actions — pushing to `master` triggers a build that produces left/right `.uf2` flash files as artifacts.

## Build

**Normal workflow:** Push changes to GitHub and the Actions workflow (`.github/workflows/build.yml`) builds the firmware using `zmkfirmware/zmk/.github/workflows/build-user-config.yml@main`.

**Local build** requires the ZMK development environment (Zephyr SDK + `west`). See [ZMK docs](https://zmk.dev/docs/development/setup) for setup. Once set up:

```sh
west build -s zmk/app -b nice_nano_v2 -- -DSHIELD=corne_left -DZMK_CONFIG="$(pwd)/config"
west build -s zmk/app -b nice_nano_v2 -- -DSHIELD=corne_right -DZMK_CONFIG="$(pwd)/config"
```

The `build.yaml` file defines the GitHub Actions matrix (currently: `nice_nano_v2` + `corne_left`/`corne_right`).

## Repository Structure

- `config/corne.keymap` — Keymap definition (DeviceTree syntax, 3 layers)
- `config/corne.conf` — Kconfig options (BT, BLE, OLED display enabled)
- `config/west.yml` — West manifest pinning ZMK to `main` branch
- `build.yaml` — GitHub Actions build matrix
- `zephyr/module.yml` — Marks repo as a Zephyr module with custom board root
- `boards/shields/` — Placeholder for custom shield definitions

## Keymap Architecture

The keymap (`config/corne.keymap`) uses DeviceTree syntax and defines 3 layers:

| Layer | Index | Activation |
|-------|-------|------------|
| `default_layer` | 0 | Base |
| `lower_layer` | 1 | Hold `mo 1` (left thumb) |
| `raise_layer` | 2 | Hold `mo 2` (right thumb) |

**Key design note:** The keyboard uses a **Spanish ISO physical layout** but the keycodes are mapped to produce correct characters assuming the OS is set to **ANSI English** layout. Special characters in the raise layer use `LC(LA(...))` (Ctrl+Alt = AltGr equivalent on Linux) to produce Spanish symbols.

**Lower layer:** Numbers row, arrow keys, Page Up/Down, and Bluetooth profile selection (`BT_SEL 0–4`) / clear (`BT_CLR`) on the bottom-left.

**Raise layer:** Symbols and special characters, including brackets, operators, and Spanish-specific characters via AltGr combos.

## Configuration Options (`corne.conf`)

- `CONFIG_BT=y` / `CONFIG_ZMK_BLE=y` — Bluetooth enabled
- `CONFIG_ZMK_DISPLAY=y` — OLED display enabled
- RGB underglow is commented out (not populated on this build)
