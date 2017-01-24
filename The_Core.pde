PVector core;
PVector playerPos;

boolean upPressed, downPressed, leftPressed, rightPressed;

int time;
boolean counting = true;

Player player;

ArrayList<Bullet> b = new ArrayList<Bullet>();

float targetX;
float targetY;

float targetSize;

int interval = 1000;
int slowMoTime = 0;
int maxSlowMo = 1000;

float h = 0;

int score = 100;

void setup()
{
  fullScreen(P2D);
  rectMode(CENTER);
  noStroke();
  noCursor();
  colorMode(HSB);
  textAlign(CENTER);

  time = millis();
  slowMoTime = millis();

  targetX = random(10 + targetSize/2, width - 10 - targetSize/2);
  targetY = random(10 + targetSize/2, height - 10 - targetSize/2);

  core = new PVector(width/2, height/2);
  player = new Player();

  targetSize = player.size;

  background(0);
}

void draw()
{ 
  //if((millis() - slowMoTime) > maxSlowMo) slowMoTime = millis() - maxSlowMo;
  
  h += 0.5;

  if (h > 255)
  {
    h = 0;
  }

  if (player.isAlive)
  {
    player.x = mouseX;
    player.y = mouseY;
  }

  playerPos = new PVector(player.x, player.y);

  fill(h, 255, 255, 10);
  rect(width/2, height/2, width, height);

  fill(0, 100);
  rect(width/2, height/2, width - 20, height - 20);

  noFill();
  stroke(h, 255, 255);
  ellipse(targetX, targetY, targetSize, targetSize);
  noStroke();

  fill(255, 5);
  stroke(h, 255, 255);
  //ellipse(core.x, core.y, 60, 60);

  fill(h, 255, 255);
  //ellipse(core.x, core.y, 25, 25);

  noStroke();

  textSize(108);
  text(score + "%", core.x, core.y + 40);

  player.update();

  float d = dist(player.x, player.y, targetX, targetY);

  if (d < targetSize)
  {
    targetX = random(10 + targetSize/2, width - 10 - targetSize/2);
    targetY = random(10 + targetSize/2, height - 10 - targetSize/2);

    score -= 4;
  }

  if (dist(targetX, targetY, core.x, core.y) < 200)
  {
    targetX = random(10 + targetSize/2, width - 10 - targetSize/2);
    targetY = random(10 + targetSize/2, height - 10 - targetSize/2);
  }

  if (time < millis() && counting)
  { 
    b.add(new Bullet(core, playerPos));

    time += interval;
  }

  for (int i = 0; i < b.size(); i++)
  {
    b.get(i).update();

    if ((b.get(i).pos.x - b.get(i).size/2 >= player.x - player.size/2 && b.get(i).pos.x - b.get(i).size/2 <= player.x + player.size/2 && b.get(i).pos.y - b.get(i).size/2 >= player.y - player.size/2 && b.get(i).pos.y - b.get(i).size/2 <= player.y + player.size/2) || (b.get(i).pos.x + b.get(i).size/2 >= player.x - player.size/2 && b.get(i).pos.x + b.get(i).size/2 <= player.x + player.size/2 && b.get(i).pos.y - b.get(i).size/2 >= player.y - player.size/2 && b.get(i).pos.y - b.get(i).size/2 <= player.y + player.size/2) || (b.get(i).pos.x - b.get(i).size/2 >= player.x - player.size/2 && b.get(i).pos.x - b.get(i).size/2 <= player.x + player.size/2 && b.get(i).pos.y + b.get(i).size/2 >= player.y - player.size/2 && b.get(i).pos.y + b.get(i).size/2 <= player.y + player.size/2) || (b.get(i).pos.x + b.get(i).size/2 >= player.x - player.size/2 && b.get(i).pos.x + b.get(i).size/2 <= player.x + player.size/2 && b.get(i).pos.y + b.get(i).size/2 >= player.y - player.size/2 && b.get(i).pos.y + b.get(i).size/2 <= player.y + player.size/2))
    {
      player.isAlive = false;
      counting = false;
    }

    b.get(i).dir.normalize();
    b.get(i).speed = 10;
    b.get(i).dir.mult(b.get(i).speed);

    interval = 1000;

    if (keyPressed)
    { 
      if (key == ' ')
      {
        if (slowMoTime < millis())
        { 
          slowMoTime += 1000/frameRate;

          b.get(i).speed = 20/9;

          b.get(i).dir.normalize();
          b.get(i).dir.mult(b.get(i).speed);

          interval = 4500;
        }
      }
    }
  }
  
  //text(millis() - slowMoTime, width/2, height - 200);
}

void reset()
{
  player.isAlive = true;
  counting = true;
  time = millis();

  player.x = 100;
  player.y = 100;

  score = 100;
  targetX = random(10 + targetSize/2, width - 10 - targetSize/2);
  targetY = random(10 + targetSize/2, height - 10 - targetSize/2);

  b.clear();
}

void mousePressed()
{
  reset();
}