/////////////////////////////////////////////////////////////////////////////////////////////
//  SPS Technology :: 2016  //////////////////////////////////////  OV7670 Camera Grabber  //
/////////////////////////////////////////////////////////////////////////////////////////////
import processing.serial.*;
Serial port;

final int frameX = 94;      // Разрешение по горизонтали
final int frameY = 240;      // Разрешение по вертикали
final int frameSZ = 4;       // Масштаб пикселя

final int bufsize = frameX*frameY+11;

boolean   recive = false;    // Статус приема
int       rx;                // Буфер принятого байта
int[]     frame;             // Массив кадра
int[]     postframe;         // Массив кадра на вывод
int       framepos=0;        // Позиция в массиве кадра

PFont     font;              // Шрифт

int       secstore;          // Временная переменная для отлова смены секунд
int       timer;
float     fps,postfps;
int       grafbuf;

//////////////////////////////////////  ИНИЦИАЛИЗАЦИЯ  ///////////////////////////////////////
void setup()
{
  size( 640, 502 );                          // Размер окна Windows для отрисовки
  frame = new int[bufsize];                  // Выделяем память
  postframe = new int[bufsize];              // Выделяем память
  
  port = new Serial(this, "COM3", 234000);   // Подключаемся к СОМ-порту

  font = loadFont("Vrinda-Bold-16.vlw");
  textFont(font,16);
  
  noStroke();                                // Не обводить квараты рамкой
  smooth();                                  // Не сглаживать грани
}
//////////////////////////////////////  ОСНОВНОЙ ЦИКЛ  //////////////////////////////////////
void draw()
{
//--------------------------------------------------------------------------------------------------------------------
  background(0);
  
  int readpos=0;                                               // Начинаем сначала
    for(int j=0;j<frameY;j++)                               // Координаты по Y
  {
    for(int i=0;i<frameX;i++)                                    // Координаты по Х
    {
       fill(postframe[readpos]);                               // Преобразуем диапазон входных чисел
    //   fill(map(frame[readpos], 0, 15, 0, 250));             // Преобразуем диапазон входных чисел
       rect(i * frameSZ, j * frameSZ/2, frameSZ, frameSZ/2);   // Рисуем квадраты
       readpos++;                                              // Переходим к следующей ячейке
    }
  }
//--------------------------------------------------------------------------------------------------------------------  
  stroke(255);                                                  // Отрисовываем горизонтальную линию разделения
  line(0,height-22,width,height-22);                                        
  noStroke();
//--------------------------------------------------------------------------------------------------------------------  
  fill(255);             
  textFont(font,16);                                            // Отрисовываем логотип
  textAlign(RIGHT); //<>// //<>//
  text(":: SPS TECH :: 2016 ::",width-5,height-6);             
//-------------------------------------------------------------------------------------------------------------------- 
  textAlign(LEFT);                                              // Отображаем FPS   
  text(postfps+" fps",5,height-6);
  
  if(second()!=secstore)TimerUpdate();
  secstore=second();
//--------------------------------------------------------------------------------------------------------------------  
  textFont(font,8);                                             // Графики
  text("BUF",60,height-12);                           
  rect(85,height-16,map(framepos,0,bufsize,0,60),4);            // График заполнения буфера
  fill(100); 
  text("FPS",60,height-4);                            
  rect(85,height-8,timer*6,4);                                  // График таймера FPS
  //-------------------------------------------------------------------------------------------------------------------- 
}
//////////////////////////////////////// ПРИЕМ ДАННЫХ ///////////////////////////////////////
void serialEvent(Serial p)
{
  rx = p.read();                             // Считываем принятый байт из порта
    
  if(recive)                                 // Прием пакета
  {
    if(framepos < bufsize)                   // Складываем принятые байты в буфер
    {
      frame[framepos]=rx;
      framepos++;
    }
    if(framepos == bufsize)                  // Закончили, отключили прием, збросили счетчик
    {
      recive = false;
    }
  }
  if( rx == 0xFF){
    recive = true;                           // Если это маркер начала, запускаем прием пакета
    framepos=0;
    arrayCopy(frame, postframe);
    fps++;
  }
}

//////////////////////////////////////// ВЫЧЕСЛЯЕМ FPS //////////////////////////////////////
void TimerUpdate()
{
  timer++;
  if (timer>10){
     postfps = fps/10;
     timer=0;
     fps=0;
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////