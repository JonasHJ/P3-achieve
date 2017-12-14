// Only works with Arduino uno        //
// for more functions or knowledge    //
// look at Dynamixels chart at        //
// http://support.robotis.com/en/product/actuator/dynamixel/mx_series/mx-64(2.0).htm#bookmark16



#include "Dynamixel.h"

void Dynamixel::begin(Stream &serial){
  _serial = &serial;  // Set a reference to a specified Stream object (Hard or Soft Serial)
}

void Dynamixel::setDirPin(unsigned char dPin){
  dirPin = dPin;
  pinMode(dirPin,OUTPUT); // We define a pin to signal when an instruction packet is beign sent.
}

void Dynamixel::setControlMode(unsigned char ID, unsigned char cMode){
  instructionBuffer[4]=ID; //Dynamixel ID
  instructionBuffer[5]=0x06; //Packet Length LSB
  instructionBuffer[6]=0x00; //Packet Length MSB
  instructionBuffer[7]=0x03; //Write Instruction
  instructionBuffer[8]=0x0B; //Control Parameter LSB
  instructionBuffer[9]=0x00; //Control Parameter MSB
  instructionBuffer[10]=cMode; //Control Mode Parameter
  sendInstruction();
  readStatus();
}

void Dynamixel::setTorqueMode(unsigned char ID, bool tMode){
  instructionBuffer[4]=ID; //Dynamixel ID
  instructionBuffer[5]=0x06; //Packet Length LSB
  instructionBuffer[6]=0x00; //Packet Length MSB
  instructionBuffer[7]=0x03; //Write Instruction
  instructionBuffer[8]=0x40; //Control Parameter LSB
  instructionBuffer[9]=0x00; //Control Parameter MSB
  instructionBuffer[10]=tMode; //Torque Enable/Disable Parameter
  sendInstruction();
  readStatus();
}

void Dynamixel::setPWM(unsigned char ID, unsigned short PWM){
  instructionBuffer[4] = ID; //Dynamixel ID
  instructionBuffer[5] = 0x07; //Packet Length LSB
  instructionBuffer[6] = 0x00; //Packet Length MSB
  instructionBuffer[7] = 0x03; //Write Instruction
  instructionBuffer[8] = 0x64; //Current Parameter LSB
  instructionBuffer[9] = 0x00; //Current Parameter MSB
  instructionBuffer[10] = PWM & 0x00FF;
  instructionBuffer[11] = PWM >> 8;
  sendInstruction();
  readStatus();
}

void Dynamixel::setCurrent(unsigned char ID, unsigned short current){
  instructionBuffer[4] = ID; //Dynamixel ID
  instructionBuffer[5] = 0x07; //Packet Length LSB
  instructionBuffer[6] = 0x00; //Packet Length MSB
  instructionBuffer[7] = 0x03; //Write Instruction
  instructionBuffer[8] = 0x66; //Current Parameter LSB
  instructionBuffer[9] = 0x00; //Current Parameter MSB
  instructionBuffer[10] = current & 0x00FF;
  instructionBuffer[11] = current >> 8;
  sendInstruction();
  readStatus();
}

void Dynamixel::setVelocity(unsigned char ID, unsigned long int velocity){
  instructionBuffer[4] = ID; //Dynamixel ID
  instructionBuffer[5] = 0x09; //Packet Length LSB
  instructionBuffer[6] = 0x00; //Packet Length MSB
  instructionBuffer[7] = 0x03; //Write Instruction
  instructionBuffer[8] = 0x68; //Velocity Parameter LSB
  instructionBuffer[9] = 0x00; //Velocity Parameter MSB
  instructionBuffer[10] = (velocity & 0xFF);
  instructionBuffer[11] = (velocity >> 8);
  instructionBuffer[12] = (velocity >> 16);
  instructionBuffer[13] = (velocity >> 24);
  sendInstruction();
  readStatus();
}

