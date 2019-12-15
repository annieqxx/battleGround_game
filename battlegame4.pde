PImage img1;
PImage img2;
PImage img3;
PImage img4;
PImage img5;
PImage img6;
PImage img7;

int yloc = 100;
int xloc = 120;
int yloc1 = 100;
int xloc1 = 980;
int frmcnt = 0;
int fires = 0;
int fires1 = 0;
int Lfirefrms[] = new int[2000];
int LfireY[] = new int[2000];
int Rfirefrms[] = new int[2000];
int RfireY[] = new int[2000];
int discard = -1;
int dmgY = -100;
int dmgY1 = -100;
int p2Health = 100;
int p1Health = 100;
int dmgamt = 20;

void reset(){
   yloc = 100;
   xloc = 120;
   yloc1 = 100;
   xloc1 = 980;
   frmcnt = 0;
   fires = 0;
   fires1 = 0;
   discard = -1;
   dmgY = -100;
   dmgY1 = -100;
   p2Health = 100;
   p1Health = 100;
   dmgamt = 20;
}

void setup() 
{
  size(1200, 1000);
  img1=loadImage("background.jpg");
  img2=loadImage("plane1L.jpg");
  img3=loadImage("plane1R.jpg");
  img4=loadImage("plane2L.jpg");
  img5=loadImage("plane2R.jpg");
  img6=loadImage("plane4L.jpg");
  img7=loadImage("plane4R.jpg");
}

void draw()
{
  background(img1);
  frmcnt += 1; //<>//
  drawplane(xloc,yloc);
  drawplane2(xloc1,yloc1);
  
  dmgY = BulletL(Lfirefrms, LfireY, frmcnt, fires);
  dmgY1 = BulletR(Rfirefrms, RfireY, frmcnt, fires1);
  
  if (abs(float(dmgY - (yloc1 + 7))) < 60)
  {
    p2Health -= dmgamt;
    fill(255,100,0,80);
    ellipse(xloc1 + 8, yloc1 + 15, 60, 60);
  }
  
  if (abs(float(dmgY1 - (yloc + 1))) < 60)
  {
    p1Health -= dmgamt;
    fill(255,100,0,80);
    ellipse(xloc + 58, yloc + 15, 60, 60);
  }
  
  healthdisp(xloc - 30, yloc,p1Health);
  healthdisp(xloc1, yloc1,p2Health);
  
  if (p2Health <= 0)
  {
  background(0);
  textSize(60);
  text("player1 is the winner !!", 260,467);
  text("Press r to restart the game!", 260, 567);
  if (keyPressed && key == 'r'){
    reset();
  }
  }
  
  if (p1Health <= 0)
  {
  background(0);
  textSize(60);
  text("player2 is the winner !!", 260,467);
  text("Press r to restart the game!", 260, 567);
  if (keyPressed && key == 'r'){
    reset();
  }
  }
  
    if(mouseY < yloc && yloc > 60 && abs(mouseY - yloc) > 20)
    {
      yloc -= 10;
    }else if(mouseY > yloc && yloc < 900 && abs(mouseY - yloc) > 20)
    {
      yloc += 10;
    }
  if(keyPressed)
  {
    if(key == 'w' && yloc1 > 60)
    {
      yloc1 -= 10;
    }else if(key == 's' && yloc1 < 900)
    {
      yloc1 += 10;
    }
 }  
 }

void mouseClicked()
{
  fires += 1;
  Lfirefrms[fires] = frmcnt;
  LfireY[fires] = yloc + 12;
}

void keyPressed(){
 if(key == ' '){
   //using function for airplane2 to shoot
   fires1 += 1;
   Rfirefrms[fires1] = frmcnt;
   RfireY[fires1] = yloc1 + 12;
 }   
}    


void drawplane(int xloc,int yloc)
{
  image(img6,xloc - 30,yloc-50);
}

 void drawplane2 (int xloc1,int yloc1)
 {
   image(img3,xloc1,yloc1-50);
 }


void healthdisp(int xloc, int yloc, int health)
{
  fill(255,0,0);
  rect(xloc - 25, yloc - 40, health * 1.5, 8);
}

int BulletL(int Lfirefrm[], int LfireY[], int frmcnt, int fires)
{
  fill(255,255,0);
  noStroke();
  int dmg = -100;
  for(int i = 1; i <= fires; i ++)
  {
    int printBulletX = (frmcnt - Lfirefrm[i]) * 20 + 120;
    ellipse(printBulletX, LfireY[i], 12, 6);
    if (printBulletX == xloc1)
    {
      dmg = LfireY[i];
    }
  }
  return dmg - 12;
}

int BulletR(int Rfirefrm[], int RfireY[], int frmcnt, int fires1)
{
  fill(255,255,0);
  noStroke();
  int dmg = -100;
  for(int i = 1; i <= fires1; i ++)
  {
    int printBulletX = (Rfirefrm[i] - frmcnt) * 20 + xloc1;
    if (printBulletX > -10 & printBulletX < 1300)
    {
      ellipse(printBulletX, RfireY[i], 12, 6);
    }
    if (printBulletX < xloc + 11 & printBulletX > xloc -11)
    {
      dmg = RfireY[i];
    }
  }
  return dmg - 12;
}


  
