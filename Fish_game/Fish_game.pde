  
int balls_back = 50;
int balls_front = 60;
int player_count = 0;

PImage fish_pic;
PImage mouth_fish;

PImage open;
PImage closed;

color c = color(random(0,255),random(0,255),random(0,150));

boolean hand_open = true;

int numfood = 200;

int numfish = 10;

int food_added = 0;

int fish_fed = 0;


boolean food_exsists = false;

String instructions_1 = "Press any key to feed fish";
String instructions_2 = "Click and drag mouse to move things around";

instruct t1;
instruct t2;

food[] fish_food = new food[numfood];
Ball[] balls = new Ball[balls_back];
Ball[] balls2 = new Ball[balls_front];
fish[] fishes = new fish[200];
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
  
  t1 = new instruct(width/2-300,0,instructions_1,color(0,0,0,200));
  t2 = new instruct(width/2-300,-100,instructions_2,color(0,0,0,200));
  
 // noStroke();
 // fill(255, 204);
  
  for (int i = 0; i < 10; i++) {
    fishes[i] = new fish(random(0,width),random(0,height),155,i,fish_food,mouth_fish,fish_pic, fishes);
  }
 
  //fishes[0] = new fish(random(0,width),random(0,height),100,1,fish_food,mouth_fish,fish_pic);
}



void draw(){
  background(150,160,210);
  for(int i =0;i<allReceivedMessages.size();i++)
  {
    handleMessageData(allReceivedMessages.get(i));
    
  }
  
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
  
  t1.update();
  t2.update();
  
  for (int i = 0; i < fishes.length; i++) {
    if (fishes[i] != null){
       fishes[i].collide();
       //if (food_exsists){
       //  fishes[i].following = true;
       //  }
       if (fishes[i].picked_up){
         fishes[i].grabbed();
       }
       else if (fishes[i].following){
          //fishes[i].follow();
          //fishes[i].follow();
          }
       else{
       // fishes[i].swim();
        
        fishes[i].swim();
          }
  
  
      //fishes[i].move();
      //fishes[i].display();
      fishes[i].follow();
      fishes[i].move();
      fishes[i].display();
    }
   }
 
  
  
  
  
 
  for (Ball ball : balls2) {
    ball.move();
    ball.display();
  }
  //int numfish = 10;

  //int food_added = 0;
  
  //int fish_fed = 0;

  //int food_produced = 0;
  textSize(35);
  fill(0,0,0,150);
  text("Fish: " + str(numfish), 50, 100);
  text("Food Produced: " + str(food_added),250,100);
  text("Fish Fed: " + str(fish_fed),600,100);

  
}

void keyPressed(){
  sendMessage();
  //for (int i = 0; i < fish_food.length; i++) {
  //  if (fish_food[i] == null){fish_food[i] = new food(mouseX, mouseY, 40, i, fish_food);break;}
  //}
}

void keyReleased(){
  sendMessage();
}

void mousePressed(){
  
}
