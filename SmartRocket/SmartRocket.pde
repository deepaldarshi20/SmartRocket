Rockets Roc[];
int population=50;
PVector target;
PVector ob;
PVector stars[]=new PVector[500];
PImage planet;
int v=4;
int wid;
int gen=1;
int curFuel=0;

void setup()
{
  size(800,800);
  //fullScreen();
  noCursor();
  wid=width/4;
  background(0);
  
  //postion of target & ostacle
  target=new PVector(width/2,height/10);
  ob=new PVector(width/2,height/2);
  
  
  Roc=new Rockets[population];
  
  //populating first gen
  for(int i=0;i<population;i++)
  {
    Roc[i]=new Rockets();
  }
  
  //making stars
  for(int i=0;i<250;i++)
  { 
    stars[i]=new PVector(random(width),random(height));
  }
  
  
  planet=loadImage("Planet.png");
}


void draw()
{    
  background(0);
 
  for(int i=0;i<250;i++)
  {
    fill(255);
    ellipse(stars[i].x,stars[i].y,2,2);
  }
  
  fill(255,150);
  textSize(50);
  text(gen,100,50);//shows generation no on the top left
  rectMode(CENTER);
  rect(ob.x,ob.y,2*wid,20);
  showPlanet();
  //debug
  //int fite=0;
  //int lfit=0;
  curFuel=0;
  moveObstacle();
  for(int i=0;i<population;i++)
  {    
    Roc[i].show();
    Roc[i].update();
    
    if(!Roc[i].reached&&!Roc[i].crashed)
    curFuel+=Roc[i].fuel;
    
    //debug
    //Roc[i].fitness(target.x,target.y);
    //fite=Roc[fite].fitness<Roc[i].fitness?i:fite;
    //lfit=Roc[lfit].fitness>Roc[i].fitness?i:lfit;
    
    
  }
  println(curFuel);
  //endOfGeneration
  NewPop();
  
  //debug
  //fill(255,0,0);
  //ellipse(Roc[fite].pos.x,Roc[fite].pos.y,10,10);
  //fill(255,255,0);
  //ellipse(Roc[lfit].pos.x,Roc[lfit].pos.y,10,10);      
}



void NewPop()
{
  if(curFuel==0)
      {
        gen++;
        ArrayList <Rockets> matingPool=new ArrayList<Rockets>();
        float maxFit=0;
        for(int j=0;j<population;j++)
        {
          Roc[j].fitness(target.x,target.y);
          if(maxFit<Roc[j].fitness)
          {
            maxFit=Roc[j].fitness;
          }
          
        }
        
        for(int j=0;j<population;j++)
        {
          int fit=(int)(Roc[j].fitness/maxFit)*100;
          for(int e=0;e<fit;e++)
          {
            matingPool.add(Roc[j]);
          }
        }
        println(maxFit);
        for(int j=0;j<population;j++)
        {
          Rockets r=new Rockets();
          Rockets a=matingPool.get((int)random(matingPool.size()));
          Rockets b=matingPool.get((int)random(matingPool.size()));
          r.thruster=a.thruster.crossover(b);
          r.thruster.mutate();
          Roc[j]=r;
        }
      }
}
void moveObstacle()
{
   ob.x=(ob.x+v);
 if(ob.x+wid>=width)
    v=-v;
 if(ob.x-wid<=0)
    v=-v;
  
}
void mouseObstacle()
{
  ob= new PVector(mouseX,mouseY);
}
void showPlanet()
{
  pushMatrix();
  translate(target.x,target.y);
  rotate(frameCount*.02);
  imageMode(CENTER);
  image(planet,0,0,80,80);
  popMatrix();
  
}
