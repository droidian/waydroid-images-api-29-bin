#!/user/bin/env python3
import json
import os
import sys

img = sys.argv[1]
arch = sys.argv[2]

basedir = "waydroid_OTA_override" if os.path.exists("waydroid_OTA_override") else "waydroid_OTA"

if (img == "system"):

    with open('%s/system/lineage/waydroid_%s/VANILLA.json' % (basedir, arch)) as json_file:
        data = json.load(json_file)

        for p in data['response']:
            last=p
            break

        print(last["url"])

elif (img == "vendor"):

    if (arch == 'x86_64'):
        halium_ver = "MAINLINE"
    else:
        halium_ver = sys.argv[3]

    with open('%s/vendor/waydroid_%s/%s.json' % (basedir, arch, halium_ver)) as json_file:
        data = json.load(json_file)

        for p in data['response']:
            last=p
            break

        print(last["url"])

