#include <Arduino.h>
#include <SoftwareSerial.h>
#include "../lib/CrustCrawler/CrustCrawler.h"
#include "../lib/CrustCrawler/CrustAlgorithm.h"

SoftwareSerial mySerial(10, 11);
Dynamixel servo;

CrustCrawler crust;
CrustAlgorithm control(&crust);

void setup() {
    Serial.begin(57600);
    mySerial.begin(57600);
    servo.begin(mySerial);
    servo.setDirPin(0x02);
    crust.begin(&servo);
    delay(1000);

    // TODO: Test servo_id
    control.beginTest(3);
    Serial.println(F("Time\tDesired\tMeasured")); // Labels
}

void loop() {

    control.run();

    // Debug
    Serial.print('\n');
    //Serial.println(F("--------"));
}
