class Rockets 
{
  PImage img= loadImage("Rocket.png");
  PImage exp= loadImage("Explosion.png");
  PVector pos;
  PVector acc;
  PVector vel;
  float maxAcc=0.2;
  float maxVel=4;
  float fitness=0;
  float fitFact=1;
  int time=0;
  int fuel=400;
  int maxFuel=fuel;
  boolean noFuel=false;
  boolean reached=false;
  boolean crashed=false;
  DNA thruster;
  
  Rockets()
  {
    pos=new PVector(width/2,height*.9);
    vel=new PVector();
    acc=new PVector();
    thruster=new DNA(maxFuel);
  }
  void show()
  {
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(vel.heading()+PI/2);
    //on going
    if(!crashed&&!reached)
    image(img,0,0,25,30);
    //on crash
    else if(crashed && time<30)
    image(exp,0,0,30-time++,30-time++);
    //after crash
    if(crashed)
    {
      fill(0,80);
      noStroke();
      rotate(-(vel.heading()+PI/2));
      ellipse(0,0,15,15);
    }
    if(reached)
    {
      rotate(-(vel.heading()+PI/2));
      textSize(10);
      text("0_0 Hello",0,0);
    }

    popMatrix();  
  }
  
  void applyForce(PVector force)
  {
    acc.add(force.setMag(maxAcc));
  }
  
  void update()
  {
    if(!noFuel&&!reached&&!crashed)
    {
      applyForce(thruster.genes[maxFuel-fuel]);
      vel.add(acc).limit(maxVel);
      pos.add(vel);
      acc.mult(0);
      obstacle();
      targReached();
      edgeCollide();
      
      fuel--;
      if(fuel<=0)
      {
        noFuel=true;
      }
    }
  }
  
  void fitness(float x,float y)
  {
    float d=dist(x,y,pos.x,pos.y);
    fitness=((fitFact+(1+(fuel/maxFuel)))*map(d,width/2,0,0,width));
  }
  
  
  void obstacle()
  {
    if((pos.x>ob.x-wid&&pos.x<=ob.x+wid)&&(pos.y<=ob.y+10&&pos.y>=ob.y-10)&&!crashed)
      {
        crashed=true;
        pos.sub(vel);
        fitFact=1/100;
        //fitFact=dist(pos.x,pos.y,ob.x,ob.y)/100;        
      }
  }
  
  
  void targReached()
  {
    if(dist(pos.x,pos.y,target.x,target.y)<=35&&!reached)
      {
        reached=true;
        pos.x=target.x;
        pos.y=target.y;
        fitFact=10;
      }
      
  }
  
  void edgeCollide()
  {
    if(pos.x>width||pos.x<0||pos.y<0||pos.y>height&&!crashed)
      {
        crashed=true;
        fitFact=1/50;
      }
      
  }
  
}
