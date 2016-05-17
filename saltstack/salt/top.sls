# Salt top file.
# Documentation: https://docs.saltstack.com/en/latest/ref/states/top.html
base:
  '*':
    - common
  'minion*':  # TODO maps to glob pattern of minion ids. Change to 'odrive*'.
    - odrive


# Terminology:
#
# [environment]:
#     [target]:
#         - [state]
#         - [state2]

# It's common to just have one environment unless you really need more. If you
# need more, configure multiple "file_roots" as described here:
# https://docs.saltstack.com/en/latest/ref/configuration/master.html#std:conf_master-file_roots
