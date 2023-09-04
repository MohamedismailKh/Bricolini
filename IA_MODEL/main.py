import time
import random
import string
import sys
from Type_detector import Detector
#sys.path.append('/home/ubuntu/.local/lib/python3.10/site-packages/')
import json
import json
import sys
import json
import sys

BASEPATH = "/uploads" 

def image_save(image, name):
    image = image.convert("RGB")
    image.save(name + ".jpg")

detector = Detector(BASEPATH)

if len(sys.argv) > 1:
    filename = sys.argv[1]
    result = detector.detect(filename)
    probabilities_list = result[0].tolist()

    obj = { "Garbage type": result[1], "probability distribution": probabilities_list }
    json_obj = json.dumps(obj)
    print(json_obj)
else:
    #print("Error: not enough argument !", file=sys.stderr)
    pass