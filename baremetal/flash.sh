#!/bin/bash

openocd -d2 -f oocd.cfg -c 'init_reset halt; program notmain.hex verify; reset; exit'