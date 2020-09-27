  
int balls_back = 50;
int balls_front = 60;
int player_count = 0;

PImage fish_pic;
PImage mouth_fish;

PImage open;
PImage closed;

boolean hand_open = true;

int numfood = 100;

int numfish = 10;

boolean food_exsists = false;

food foo1;

food[] fish_food = new food[numfood];
Ball[] balls = new Ball[balls_back];
Ball[] balls2 = new Ball[balls_front];
fish[] fishes = new fish[numfish];
fish f1;
//fish_1 = loadImage("1_3.png");

//ArrayList<bubble> bubbles = new ArrayList<bubble>();

//bubble b1;

void setup(){
  connectToPubNub();
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
  
 // noStroke();
 // fill(255, 204);
  
  for (int i = 0; i < numfish; i++) {
    fishes[i] = new fish(random(0,width),random(0,height),random(50,200),i,fish_food,mouth_fish,fish_pic, fishes);
  }
 
  //fishes[0] = new fish(random(0,width),random(0,height),100,1,fish_food,mouth_fish,fish_pic);
}



void draw(){
  //background(53,87,174, 0.1);
  background(150,160,210);
  //if (fish_food.length == 0){
  //  food_exsists = false;
  //}
  
  if (fish_food != null){
  for (int i = 0; i < fish_food.length; i++) {
    if (fish_food[i] != null){
      fish_food[i].move();
      fish_food[i].collide();
      fish_food[i].grabbed();
      fish_food[i].display();
    }
   }
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
  
  for (int i = 0; i < fishes.length; i++) {
    if (fishes[i] != null){
       fishes[i].collide();
       if (food_exsists){
         fishes[i].following = true;
         }
       if (fishes[i].following){
          //fishes[i].follow();
          fishes[i].follow();
          }
       else{
       // fishes[i].swim();
        
        fishes[i].swim();
          }
  
  
      //fishes[i].move();
      //fishes[i].display();
      
      fishes[i].move();
      fishes[i].display();
    }
   }
 
  
  
  
  
 
  for (Ball ball : balls2) {
    ball.move();
    ball.display();
  }
  
  
}

void keyReleased(){
  for (int i = 0; i < fish_food.length; i++) {
    if (fish_food[i] == null){fish_food[i] = new food(mouseX, mouseY, 40, i, fish_food);break;}
  }
}
