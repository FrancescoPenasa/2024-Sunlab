print("Starting")

import board

from kmk.modules.encoder import EncoderHandler
from kmk.modules.potentiometer import PotentiometerHandler
from kmk.consts import UnicodeMode
from kmk.modules.layers import Layers
from kmk.kmk_keyboard import KMKKeyboard
from kmk.keys import KC
from kmk.scanners import DiodeOrientation
from kmk.extensions.media_keys import MediaKeys

# init keyboard
keyboard = KMKKeyboard()
keyboard.debug_enabled = True

# init extra modules
layers = Layers()
encoder_handler = EncoderHandler()
potentiometer_handler = PotentiometerHandler()
keyboard.modules = [layers, encoder_handler, potentiometer_handler]
keyboard.extensions.append(MediaKeys())

# === keyboard switch and buttons === # 
# define row and column pins
keyboard.col_pins = (board.GP3,board.GP4,board.GP5,board.GP6,board.GP7,) # cinque colonne
keyboard.row_pins = (board.GP0,board.GP1,board.GP2,) # tre righe
keyboard.diode_orientation = DiodeOrientation.COL2ROW  # diodo sulla riga, direzione lontano dal pin

# Layers 
LYR_STD, LYR_EXT = 0, 1

TO_STD = KC.DF(LYR_STD) # to layer std
# MT_EXT = KC.MO(LYR_EXT) # SHIFT to layer ext 
TO_EXT = KC.DF(LYR_EXT) # LOCK to layer ext

# map keycodes to keys
keyboard.keymap = [
    # std layer
    [
        TO_EXT, KC.C, KC.ESCAPE, KC.A , KC.B, # RIGA 1: cambia layer, C, ESC, A, B
        KC.A,KC.B,KC.C, KC.D , KC.E, # RIGA 2: A, B, C, D, E
        KC.A,KC.B,KC.C, KC.D , KC.E, # RIGA 3: A, B, C, D, E
     
     ],

    # ext layer
    [
        TO_STD,KC.C,KC.ESCAPE, KC.SPACE , KC.B, # RIGA 1: cambia layer, C, ESC, SPACE, B
        KC.A,KC.B,KC.C, KC.D , KC.E, # RIGA 2: A, B, C, D, E
        KC.A,KC.B,KC.C, KC.D , KC.E, # RIGA 3: A, B, C, D, E
    ]
]
# end of keyboard swith and buttons #


# === potentiometer or slider === #

keyboard.last_level = -1
level_steps = 100
level_inc_step = 1
level_lut = [0,1,2,3,4 ,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20, 
             21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
             35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
             49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62,
             63]

# function called at each potentiometer change
def potentiometer_handler(state):
    print(f"potentiometer_handler: {state.position}")

    # convert to 0-100
    print( keyboard.last_level)
    new_pos = int((state.position / 127) * 64)
    level = level_lut[new_pos]
    print(f"new vol level: {level}")
    print(f"last: {keyboard.last_level}")

    # check if uninitialized
    if keyboard.last_level == -1:
        keyboard.last_level = level
        return

    level_diff = abs(keyboard.last_level - level)
    if level_diff > 0:
        # set volume to new level
        vol_direction = "unknown"
        if level > keyboard.last_level:
            vol_direction = "up"
            cmd = KC.AUDIO_VOL_UP
        else:
            vol_direction = "down"
            cmd = KC.AUDIO_VOL_DOWN
        # Send command  cmd to OS to up and down volume
        keyboard.tap_key(cmd)
        print(f"Setting system volume {vol_direction} by {level_diff} to reach {level}")

        keyboard.last_level = level
    return


# map function to pin 
potentiometer_handler.pins = (
    # (board.GP26, "slider_1_handler", False),
    (board.GP27, potentiometer_handler, True),
)

# end of potentiometer or slider # 



# === rotary encoder === # 
encoder_handler.map = [ 
    ((KC.UP, KC.DOWN, KC.MUTE),), # STD layer: turn right: up, turn left: down, onPress: mute audio
    ((KC.VOLD, KC.VOLU, KC.MUTE),), # EXT layer: turn right: volume up, turn left: volume down, onPress: mute audio
]
# end of rotary encoder #



# execute
if __name__ == '__main__':
    keyboard.go()
