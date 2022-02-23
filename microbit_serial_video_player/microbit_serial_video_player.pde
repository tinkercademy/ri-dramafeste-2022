import processing.serial.*; // import serial library
import processing.video.*;  // import video library

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
String lastVal; // Last data received from serial port (to detect change in data)
Movie myMovie;  // Video object

void setup(){
  //video
  fullScreen(); // video will take up the entire screen when played
  surface.setAlwaysOnTop(false); // video can be hidden behind slides before trigger
  myMovie = new Movie(this, "video1.mp4"); // initiate movie object as "video1.mp4" from the data folder
  
  //Serial Port
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port if necessary
  myPort = new Serial(this, portName, 9600); // initiate new serial port with baud rate 9600 (should match the baud rate on the micro:bit)
}

void draw(){
  //video
  image(myMovie, 0, 0);
  
  // Serial Port
  if (myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n'); // read it and store it in val
  }
  //println(val);
  if (val != null && val != lastVal){ // if there is data and it is not the same as the last i.e. there is a change
    if (val.charAt(0) == 'A'){ // if the first letter of the message is "A"
      surface.setAlwaysOnTop(true); // video window is moved to the front
      myMovie.play(); // video plays
      surface.setAlwaysOnTop(false);
    }
  }
  lastVal = val;
}

void movieEvent(Movie m) {
  m.read();
}
