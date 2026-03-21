#!/bin/bash
BOARD="nice_nano/nrf52840"
SHIELD="${1:-corne_left}"

docker run --rm \
  -v "$(pwd)/zmk:/zmk" \
  -v "$(pwd)/zmk-config:/zmk-config" \
  zmkfirmware/zmk-build-arm:stable \
  bash -c "cd /zmk && \
           west update && \
           west zephyr-export && \
           rm -rf /zmk/build && \
           west build -s app -b $BOARD -- \
             -DZMK_CONFIG=/zmk-config/config \
             -DSHIELD=$SHIELD"

if [ $? -eq 0 ]; then
  cp zmk/build/zephyr/zmk.uf2 ./${SHIELD}.uf2
  echo "✅ Firmware listo: ./${SHIELD}.uf2"
else
  echo "❌ Error en la compilación"
fi
