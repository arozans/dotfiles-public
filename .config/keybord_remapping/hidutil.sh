#!/usr/bin/env sh

# remapping keys for fucked up MacBook 15' touchbar ISO and some external keyboards. Codes generated with: https://hidutil-generator.netlify.app and skhd --observe

# KBD 67 Lite
hidutil property --matching '{"ProductID":0x1225}' --set '{"UserKeyMapping":[
            {
              "HIDKeyboardModifierMappingSrc": 0x700000039,
              "HIDKeyboardModifierMappingDst": 0x7000000E0
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x7000000E3,
              "HIDKeyboardModifierMappingDst": 0x7000000E2
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x7000000E2,
              "HIDKeyboardModifierMappingDst": 0x7000000E3
            }
]}'

# 84es
hidutil property --matching '{"ProductID":0x5025}' --set '{"UserKeyMapping":[
            {
              "HIDKeyboardModifierMappingSrc": 0x700000039,
              "HIDKeyboardModifierMappingDst": 0x7000000E0
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x7000000E3,
              "HIDKeyboardModifierMappingDst": 0x7000000E2
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x7000000E2,
              "HIDKeyboardModifierMappingDst": 0x7000000E3
            }
]}'
  
# Internal MacBook keyboard
hidutil property --matching '{"ProductID":0x027c}' --set '{"UserKeyMapping":[
            {
              "HIDKeyboardModifierMappingSrc": 0x700000039,
              "HIDKeyboardModifierMappingDst": 0x7000000E0
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x7000000E7,
              "HIDKeyboardModifierMappingDst": 0x7000000E6
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x7000000E6,
              "HIDKeyboardModifierMappingDst": 0x7000000E7
            },
            {
              "HIDKeyboardModifierMappingSrc": 0xFF00000003,
              "HIDKeyboardModifierMappingDst": 0x7000000E0
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x700000064,
              "HIDKeyboardModifierMappingDst": 0x700000029
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x700000031,
              "HIDKeyboardModifierMappingDst": 0x700000028
            }
]}'