void Dynamixel::setProfileVelocity(unsigned char ID, unsigned long int Pvel){
  instructionBuffer[4] = ID; //Dynamixel ID
  instructionBuffer[5] = 0x09; //Packet Length LSB
  instructionBuffer[6] = 0x00; //Packet Length MSB
  instructionBuffer[7] = 0x03; //Write Instruction
  instructionBuffer[8] = 0x70; //Current Parameter LSB
  instructionBuffer[9] = 0x00; //Current Parameter MSB
  instructionBuffer[10] = Pvel & 0x00FF;
  instructionBuffer[11] = Pvel >> 8;
  instructionBuffer[12] = Pvel >> 16;
  instructionBuffer[13] = Pvel >> 24;
  sendInstruction();
  readStatus();
}

void Dynamixel::setProfileAcceleration(unsigned char ID, unsigned int pac){
  instructionBuffer[4] = ID; //Dynamixel ID
  instructionBuffer[5] = 0x09; //Packet Length LSB
  instructionBuffer[6] = 0x00; //Packet Length MSB
  instructionBuffer[7] = 0x03; //Write Instruction
  instructionBuffer[8] = 0x6C; //Current Parameter LSB
  instructionBuffer[9] = 0x00; //Current Parameter MSB
  instructionBuffer[10] = pac & 0x00FF;
  instructionBuffer[11] = pac >> 8;
  instructionBuffer[12] = pac >> 16;
  instructionBuffer[13] = pac >> 24;
  sendInstruction();
  readStatus();
}

void Dynamixel::setPosition(unsigned char ID, unsigned short position){
  instructionBuffer[4] = ID; //Dynamixel ID
  instructionBuffer[5] = 0x09; //Packet Length LSB
  instructionBuffer[6] = 0x00; //Packet Length MSB
  instructionBuffer[7] = 0x03; //Write Instruction
  instructionBuffer[8] = 0x74; //Current Parameter LSB
  instructionBuffer[9] = 0x00; //Current Parameter MSB
  instructionBuffer[10] = position & 0x00FF;
  instructionBuffer[11] = position >> 8;
  instructionBuffer[12] = position >> 16;
  instructionBuffer[13] = position >> 24;
  sendInstruction();
  readStatus();
}

int Dynamixel::readPWM(unsigned char ID){
  instructionBuffer[4]=ID; //Dynamixel ID
  instructionBuffer[5]=0x07; //Packet Length LSB
  instructionBuffer[6]=0x00; //Packet Length MSB
  instructionBuffer[7]=0x02; //Read Instruction
  instructionBuffer[8]=0x7C; //Current Parameter LSB
  instructionBuffer[9]=0x00; //Current Parameter MSB
  instructionBuffer[10]=0x02; //Status Packet Parameter Length LSB
  instructionBuffer[11]=0x00; //Status Packet Parameter Length MSB
  sendInstruction();
  readStatus();
  if(statusBuffer[8]==0)
    return ( (statusBuffer[10]<<8) | statusBuffer[9] );
}

int Dynamixel::readCurrent(unsigned char ID){
  instructionBuffer[4]=ID; //Dynamixel ID
  instructionBuffer[5]=0x07; //Packet Length LSB
  instructionBuffer[6]=0x00; //Packet Length MSB
  instructionBuffer[7]=0x02; //Read Instruction
  instructionBuffer[8]=0x7E; //Current Parameter LSB
  instructionBuffer[9]=0x00; //Current Parameter MSB
  instructionBuffer[10]=0x02; //Status Packet Parameter Length LSB
  instructionBuffer[11]=0x00; //Status Packet Parameter Length MSB
  sendInstruction();
  readStatus();
  if(statusBuffer[8]==0)
    return ( (statusBuffer[10]<<8) | statusBuffer[9] );
}

int Dynamixel::readVelocity(unsigned char ID){
  instructionBuffer[4]=ID; //Dynamixel ID
  instructionBuffer[5]=0x07; //Packet Length LSB
  instructionBuffer[6]=0x00; //Packet Length MSB
  instructionBuffer[7]=0x02; //Read Instruction
  instructionBuffer[8]=0x80; //Velocity Parameter LSB
  instructionBuffer[9]=0x00; //Velocity Parameter MSB
  instructionBuffer[10]=0x04; //Status Packet Parameter Length LSB
  instructionBuffer[11]=0x00; //Status Packet Parameter Length MSB
  sendInstruction();
  readStatus();
  if(statusBuffer[8]==0)
    return ( (statusBuffer[10]<<8) | statusBuffer[9] );
}

