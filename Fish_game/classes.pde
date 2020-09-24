//The fish class used to instance fish into the scene
class fish{
 
 float x_pos;
 float y_pos;
 float diameter;
 float vx = 0;
 float vy = 0;
 float speed = 10;
 int id;
 fish[] others;
 boolean picked_up = false;
 float easing = 0.003;
 float s_ease = 0.003;
 float f_ease = 0.015;
 
 float im_width = 200;
 float im_height = 100;
 float dx;
 float dy;
 float x_speed = random(20,30);
 float y_speed = random(-1,1);
 boolean following = false;
 float targetX;
 float targetY;

  //initializes the fish
 fish(float x, float y, float din, int idin, fish[] oin) {
   x = x_pos;
   y = y_pos;
   diameter = din;
   id = idin;
   others = oin;
   }
 void move(){
   dx = targetX - x_pos;
   x_pos += dx * easing;
  
   dy = targetY - y_pos;
   y_pos += dy * easing;
   
   if (x_pos - diameter > width) {
      x_pos = 0 - diameter;
      y_pos = random(0,height);
    }
   else if (x_pos + diameter < 0) {
      x_pos = width + diameter;
      y_pos = random(0,height);
    }
      
   if (y_pos - diameter > height) {
      y_pos = height + diameter;

    } 
   else if (y_pos + diameter < 0) {
      y_pos = height + diameter/2;
    }
 }
 
  //fish is following
 void follow() {
   easing = f_ease;
   targetX = foo1.x;
   targetY = foo1.y;
   }
   
  //fish idle swim
  void swim(){
   easing = s_ease;
   float dxs = mouseX - x_pos;
   float dys = mouseY - y_pos;
   float distances = sqrt(dxs*dxs + dys*dys);
   float minDists = diameter*3 + diameter/2;
    if (distances < minDists){
        easing = 0.015;
      }
   
   if (dx < 0){
     targetX = -1000;
   }
   else{
     targetX = 2500;
   }
   //targetY = random(500, 700);
  }
  
  //fish is grabbed
  void grabbed(){
   if (mousePressed){
   x_pos = mouseX;
   y_pos = mouseY;
   }
   else{
     picked_up = false;
   }
 }
 
 void display(){
   pushMatrix();
   translate(x_pos, y_pos);
   float angle = atan2(targetX - x_pos, targetY - y_pos);
   rotate(-angle-HALF_PI);
  
   if (dx > 0){
     scale(1.0,-1.0);
     im_width = -im_width;
   }
   else{
     scale(1,1);
     im_height = abs(im_height);
   }
   
   image(fish_pic,0,0, im_width,im_height);
   popMatrix();
 
 }
   
}


class Ball {
  
  float x, y;
  float diameter;
  float vx = 0;
  float vy = -random(0.5,1.5);
  int id;
  Ball[] others;
  float red = random(110,160);
  float green = random(160,210);
  float blue = random(230,255);
  float alpha = random(190,230);
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  } 
  
  void move() {
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
    }
    if (y - diameter > height) {
      y = height + diameter;
      x = random(width);
      vy = random(0.5,1.5);
      diameter = random(15, 60);
    } 
    else if (y + diameter < 0) {
      y = height + diameter/2;
    }
  }
  
  void display() {
     //rotate(PI);
    fill(red,green,blue, alpha);
    ellipse(x, y, diameter, diameter);
  }
  void update(){
    //collide();
    move();
    display();
  }
}

class food {
  
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  food[] others;
  float gravity = 0.03;
  float friction = 0.1;
  boolean grabbed = false;
 
  food(float xin, float yin, float din, int idin, food[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  } 
  
  void collide() {
    if (mousePressed){
      float dxs = mouseX - x;
      float dys = mouseY - y;
      float distances = sqrt(dxs*dxs + dys*dys);
      float minDists = diameter*3 + diameter/2;
      if (distances < minDists){
        grabbed = true;
      }
    }
    
 
      float dxf = f1.x_pos - x;
      float dyf = f1.y_pos - y;
      float distances = sqrt(dxf*dxf + dyf*dyf);
      float minDists = diameter*2.5 + diameter/2;
      if (distances < minDists){
       food_exsists = false;
       f1.following = false;
      }
    //for (int i = id + 1; i < numfood; i++) {
    //  float dx = others[i].x - x;
    //  float dy = others[i].y - y;
    //  float distance = sqrt(dx*dx + dy*dy);
    //  float minDist = others[i].diameter/2 + diameter/2;
    //  if (distance < minDist) { 
    //    float angle = atan2(dy, dx);
    //    float targetX = x + cos(angle) * minDist;
    //    float targetY = y + sin(angle) * minDist;
    //    float ax = (targetX - others[i].x);
    //    float ay = (targetY - others[i].y);
    //    vx -= ax;
    //    vy -= ay;
    //    others[i].vx += ax;
    //    others[i].vy += ay;
    //  }
    //}   
  }
  void grabbed(){
    if ((mousePressed) && (grabbed == true)){
      x = mouseX;
      y = mouseY;
    }
    else{
      grabbed = false;
    }
  }
  
  
  void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction; 
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
  void display() {
    fill(151,101,10);
    ellipse(x, y, diameter, diameter);
  }
}
