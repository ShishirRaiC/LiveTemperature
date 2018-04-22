/********************************************************************/
// First we include the libraries
#include <OneWire.h> 
#include <DallasTemperature.h>
#include <DHT.h>
#include "DHT.h"
#define DHTPIN 2
#define DHTTYPE DHT11
#define DC_MOTOR_PIN 8
DHT dht(DHTPIN, DHTTYPE);
const int LED_PIN=6;
const int g_pin = 5, y_pin = 4, r_pin = 3;
/********************************************************************/
// Data wire is plugged into pin 2 on the Arduino 
#define ONE_WIRE_BUS 2 
/********************************************************************/
// Setup a oneWire instance to communicate with any OneWire devices  
// (not just Maxim/Dallas temperature ICs) 
OneWire oneWire(ONE_WIRE_BUS); 
/********************************************************************/
// Pass our oneWire reference to Dallas Temperature. 
DallasTemperature sensors(&oneWire);
/********************************************************************/ 
void setup(void) 
{ 
 // start serial port 
 Serial.begin(9600); 
 pinMode( DC_MOTOR_PIN, OUTPUT );
 // Start up the library 
 sensors.begin(); 
} 
float maxTemp = 60;
void loop(void) 
{ 
  if (Serial.available()>0) {
    maxTemp = Serial.parseFloat();
  } 
 // call sensors.requestTemperatures() to issue a global temperature 
 // request to all devices on the bus 
/********************************************************************/
 sensors.requestTemperatures(); // Send the command to get temperature readings 
 float t = sensors.getTempFByIndex(0);
/********************************************************************/
 Serial.println(t);// Why "byIndex"?  
   // You can have more than one DS18B20 on the same bus.  
   // 0 refers to the first IC on the wire 
    if(t>0){
      if(t<=maxTemp){
        digitalWrite( DC_MOTOR_PIN, LOW );
      }
      else if(t>maxTemp){
        digitalWrite( DC_MOTOR_PIN, HIGH );
      }
    }
    delay(1000); 
}