int Dynamixel::readPosition(unsigned char ID){
  instructionBuffer[4]=ID; //Dynamixel ID
  instructionBuffer[5]=0x07; //Packet Length LSB
  instructionBuffer[6]=0x00; //Packet Length MSB
  instructionBuffer[7]=0x02; //Read Instruction
  instructionBuffer[8]=0x84; //Velocity Parameter LSB
  instructionBuffer[9]=0x00; //Velocity Parameter MSB
  instructionBuffer[10]=0x04; //Status Packet Parameter Length LSB
  instructionBuffer[11]=0x00; //Status Packet Parameter Length MSB
  sendInstruction();
  readStatus();
  if(statusBuffer[8]==0)
    return ( (statusBuffer[10]<<8) | statusBuffer[9] );
}

int Dynamixel::readVoltage(unsigned char ID){
  instructionBuffer[4]=ID; //Dynamixel ID
  instructionBuffer[5]=0x07; //Packet Length LSB
  instructionBuffer[6]=0x00; //Packet Length MSB
  instructionBuffer[7]=0x02; //Read Instruction
  instructionBuffer[8]=0x90; //Current Parameter LSB
  instructionBuffer[9]=0x00; //Current Parameter MSB
  instructionBuffer[10]=0x02; //Status Packet Parameter Length LSB
  instructionBuffer[11]=0x00; //Status Packet Parameter Length MSB
  sendInstruction();
  readStatus();
  if(statusBuffer[8]==0)
    return ( (statusBuffer[10]<<8) | statusBuffer[9] );
}

////////////////// Unused functions ///////////////
int Dynamixel::readtime(unsigned char ID){ // goes to 32767 then back to 0
  instructionBuffer[4]=ID; //Dynamixel ID
  instructionBuffer[5]=0x07; //Packet Length LSB
  instructionBuffer[6]=0x00; //Packet Length MSB
  instructionBuffer[7]=0x02; //Read Instruction
  instructionBuffer[8]=0x78; //Current Parameter LSB
  instructionBuffer[9]=0x00; //Current Parameter MSB
  instructionBuffer[10]=0x02; //Status Packet Parameter Length LSB
  instructionBuffer[11]=0x00; //Status Packet Parameter Length MSB
  sendInstruction();
  readStatus();
  if(statusBuffer[8]==0)
    return ((statusBuffer[10]<<8) | statusBuffer[9]);
}

int Dynamixel::readMoving(unsigned char ID){
  instructionBuffer[4]=ID; //Dynamixel ID
  instructionBuffer[5]=0x08; //Packet Length LSB
  instructionBuffer[6]=0x00; //Packet Length MSB
  instructionBuffer[7]=0x02; //Read Instruction
  instructionBuffer[8]=0x7A; //Current Parameter LSB
  instructionBuffer[9]=0x00; //Current Parameter MSB
  instructionBuffer[10]=0x02; //Status Packet Parameter Length LSB
  instructionBuffer[11]=0x00; //Status Packet Parameter Length MSB
  sendInstruction();
  readStatus();
  if(statusBuffer[8]==0)
    return ( (statusBuffer[10]<<8) | statusBuffer[9] );
}

int Dynamixel::readMovingStatus(unsigned char ID){
  instructionBuffer[4]=ID; //Dynamixel ID
  instructionBuffer[5]=0x08; //Packet Length LSB
  instructionBuffer[6]=0x00; //Packet Length MSB
  instructionBuffer[7]=0x02; //Read Instruction
  instructionBuffer[8]=0x7B; //Current Parameter LSB
  instructionBuffer[9]=0x00; //Current Parameter MSB
  instructionBuffer[10]=0x02; //Status Packet Parameter Length LSB
  instructionBuffer[11]=0x00; //Status Packet Parameter Length MSB
  sendInstruction();
  readStatus();
  if(statusBuffer[8]==0)
    return ( (statusBuffer[10]<<8) | statusBuffer[9] );
}

