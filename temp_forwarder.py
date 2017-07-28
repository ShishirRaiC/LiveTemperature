import serial, time
import requests
import pyrebase

 
DELAY = 5
 
# arduino = serial.Serial('/dev/cu.usbmodem1411', 9600, timeout=2.0)
 
def get_value(arduino, value):
    text = "[" + value + "]\n"
    bytes = text.encode("latin-1")
    print("Writing " + text)
    arduino.write(bytes)
    while True:
        bytes = arduino.readline() 
        text = bytes.decode("utf-8").strip()
        if text != "?":
            text = text.replace("[","")
            text = text.replace("]","")
            text = text.replace(value,"")
            text = text.replace("=","")
            return float(text)
  
def postToStream(stream,
                 userid, city, state,
                 lat, lon,
                 temp,humidity, light,
                 outdoors):
    url = "http://drdelozier.pythonanywhere.com/stream/store/"
    payload = {
        'userid' : str(userid),
        'city' : str(city),
        'state' : str(state),
        'lat' : str(lat),
        'lon' : str(lon),
        'temp' : str(temp),
        'humidity' : str(humidity),
        'light' : str(light),
        'outdoors' : str(outdoors)
    }
    response = requests.get(url + stream, params = payload)
    print(response.status_code)
    print(response.url)
    print(response.text)

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
postToFirebase(db,90)

"""
time.sleep(3)
clock = time.time()
while True:
   temp = get_value(arduino,"TEMP")
   humidity = get_value(arduino,"HUMIDITY")
   print(temp, humidity)
   postToStream("beta",
                "stuladha", "Kent", "OH",
                41.14, -81.34,
                temp, humidity, 0,
                0)
   while time.time() < clock + DELAY:
       time.sleep(0.5)
   clock = clock + DELAY
"""
