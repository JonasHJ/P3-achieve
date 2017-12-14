#include "CrustCrawler.h"

void CrustCrawler::begin(Dynamixel *servo) {
    CrustInterface::begin(servo);
    update_theta();
}

/**
 * Reads all servos current position and calculates the velocity it has moved since last update.
 * Then updates theta[] and d_theta[].
 */
void CrustCrawler::update_theta(){
    if(CRUSTCRAWLER_DEBUG)
        Serial.print(F("Theta dif:\t"));
    for (int i = 0; i < 3; ++i) {
        double old_theta = theta[i];
        theta[i] = readPosition(i+1);

        // [rad/s] Radians moved since last check devided by time
        d_theta[i] = (theta[i] - old_theta)/((millis() - last_update)/1000.0);

        if(isnan(d_theta[i]) || isinf(d_theta[i])){
            d_theta[i] = 0;
        }

        last_update = millis(); // Update time
        if(CRUSTCRAWLER_DEBUG){
            Serial.print((theta[i] - old_theta));Serial.print('\t');
        }


    }

    if(CRUSTCRAWLER_DEBUG){
        Serial.print('\n');

        Serial.print(F("Theta:\t\t"));
        Serial.print(theta[0]);Serial.print('\t');
        Serial.print(theta[1]);Serial.print('\t');
        Serial.println(theta[2]);

        Serial.print(F("d_Theta:\t"));
        Serial.print(d_theta[0]);Serial.print('\t');
        Serial.print(d_theta[1]);Serial.print('\t');
        Serial.println(d_theta[2]);
    }
}

const double* CrustCrawler::get_theta() {
    return theta;
}
const double* CrustCrawler::get_d_theta() {
    return d_theta;
}