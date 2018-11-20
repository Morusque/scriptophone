import processing.net.*;
import java.util.Map;
import java.io.FileWriter;
import java.io.*;

FileWriter fw;
BufferedWriter bw;

Server midiServer;
byte[] dataArray;

final int NOTE_COUNT = 128;
final int KEY_COUNT = 1024;
final int COM_PORT = 5504;

String txt = "";

boolean[] keysPressed = new boolean[KEY_COUNT]; 

// modifiers
boolean circumflexOn = false;
boolean tremaOn = false;

void setup() 
{
  //size(1024, 538);
  fullScreen();
  background(0);
  noCursor();
  for (int i=0; i<keysPressed.length; i++) keysPressed[i] = false;

  midiServer = new Server(this, COM_PORT);
  println("Midi Server Initialized");
  dataArray = new byte[] {0, 0};
}

void draw() 
{
  background(0xFF);
  fill(0);
  textSize(35);
  text(txt, 50, 50, width - 100, height - 100);
}

void delay(int time) 
{
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

void keyPressed() 
{
  if (keyCode >= KEY_COUNT)
  {
    println("KEY_COUNT too small");
    return;
  }

  keysPressed[keyCode] = true;
  if (keyCode == 38 && txt.length() > 0)
  {
    int index = txt.indexOf("\n");

    String toSave;

    if (index == -1) 
    {
      toSave = txt;
      txt = "";
    } else
    {
      toSave = txt.substring(0, index);
      txt = txt.substring(index + 1, txt.length());
    }

    try 
    {
      File file = new File("D:/Projets/DataBitMe/midiWriter/toPrint.txt");

      if (file.exists()) 
      {
        FileWriter fw = new FileWriter(file, false);///true = append
        BufferedWriter bw = new BufferedWriter(fw);
        PrintWriter pw = new PrintWriter(bw);

        pw.write(toSave);

        pw.close();
        //start /min 

        Runtime.getRuntime().exec("notepad /P D:/Projets/DataBitMe/midiWriter/toPrint.txt");
      }
    } 
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  // SPACE
  if (keyCode==32 || keyCode==ENTER) 
  {
    sendStopAll();
  }

  if (key != CODED && keyCode != SHIFT)
  {
    if (keyCode != 32 && keyCode != ENTER)
    {
      sendNote(keyCode, 127);
    }

    String newChar = "";

    if (keyCode == BACKSPACE) 
    {
      if (txt.length() > 0)
      {
        txt = txt.substring(0, txt.length()-1);
      }
    } else if (!tremaOn && !circumflexOn)
    {
      newChar = key+"";
    } else
    { 
      if (circumflexOn && key == 'a') newChar = "â";
      else if (circumflexOn && key == 'e') newChar = "ê";
      else if (circumflexOn && key == 'i') newChar = "î";
      else if (circumflexOn && key == 'o') newChar = "ô";
      else if (circumflexOn && key == 'u') newChar = "û";
      else if (circumflexOn && key == 'A') newChar = "Â";
      else if (circumflexOn && key == 'E') newChar = "Ê";
      else if (circumflexOn && key == 'I') newChar = "Î";
      else if (circumflexOn && key == 'O') newChar = "Ô";
      else if (circumflexOn && key == 'U') newChar = "Û";
      else if (tremaOn && key == 'a') newChar = "ä";
      else if (tremaOn && key == 'e') newChar = "ë";
      else if (tremaOn && key == 'i') newChar = "ï";
      else if (tremaOn && key == 'o') newChar = "ö";
      else if (tremaOn && key == 'u') newChar = "ü";
      else if (tremaOn && key == 'A') newChar = "Ä";
      else if (tremaOn && key == 'E') newChar = "Ë";
      else if (tremaOn && key == 'I') newChar = "Ï";
      else if (tremaOn && key == 'O') newChar = "Ö";
      else if (tremaOn && key == 'U') newChar = "Ü";
      else newChar = key+"";
    }

    txt = txt + newChar;

    circumflexOn = false;
    tremaOn = false;
  } else
  {
    if (keysPressed[ENTER])
    {
      txt = txt + "\r\n";
    } else if (keyCode == 130)
    {
      if (keysPressed[SHIFT])
      {
        tremaOn = true;
      } else
      {
        circumflexOn = true;
      }
    } else 
    {
      println(keyCode);
    }
  }
}

void sendNote(int note, int velocity)
{
  dataArray[0] = (byte)note;
  dataArray[1] = (byte)velocity;

  //println(note + "=" + dataArray[0] + " / " + velocity  + " = " + dataArray[1]);

  if (midiServer.active() == true)
  {
    midiServer.write(dataArray); 
    //println("sent: " + note + " - " + velocity);
  } else 
  {
    println("Midi server is not active.");
  }
}

void sendStopAll()
{
  byte[] data = new byte[NOTE_COUNT*2];
  for (int i = 0; i < NOTE_COUNT; ++i)
  {
    data[2*i] = (byte)i;
    data[2*i +1] = 0;
  }

  if (midiServer.active() == true)
  {
    midiServer.write(data);
    //println("sent: " + note + " - " + velocity);
  } else 
  {
    println("Midi server is not active.");
  }

  //println("Sent: Stop All");
}

void keyReleased() 
{
  keysPressed[keyCode%keysPressed.length] = false;
}

void exit()
{
  midiServer.stop();
}
