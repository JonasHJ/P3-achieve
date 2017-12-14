#ifndef CRUST_CRUSTINTERFACE_H
#define CRUST_CRUSTINTERFACE_H

#include <Arduino.h>
#include "../Myo/MyoController.h"
#include "../Dynamixel/Dynamixel.h"

#define INTERFACE_DEBUG 0

class CrustInterface {
private:
    Dynamixel *servo;

public:
    virtual void begin(Dynamixel *in_servo);
    double readPosition(unsigned char servo_id); // [rad]
    void setTorque(const double tau[3]);
    void setTorque(const double tau, const unsigned char servo_id);
    void setTestMode(const unsigned char servo_id);
};


#endif //CRUST_CRUSTINTERFACE_H
