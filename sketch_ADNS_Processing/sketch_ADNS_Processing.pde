//RUN AND PRESS ANY KEY TO GRAB THE FRAME
//Contact me webaff.ru[@]gmail.com for details or any questions.
 
import processing.serial.*;
 
Serial com;
 
final int frameX = 15;
final int frameY = 15;
final int frameSZ = 20;
 
int[] frame;
int framepos=0;
void setup()
{
  size( 300, 300 );
  frame = new int[frameX*frameY];
  com = new Serial(this, "COM3", 9600);
  noStroke();
  noSmooth();
}
 
void draw()
{
  background(0);
  int readpos=0;
  for(int i=0;i<frameX;i++)
  {
    for(int j=frameY-1;j>=0;j--)
    {
       fill(map(frame[readpos], 0, 63, 0, 225));
       rect(i * frameSZ, j * frameSZ, frameSZ, frameSZ);
       readpos++;
    }
  } //<>// //<>//
  delay(500);
  keyPressed();
}
 
void keyPressed()
{
  framepos=0;
  com.write('F');
}
 
void serialEvent(Serial p)
{
  int c = p.read();
  if(framepos < frameX*frameY)
  {
    frame[framepos]=c;
    framepos++;
  }
}