
import processing.net.*; 
import themidibus.*;

MidiBus myBus;

Client myClient;
byte[] dataIn; 

void setup() {
  size(200, 200);
  MidiBus.list();
  myBus = new MidiBus(this, -1, "loopMIDI Port");  
  myClient = new Client(this, "192.168.43.196", 5504);
  for (int b=0; b<128; b++) sendNote((byte)b, (byte)0);
} 

void draw() {
  if (!myClient.active()) {
    println("reset client");
    myClient.stop();
    myClient = new Client(this, "192.168.43.237", 5504);
  }
  while (myClient.available() > 0) { 
    dataIn = myClient.readBytes(2);
    if (dataIn.length==2) sendNote(dataIn[0], dataIn[1]);
    //println("data received");
  }
  if (frameCount==1) println("first frame");
}

void sendNote(byte note, byte velo) {
  println(note+" "+velo);
  if (velo>0) myBus.sendNoteOn(0, note, velo);
  else myBus.sendNoteOff(0, note, 100);
}

void keyPressed() {
  if (keyCode==32) {
    for (int b=0; b<128; b++) sendNote((byte)b, (byte)0);
  } else {
    sendNote((byte)keyCode, (byte)127);
  }
}

void exit() {
  myClient.stop();
}