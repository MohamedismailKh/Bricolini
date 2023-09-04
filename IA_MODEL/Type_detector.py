import numpy as np
import pandas as pd
import random as rd
import os
import tensorflow as tf
from tensorflow import keras
from sklearn.metrics import classification_report, confusion_matrix
import cv2
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
import tensorflow as tf
import matplotlib.pyplot as plt
from keras.utils import plot_model
from PIL import Image
from sklearn.metrics import classification_report, confusion_matrix
from keras.models import load_model

class Detector: 
    def __init__(self, basepath) :
        self.basepath = basepath
        self.model=load_model(self.basepath + 'classifier.h5')
    
    
    def detect(self, filename):
        if self.model is None:
            print("Model not loaded. Cannot predict.")
            return None, None
        img = cv2.imread(filename)

        if img is None:
            print(f"Error: Unable to load the image from '{filename}'.")
            return
        img = cv2.resize(img, (224, 224))
        img = img.astype('float32') / 255.0
        img = np.expand_dims(img, axis=-1)
        img = np.expand_dims(img, axis=0)
        probs = self.model.predict(img)
        pred_class = np.argmax(probs)
        class_labels = {0: 'bois', 1: 'constrcution', 2: 'metal'}
        pred_label = class_labels[pred_class]
        return probs, pred_label