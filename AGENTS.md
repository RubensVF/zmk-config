# Repository Guidelines

## Project Structure & Module Organization
- `config/corne.keymap`: Corne layers and bindings (DeviceTree syntax).
- `config/corne.conf`: Kconfig feature flags (BLE, display, etc.).
- `config/west.yml`: West manifest for ZMK and module imports.
- `build.yaml`: GitHub Actions build matrix (`nice_nano_v2` + `corne_left`/`corne_right`).
- `.github/workflows/build.yml`: CI entrypoint that reuses ZMK’s upstream user-config workflow on push/PR.
- `zephyr/module.yml`: Zephyr module declaration.
- `boards/shields/`: Reserved for custom shield definitions.

## Build, Test, and Development Commands
- `west build -s zmk/app -d build/left -b nice_nano_v2 -- -DSHIELD=corne_left -DZMK_CONFIG="$PWD/config"`: build left firmware locally.
- `west build -s zmk/app -d build/right -b nice_nano_v2 -- -DSHIELD=corne_right -DZMK_CONFIG="$PWD/config"`: build right firmware locally.
- `west build -t pristine -d build/left` (or `build/right`): clean build directory when switching configs.
- Primary validation is successful compilation of both halves; CI runs this automatically for pushes and pull requests.

## Coding Style & Naming Conventions
- Use 4-space indentation in `.keymap` and `.dtsi`-style blocks; align bindings for readability.
- Keep layer names descriptive and lowercase with underscores (for example, `default_layer`, `lower_layer`, `raise_layer`).
- Prefer explicit keycodes/behaviors (`&kp`, `&mo`, `&bt`) over opaque macros.
- In YAML (`build.yaml`, `west.yml`), keep keys lowercase and lists minimal.

## Testing Guidelines
- Treat firmware builds as the test suite: every change should compile for both `corne_left` and `corne_right`.
- For keymap changes, verify layer access (`&mo 1`, `&mo 2`) still works.
- Confirm Bluetooth behaviors (`BT_SEL`, `BT_CLR`) remain reachable.
- Confirm special symbol combos still map correctly on your host layout.

## Commit & Pull Request Guidelines
- Existing history uses short, direct messages (for example, `fix bluetooth`, `keymap v1`).
- Prefer imperative, focused commits: `keymap: adjust raise layer symbols`.
- PRs should describe what changed and why.
- Note affected layer(s) or config flags.
- Include confirmation that both halves built successfully (local or CI).
- Add screenshots only when display/UI behavior changes.
