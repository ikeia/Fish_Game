  
int balls_back = 50;
int balls_front = 60;
int player_count = 0;

PImage fish_pic;
PImage mouth_fish;

PImage open;
PImage closed;

boolean hand_open = true;

int numfood = 0;

boolean food_exsists = false;

food foo1;

food[] fish_food;// = new food[numfood];
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
  fish_pic = loadImage("fish1.png");
  mouth_fish = loadImage("mouth fish.png");
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
  f1 = new fish(random(0,width),random(0,height),100,1,fish_food,mouth_fish);
}



void draw(){
  //background(53,87,174, 0.1);
  background(150,160,210);
  if (fish_food.length == 0){
    food_exsists = false;
  }
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
  //if ((foo1 != null) && (food_exsists)){
  //  foo1.move();
  //  foo1.collide();
  //  foo1.grabbed();
  //  foo1.display();
  //}
  for (int i = 0; i < fish_food.length; i++) {
    if (fish_food[i] != null){
      fish_food[i].move();
      fish_food[i].collide();
      fish_food[i].grabbed();
      fish_food[i].display();
    }
  }
  
  
}

void keyPressed(){
  //food_exsists = true;
  numfood = fish_food.length;
  expand(fish_food);
  append(fish_food, new food(mouseX, mouseY, 40, 0, fish_food));
  print(fish_food.length);
  for (int i = fish_food.length - 1; i < fish_food.length + 1; i++) {
    if (i == fish_food.length + 1){break;}
    //fish_food[i] = new food(mouseX, mouseY, 40, i, fish_food);
    append(fish_food, new food(mouseX, mouseY, 40, i, fish_food));
  }
  //for (int i =
  //add food to list of food for fish to draw from ****
  //add multiple fish
  //add multiple players*****
  //foo1 = new food(mouseX, mouseY, 40, 0, fish_food);
}