int Dynamixel::readTemperature(unsigned char ID){
  instructionBuffer[4]=ID; //Dynamixel ID
  instructionBuffer[5]=0x08; //Packet Length LSB
  instructionBuffer[6]=0x00; //Packet Length MSB
  instructionBuffer[7]=0x02; //Read Instruction
  instructionBuffer[8]=0x92; //Current Parameter LSB
  instructionBuffer[9]=0x00; //Current Parameter MSB
  instructionBuffer[10]=0x02; //Status Packet Parameter Length LSB
  instructionBuffer[11]=0x00; //Status Packet Parameter Length MSB
  sendInstruction();
  readStatus();
  if(statusBuffer[8]==0)
    return ( (statusBuffer[10]<<8) | statusBuffer[9] );
}
///////////////////////////////////////////////////////////
void Dynamixel::Debug(){
  delay(500);
  outputInstruction();
  outputStatus();
}

void Dynamixel::outputInstruction(){

  unsigned char length = ( (instructionBuffer[6]<<8) | instructionBuffer[5] );
  Serial.print("Instruction Packet: ");
  for(int c=0;c<length+7;c++){
    Serial.print(" | ");
    Serial.print(instructionBuffer[c]);
  }
  Serial.println(" | ");
}

void Dynamixel::outputStatus(){
  unsigned char length = (statusBuffer[6]<<8) | statusBuffer[5];
  Serial.print("Status Packet: ");
  for(int c=0;c<length+7;c++){
    Serial.print(" | ");
    Serial.print(statusBuffer[c]);
  }
  Serial.println(" | ");
}

void Dynamixel::sendInstruction(){
  clearBuffer();
  if (dirPin > -1){            //Check if value has been changed from initial direction_pin.
    digitalWrite(dirPin,HIGH);}  // Set TX Buffer to HIGH. Ready to transmit instruction.

  unsigned short length = ( (instructionBuffer[6]<<8) | instructionBuffer[5] );

  instructionBuffer[0] = 0xFF;        //Set headers and reserved (0xFF, 0xFF, 0xFD, 0x00).
  instructionBuffer[1] = 0xFF;
  instructionBuffer[2] = 0xFD;
  instructionBuffer[3] = 0x00;
  unsigned short crc_combined = update_crc(0, length+5);  //Call CRC function, and set CRC values.

  //Split crc_combined in CRC_L and CRC_H. Below code is nicked from support.robotis:
  instructionBuffer[length+5] = (crc_combined & 0x00FF); //CRC_L
  instructionBuffer[length+6] = (crc_combined>>8) & 0x00FF; // CRC_H

  //Serial.write the entire array.
  for(unsigned char c=0;c<length+7;c++){
    _serial->write(instructionBuffer[c]);
  }

  _serial->flush();

  if (dirPin > -1){                  //Check if value has been changed from initial direction_pin.
    digitalWrite(dirPin,LOW);}  // Set TX Buffer to LOW. No more instructions to transmit. Ready 2 read again.

}

bool Dynamixel::readStatus(){
  unsigned long Time_Counter = millis() + 100;      // Setup time out error

  while(_serial->available() <= 7){                // Wait for header, reserved, ID and length
    if (millis() >= Time_Counter){
      Serial.println("Status packet timed out.");  //Error if no packet is received.
      return 0;
    }
  }

  for(int c=0; c<4; c++){
    if(statusBuffer[c] != _serial->read()){
      //Serial.println("Erroneous status packet.");
      clearBuffer();
      return 0;
    }
  }

  statusBuffer[4] = _serial->read();
  statusBuffer[5] = _serial->read();
  statusBuffer[6] = _serial->read();

  unsigned char length = (statusBuffer[6]<<8) | statusBuffer[5];

  for(int c=0;c<length;c++){
    statusBuffer[c+7]=_serial->read();
  }

  return 1;
}

