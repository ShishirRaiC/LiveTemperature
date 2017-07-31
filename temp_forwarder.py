import serial, time
import requests
import pyrebase
 
  
DELAY = 1
  
arduino = serial.Serial('/dev/cu.usbmodem1411', 9600, timeout=2.0)
 
def get_value(arduino):
    while True:
        bytes = arduino.readline() 
        text = bytes.decode("utf-8").strip()
        return float(text)
         
def postToFirebase(db, temp):
    data = {"value": temp}
    if(db.child("temp").child("current").get() == None):
        db.child("temp").child("current").set(data)
    else:
        db.child("temp").child("current").update(data)
     
     
config = {
    "apiKey": "AIzaSyDPkFUJXTNqM9rs9TxzwXi_GOuiODC82_w",
    "authDomain": "live-temperature-9acef.firebaseapp.com",
    "databaseURL": "https://live-temperature-9acef.firebaseio.com",
    "storageBucket": "live-temperature-9acef.appspot.com"
}
firebase = pyrebase.initialize_app(config)
db = firebase.database()
 
time.sleep(3)
clock = time.time()
while True:
   temp = get_value(arduino)
   tempInF = (temp * 9/5) + 32
   print(tempInF)
   postToFirebase(db,tempInF)
   while time.time() < clock + DELAY:
       time.sleep(0.5)
   clock = clock + DELAY
