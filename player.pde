class Player
{
  float x = 100;
  float y = 100;

  float size = 25;

  boolean isAlive = true;

  void display()
  {
    fill(255, 0, 255);
    strokeWeight(1.5);
    stroke(h, 255, 255);
    rect(x, y, size, size);
    
    noStroke();
    
    fill(h, 255, 255, 50);
    rect(x, y, size, size);
  }

  void checkBoundaries()
  {
    if (x < size/2 + 10)
    { 
      x = size/2 + 10;
    }

    if (x > width - size/2 - 10) 
    { 
      x = width - size/2 - 10;
    }

    if (y < size/2 + 10)
    { 
      y = size/2 + 10;
    }

    if (y > height - size/2 - 10)
    { 
      y = height - size/2 - 10;
    }
  }

  void update()
  {
    display();
    checkBoundaries();
  }
}