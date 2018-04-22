import serial, time
import requests
import pyrebase
 
config = {
    "apiKey": "AIzaSyDPkFUJXTNqM9rs9TxzwXi_GOuiODC82_w",
    "authDomain": "live-temperature-9acef.firebaseapp.com",
    "databaseURL": "https://live-temperature-9acef.firebaseio.com",
    "storageBucket": "live-temperature-9acef.appspot.com"
}
firebase = pyrebase.initialize_app(config)
db = firebase.database()

DELAY = 1
  
arduino = serial.Serial('/dev/cu.usbmodem1411', 9600, timeout=2.0)
 
def get_value(arduino):
    while True:
        bytes = arduino.readline() 
        text = bytes.decode("utf-8").strip()
        if(text != "" and float(text) > 0):
            return float(text)
         
def postToFirebase(db, temp):
    data = {"value": temp}
    if(db.child("temp").child("current").get() == None):
        db.child("temp").child("current").set(data)
    else:
        db.child("temp").child("current").update(data)
    
    newData = {
    "value": temp,
    "timestamp" : time.time()
    }
    db.child("temp").child("all").push(newData)
     
time.sleep(3)
clock = time.time()
maxThreshold = 0.0
minThreshold = 0.0

while True:
    newMax = db.child("setting").get().val()["maxThreshold"]
    if(newMax != maxThreshold):
        maxThreshold = newMax
        encodedMax = str(maxThreshold).encode("utf-8")
        arduino.write(encodedMax)
        print("Sending max thres: "+ str(maxThreshold))
    newMin = db.child("setting").get().val()["minThreshold"]
    if(newMin != minThreshold):
        minThreshold = newMin
        # arduino.write("Min: " + str(minThreshold))
    tempInF = get_value(arduino)
    postToFirebase(db,tempInF)
    print("Temp: " + str(tempInF))
    while time.time() < clock + DELAY:
        time.sleep(1)
    clock = clock + DELAY
