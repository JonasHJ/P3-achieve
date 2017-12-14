#include <Arduino.h>
#include <stdlib.h>
#include <stdio.h>

class Dynamixel
{
public:
    Dynamixel():   dirPin(-1) { }
    void           begin(Stream&);
    void           setDirPin(unsigned char);

    void           setControlMode(unsigned char, unsigned char);
    void           setTorqueMode(unsigned char, bool);
    void           setPWM(unsigned char, unsigned short);
    void           setCurrent(unsigned char, unsigned short);
    void           setVelocity(unsigned char, unsigned long int);
    void           setProfileVelocity(unsigned char, unsigned long int);
    void           setProfileAcceleration(unsigned char, unsigned int);
    void           setPosition(unsigned char, unsigned short);

    int            readPWM(unsigned char);
    int            readCurrent(unsigned char);
    int            readVelocity(unsigned char);
    int            readPosition(unsigned char);
    int            readVoltage(unsigned char);


////////////////// Unused functions //////////////////
// was not used in the finale tests of this project //
// some was for exploring the Dynamixels functions  //
// and some was for debugging                       //
    int            readtime(unsigned char);
    int            readMoving(unsigned char);
    int            readMovingStatus(unsigned char);
    int            readTemperature(unsigned char);

    void           Debug();
    void           outputInstruction();
    void           outputStatus();
    bool           readStatus();
/////////////////////////////////////////////////////

private:
    void           sendInstruction();
    void           clearBuffer();
    unsigned short update_crc(unsigned short, unsigned short);

    unsigned char  instructionBuffer[32];
    unsigned char  statusBuffer[32] = {0xFF, 0xFF, 0xFD, 0x00};
    unsigned char  dirPin;        // Pin to control TX/RX buffer chip
    Stream         *_serial;
};
