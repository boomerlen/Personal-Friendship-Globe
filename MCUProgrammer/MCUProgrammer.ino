// Data pins to write to Memory
const data0 = 0;
const data1 = 1;
const data2 = 2;
const data3 = 3;
const data4 = 4;
const data5 = 5;
const data6 = 6;
const data7 = 7;

// Chip control pins 
const RST = 8;
const XTAL1 = 9;
const P3-2 = 10;
const P3-3 = 11;
const P3-4 = 12;
const P3-5 = 13;
const P3-7 = 18;


void setup() {
  // put your setup code here, to run once:
  pinMode(XTAL1, OUTPUT);
  pinMode(P3-2, OUTPUT);
  pinMode(P3-3, OUTPUT);
  pinMode(P3-4, OUTPUT);
  pinMode(P3-5, OUTPUT);
  pinMode(P3-7, OUTPUT);
}

void powerUp(){
  // Power-up sequence starts the mcu 
  // Power must be applied first (manually)
  digitalWrite(RST, LOW);
  digitalWrite(XTAL1, LOW);
  digitalWrite(RST, HIGH);
  digitalWrite(R3-2, HIGH);
}

void powerOff(){
  // Power-off sequence to turn off the mcu
  digitalWrite(XTAL1, LOW);
  digitalWrite(RST, LOW); 
  // Power must be disconnected manually
}

void configWrite(){
  // Configures the MCU to programming mode. Perform before writing code.
  digitalWrite(P3-3, LOW);
  digitalWrite(P3-4, HIGH);
  digitalWrite(P3-5, HIGH);
  digitalWrite(P3-7, HIGH);
  // Set RST to 12V (some difficulty is therefore presented)

  // Configure pins
  pinMode(data0, OUTPUT);
  pinMode(data1, OUTPUT);
  pinMode(data2, OUTPUT);
  pinMode(data3, OUTPUT);
  pinMode(data4, OUTPUT);
  pinMode(data5, OUTPUT);
  pinMode(data6, OUTPUT);
  pinMode(data7, OUTPUT);
}

void configRead(){
  // Configures the MCU to reading mode. Use to verify data 
  digitalWrite(RST, HIGH);
  digitalWrite(P3-2, HIGH);
  digitalWrite(P3-3, LOW);
  digitalWrite(P3-4, LOW);
  digitalWrite(P3-5, HIGH);
  digitalWrite(P3-7, HIGH);

  // Configure pins
  pinMode(data0, INPUT);
  pinMode(data1, INPUT);
  pinMode(data2, INPUT);
  pinMode(data3, INPUT);
  pinMode(data4, INPUT);
  pinMode(data5, INPUT);
  pinMode(data6, INPUT);
  pinMode(data7, INPUT);
}

void chipErase(){
  // Erases the chip (need to perform before programming new data if old data is there)
  // Need to set RST to 12V again 
  digitalWrite(P3-3, HIGH);
  digitalWrite(P3-4, LOW);
  digitalWrite(P3-5, LOW);
  digitalWrite(P3-7, LOW);
}

void programByte(byte b){
  // Programs a byte into the CURRENT ADDRESS LINE
  // DOES NOT increment the address counter.
   
  // data0 is the last bit. Start there. 
  digitalWrite(data0, b & 00000001);
  digitalWrite(data1, (b & 00000010) >> 1);
  digitalWrite(data2, (b & 00000100) >> 2);
  digitalWrite(data3, (b & 00001000) >> 3);
  digitalWrite(data4, (b & 00010000) >> 4);
  digitalWrite(data5, (b & 00100000) >> 5);
  digitalWrite(data6, (b & 01000000) >> 6);
  digitalWrite(data7, (b & 10000000) >> 7);
  }

  digitalWrite(P3-2, HIGH); // unsure how long this pulse should be.
  digitalWrite(P3-2, LOW);

  delay(2); // Time to write the byte. Could wait for the busy flag to no longer be set but this is an easy solution for now. 
}

byte readByte(){
  // Reads a byte from whichever address we're currently at.
  // Does NOT touch program counter (as usual)
  configRead();
  byte B;
  B & digitalRead(data0);
  B & (digitalRead(data1) << 1);
  B & (digitalRead(data2) << 2);
  B & (digitalRead(data3) << 3);
  B & (digitalRead(data4) << 4);
  B & (digitalRead(data5) << 5);
  B & (digitalRead(data6) << 6);
  B & (digitalRead(data7) << 7);
  return B;
}


bool programVerifyByte(byte b){
  // Programs and then verifies a byte. Returns true if the verification is successful.
  programByte(b);
  // RST needs to move to 6V (just HIGH not 12V)

  if(b == readByte()){
    return true;
  }
  return false;
}

void loop() {
  // put your main code here, to run repeatedly:

}
