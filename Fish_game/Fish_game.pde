  
int balls_back = 50;
int balls_front = 60;
int player_count = 0;

PImage fish_pic;

PImage open;
 
PImage closed;

boolean hand_open = true;

int numfood = 10;

boolean food_exsists = false;

food foo1;

food[] foods = new food[numfood];
Ball[] balls = new Ball[balls_back];
Ball[] balls2 = new Ball[balls_front];
fish[] fishs = new fish[50];
fish f1;
//fish_1 = loadImage("1_3.png");

//connectToPubNub();
//ArrayList<bubble> bubbles = new ArrayList<bubble>();

//bubble b1;

void setup(){
  imageMode(CENTER);
  fish_pic = loadImage("download.png");
  open = loadImage("open.png");
  closed = loadImage("closed.png");
  size(1920,1080);
  for (int i = 0; i < balls_back; i++) {
    balls[i] = new Ball(random(width), random(height), random(5, 50), i, balls);
  }
  for (int i = 0; i < balls_front; i++) {
    balls2[i] = new Ball(random(width), random(height), random(15, 70), i, balls2);
  }
  noStroke();
  fill(255, 204);
  f1 = new fish(random(0,width),random(0,height),100,1,fishs);
}



void draw(){
  background(53,87,174);
  if (food_exsists){
    f1.following = true;
  }
  if (mousePressed){
    hand_open = false;
    cursor(MOVE);
  }
  else{
    hand_open = true;
    cursor(HAND);
  }
  for (Ball ball : balls) {
    ball.move();
    ball.display();
  }
  if (f1.following){
    f1.follow();
  }
  else{
    f1.swim();
  }
  f1.move();
  f1.display();
  for (Ball ball : balls2) {
    ball.move();
    ball.display();
  }
  if ((foo1 != null) && (food_exsists)){
    foo1.move();
    foo1.collide();
    foo1.grabbed();
    foo1.display();
  }
  
  
  
}

void keyPressed(){
  food_exsists = true;
  //for (int i =
  //add food to list of food for fish to draw from ****
  //add multiple fish
  //add multiple players*****
  foo1 = new food(mouseX, mouseY, 40, 0, foods);
}
