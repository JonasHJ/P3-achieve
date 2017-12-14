#include "CrustInterface.h"

/**
 * Sets the servos in "Torque mode".
 * @param in_servo
 */
void CrustInterface::begin(Dynamixel *in_servo) {
    servo = in_servo;

    unsigned char mode = 0x10; // Torquemode = 0x10
    servo->setTorqueMode(0x01,false);
    servo->setTorqueMode(0x02,false);
    servo->setTorqueMode(0x03,false);
    servo->setControlMode(0x01,mode);
    servo->setControlMode(0x02,mode);
    servo->setControlMode(0x03,mode);
    servo->setTorqueMode(0x01,true);
    servo->setTorqueMode(0x02,true);
    servo->setTorqueMode(0x03,true);
}



/**
 * Returns the servo_id position in radians.
 * @param servo_id
 * @return theta [rad]
 */
double CrustInterface::readPosition(unsigned char servo_id) {
    int step = servo->readPosition(servo_id);

    // Converts step into rad
    return ((step*0.088-180)*M_PI)/180;
}


void CrustInterface::setTorque(const double tau[3]) {
    for (int i = 0; i < 3; ++i) {
        setTorque(tau[i], i+1);
    }
}

/**
 * Converts the desired torque and sends the PWM value to servo.
 * @param tau
 */
void CrustInterface::setTorque(const double tau, const unsigned char servo_id) {
    // Convert torque to PWM
    unsigned short pwm = 0;

    if(servo_id == 1)
        pwm = lround(140.54*tau);
    else if(servo_id == 2)
        pwm = lround(125.48*tau) + 18;
    else if(servo_id == 3)
        pwm = lround(216.85*tau) + 16;

    servo->setPWM(servo_id, pwm);

    //Debug
    if(INTERFACE_DEBUG){
        Serial.print("pwm:\t");Serial.print(servo_id);Serial.print(" -> ");Serial.println(pwm);
    }
}

void CrustInterface::setTestMode(const unsigned char servo_id) {

    for (int i = 0; i < 3; ++i) {
        servo->setTorqueMode(i+1, false);
        servo->setControlMode(i+1, 0x03); // Position mode
        // servo->setPosition(1, theta[i]); // TODO:Convert rad to steps
        servo->setTorqueMode(i+1, true);
    }
    servo->setPosition(1, 2048);
    servo->setPosition(2, 2048); // Set to initial position
    servo->setPosition(3, 2048);

    // Wait for servos to reach position
    delay(5000);
    servo->setTorqueMode(servo_id, false); // Only set the testing servo back to torque-mode
    servo->setControlMode(servo_id, 0x10); // set Torque mode
    servo->setTorqueMode(servo_id, true);
}