unsigned short Dynamixel::update_crc(unsigned short crc_accum, unsigned short length){
  unsigned short i, j;
  unsigned short crc_table[256] = {
          0x0000, 0x8005, 0x800F, 0x000A, 0x801B, 0x001E, 0x0014, 0x8011,
          0x8033, 0x0036, 0x003C, 0x8039, 0x0028, 0x802D, 0x8027, 0x0022,
          0x8063, 0x0066, 0x006C, 0x8069, 0x0078, 0x807D, 0x8077, 0x0072,
          0x0050, 0x8055, 0x805F, 0x005A, 0x804B, 0x004E, 0x0044, 0x8041,
          0x80C3, 0x00C6, 0x00CC, 0x80C9, 0x00D8, 0x80DD, 0x80D7, 0x00D2,
          0x00F0, 0x80F5, 0x80FF, 0x00FA, 0x80EB, 0x00EE, 0x00E4, 0x80E1,
          0x00A0, 0x80A5, 0x80AF, 0x00AA, 0x80BB, 0x00BE, 0x00B4, 0x80B1,
          0x8093, 0x0096, 0x009C, 0x8099, 0x0088, 0x808D, 0x8087, 0x0082,
          0x8183, 0x0186, 0x018C, 0x8189, 0x0198, 0x819D, 0x8197, 0x0192,
          0x01B0, 0x81B5, 0x81BF, 0x01BA, 0x81AB, 0x01AE, 0x01A4, 0x81A1,
          0x01E0, 0x81E5, 0x81EF, 0x01EA, 0x81FB, 0x01FE, 0x01F4, 0x81F1,
          0x81D3, 0x01D6, 0x01DC, 0x81D9, 0x01C8, 0x81CD, 0x81C7, 0x01C2,
          0x0140, 0x8145, 0x814F, 0x014A, 0x815B, 0x015E, 0x0154, 0x8151,
          0x8173, 0x0176, 0x017C, 0x8179, 0x0168, 0x816D, 0x8167, 0x0162,
          0x8123, 0x0126, 0x012C, 0x8129, 0x0138, 0x813D, 0x8137, 0x0132,
          0x0110, 0x8115, 0x811F, 0x011A, 0x810B, 0x010E, 0x0104, 0x8101,
          0x8303, 0x0306, 0x030C, 0x8309, 0x0318, 0x831D, 0x8317, 0x0312,
          0x0330, 0x8335, 0x833F, 0x033A, 0x832B, 0x032E, 0x0324, 0x8321,
          0x0360, 0x8365, 0x836F, 0x036A, 0x837B, 0x037E, 0x0374, 0x8371,
          0x8353, 0x0356, 0x035C, 0x8359, 0x0348, 0x834D, 0x8347, 0x0342,
          0x03C0, 0x83C5, 0x83CF, 0x03CA, 0x83DB, 0x03DE, 0x03D4, 0x83D1,
          0x83F3, 0x03F6, 0x03FC, 0x83F9, 0x03E8, 0x83ED, 0x83E7, 0x03E2,
          0x83A3, 0x03A6, 0x03AC, 0x83A9, 0x03B8, 0x83BD, 0x83B7, 0x03B2,
          0x0390, 0x8395, 0x839F, 0x039A, 0x838B, 0x038E, 0x0384, 0x8381,
          0x0280, 0x8285, 0x828F, 0x028A, 0x829B, 0x029E, 0x0294, 0x8291,
          0x82B3, 0x02B6, 0x02BC, 0x82B9, 0x02A8, 0x82AD, 0x82A7, 0x02A2,
          0x82E3, 0x02E6, 0x02EC, 0x82E9, 0x02F8, 0x82FD, 0x82F7, 0x02F2,
          0x02D0, 0x82D5, 0x82DF, 0x02DA, 0x82CB, 0x02CE, 0x02C4, 0x82C1,
          0x8243, 0x0246, 0x024C, 0x8249, 0x0258, 0x825D, 0x8257, 0x0252,
          0x0270, 0x8275, 0x827F, 0x027A, 0x826B, 0x026E, 0x0264, 0x8261,
          0x0220, 0x8225, 0x822F, 0x022A, 0x823B, 0x023E, 0x0234, 0x8231,
          0x8213, 0x0216, 0x021C, 0x8219, 0x0208, 0x820D, 0x8207, 0x0202
  };
  for(j = 0; j < length; j++)
  {
    i = ((unsigned short)(crc_accum >> 8) ^ instructionBuffer[j]) & 0xFF;
    crc_accum = (crc_accum << 8) ^ crc_table[i];
  }
  return crc_accum;
}

void Dynamixel::clearBuffer(){
  while (_serial->read() != -1);  // Clear RX buffer;
}
