class Bullet
{
  PVector pos;
  PVector dir;
  
  float size;
  float speed;
  
  Bullet(PVector _start, PVector _target)
  {
    pos = new PVector(_start.x, _start.y);
    dir = new PVector(_target.x, _target.y);
    
    dir = PVector.sub(_target, _start);
    
    size = 10;
    speed = 20;
    
    dir.normalize();
    dir.mult(5);
  }
  
  void display()
  {
    fill(h, 255, 255);
    rect(pos.x, pos.y, size, size);
  }
  
  void move()
  {
   pos.add(dir); 
  }
  
  void checkBoundaries()
  {
    if(pos.x < 10 || pos.x > width - 10)
    {
     dir.x *= -1;
    }
    
    if(pos.y < 10 || pos.y > height - 10)
    {
     dir.y *= -1; 
    }
  }
  
  void update()
  {
    display();
    move();
    checkBoundaries();
  }
}