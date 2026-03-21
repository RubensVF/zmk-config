# ZMK Config — Corne Wireless (Nice Nano v2)

Configuración personal para el teclado **Corne Wireless** con controlador **Nice Nano v2**.

---

## Compilar firmware en local con Docker

### Requisitos

- [Docker](https://docs.docker.com/get-docker/) instalado y corriendo
- [Git](https://git-scm.com/) instalado

---

### Estructura de carpetas

Antes de empezar, la estructura debe quedar así:

```
📁 directorio-padre/
├── 📁 zmk/             ← repo de ZMK
├── 📁 zmk-config/      ← este repositorio
└── 🔧 build.sh         ← script de compilación
```

---

### Paso 1 — Clona los repositorios

```bash
# Sube un nivel y clona ZMK
cd ..
git clone https://github.com/zmkfirmware/zmk.git
```

---

### Paso 2 — Copia el script de compilación

Copia el archivo `build.sh` (incluido en este repo) al directorio padre, donde están ambas carpetas:

```bash
cp zmk-config/build.sh .
chmod +x build.sh
```

---

### Paso 3 — Compila el firmware

```bash
# Mitad izquierda
./build.sh corne_left
rm -rf zmk/build
# Mitad derecha
./build.sh corne_right
```

El `.uf2` generado estará en:

```
zmk/build/zephyr/zmk.uf2
```

---

### Paso 4 — Flashea el teclado

1. Conecta la mitad del teclado por USB
2. Entra en **bootloader mode** (doble tap en el botón reset)
3. Aparecerá como una unidad USB en tu sistema
4. Copia el `.uf2` correspondiente a esa unidad
5. El teclado se reiniciará automáticamente ✅

Repite para la otra mitad.

---


> **Nota:** La primera vez que corres `west update` puede tardar ~10 minutos ya que descarga varias dependencias.

---

## Solución de problemas

### Error: `Invalid BOARD`

El nombre correcto del board en ZMK 2.x es `nice_nano/nrf52840`, no `nice_nano_v2`.


### El build termina pero no hay `.uf2`

Significa que el build falló en silencio. Revisa el output completo buscando líneas con `FATAL ERROR` o `CMake Error`.

---

## Hardware

| Componente | Modelo |
|---|---|
| Teclado | Corne (crkbd) |
| Controlador | Nice Nano v2 |
| Chip | nRF52840 |
| Conexión | Wireless (BLE) |
