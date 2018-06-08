#!/bin/bash

openocd -d2 -f oocd.cfg -c 'init_reset halt; program dist/BareArmBlink.hex verify; reset; exit'