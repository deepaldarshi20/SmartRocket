class DNA
{
  PVector genes[];
  float mutation=0.01;

  DNA(int life)
  {
    genes=new PVector[life];
    for(int i=0;i<life;i++)
    {
      genes[i]=PVector.random2D();
    }
  }
  
  DNA crossover(Rockets partner)
  {
    int f=partner.maxFuel;
    DNA newDNA=new DNA(f);
    //ways of crossOver
    switch (floor(random(3))){
      
    case 0:
    for(int i=0;i<f;i++)
    {
      newDNA.genes[i]=i%2==0?genes[i]:partner.thruster.genes[i];
    }
    break;
    
    case 1:
    int mid=floor(random(f));
    for(int i=0;i<f;i++)
    {
      newDNA.genes[i]=i<mid?genes[i]:partner.thruster.genes[i];
    }
    break;
    
    case 2:
    for(int i=0;i<f;i++)
    {
      newDNA.genes[i]=random(i)%2==0?genes[i]:partner.thruster.genes[i];
    }
    break;
    }
    
    return newDNA;
  }
  
  
  
  void mutate()
  {
    for(int i=0;i<genes.length;i++)
    {
      if(random(1)<mutation){
      genes[i]=PVector.random2D();
      }
    }
  }
  
  
}
