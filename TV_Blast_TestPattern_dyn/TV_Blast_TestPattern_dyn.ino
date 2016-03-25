/////////////////////////////////////////////////////////////////////////////////////////////
//  SPS Technology :: 2016  /////////////////////////////  Smart Motion Sensor TestPattern //
/////////////////////////////////////////////////////////////////////////////////////////////
#define frameX 176      // Разрешение по горизонтали
#define frameY 144      // Разрешение по вертикали
#define pxls frameX*frameY
int j;
int x,y;
int fon = 100;
int pix;

const unsigned char trio [] = {
//
};


//////////////////////////////////////  ИНИЦИАЛИЗАЦИЯ  ///////////////////////////////////////
void setup() {
  Serial.begin(56000);
}
//////////////////////////////////////  ОСНОВНОЙ ЦИКЛ  //////////////////////////////////////
void loop()
{
  Serial.write(255);                     // Отправляем тестовый градиент
  
    for (int i = 0;i <pxls; i++)
  {
   // Serial.write(random(0, 250));
   //  Serial.write(100);
   //  Serial.write(trio[i]);
   pix=fon;
   pix = rect(i, j, 80, j+20, 100, 15, pix);
   pix = rect(i, j+80, 80, j+80+20, 100, 15, pix);
   pix = rect(i, 50, 20, 130, 40, 180, pix);
   Serial.write(pix);
  }
  j+=10;
delay(100);
}
/////////////////////////////////////////////////////////////////////////////////////////////
int rect(int i, int x1, int y1, int x2, int y2, int grey, int pix)
{
    x=i/frameY;
    y=i-frameY*x;
  if (x>x1 && x<x2 && y>y1 &&y<y2) {return grey;}else{return pix;}
}
/*
  for (int i = 0;i <pxls; i++)
  {
    ter[i] = random(0, 225);
  }
  Serial.write(ter, pxls);
*/  
/*  
  Serial.write(255);                     // Отправляем тестовый градиент
  for (int i = 0;i <225; i++)
  {
    ter[i] = i;
  }
  Serial.write(ter, 225);
  */



