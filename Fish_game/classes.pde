//The fish class used to instance fish into the scene
class fish {

  float x_pos;
  float y_pos;
  float diameter;
  float vx = 0;
  float vy = 0;
  float speed = 10;
  int id;
  food[] others;
  fish[] neighbors;
  
  boolean picked_up = false;
  float s_ease = random(0.0005,0.01);
  float easing = s_ease;
  float f_ease = random(0.005,0.02);

  float im_width = random(170,200);
  float im_height = random(70,100);
  float dx;
  float dy;
  float x_speed = random(20, 30);
  float y_speed = random(-1, 1);
  boolean following = false;
  float targetX;
  float targetY;
  PImage follow;
  PImage swim;
  float sizemult = 1;
 
  food closest_food;
  float closest_dist;

  //initializes the fish
  fish(float x, float y, float din, int idin, food[] oin, PImage F, PImage S, fish[] fi) {
    x_pos = x;
    y_pos = y;
    diameter = din;
    id = idin;
    others = oin;
    follow = F;
    swim = S;
    neighbors = fi;
    
    }
  void collide(){
        if (mousePressed) {
      float dxs = mouseX - x_pos;
      float dys = mouseY - y_pos;
      float distances = sqrt(dxs*dxs + dys*dys);
      float minDists = 1 + diameter/10;
      if (distances < minDists) {
        picked_up = true;
        }
      }
        for (int i = id + 1; i < neighbors.length; i++) {
          if (neighbors[i] != null){
      float dx = neighbors[i].x_pos - x_pos;
      float dy = neighbors[i].y_pos - y_pos;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = neighbors[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x_pos + cos(angle) * minDist;
        float targetY = y_pos + sin(angle) * minDist;
        float ax = (targetX - neighbors[i].x_pos);
        float ay = (targetY - neighbors[i].y_pos);
        vx -= ax;
        vy -= ay;
        neighbors[i].x_pos += ax;
        neighbors[i].y_pos += ay;
      }
     }
    }
    if (fish_food != null){
    for (int i = 0; i < fish_food.length; i++) {
      if (others[i] != null){
      float dx = others[i].x - x_pos;
      float dy = others[i].y - y_pos;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        following = true;
       }
      }
     }
    }
  }
  void move() {
    dx = targetX - x_pos;
    x_pos += dx * easing;

    dy = targetY - y_pos;
    y_pos += dy * easing;

    if (x_pos - diameter > width) {
      x_pos = 0 - diameter;
      y_pos = random(0, height);
     } 
      
    else if (x_pos + diameter < 0) {
      x_pos = width + diameter;
      y_pos = random(0, height);
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
    closest_food = null;
    closest_dist = 9999;
    
    float distance;
    for (int i = 0; i < fish_food.length; i++) {
      if (others[i] != null){
        
        float dx = others[i].x - x_pos;
        float dy = others[i].y - y_pos;
        distance = sqrt(dx*dx + dy*dy);
        float minDist = others[i].diameter/2 + diameter/2.5;
         
        if (distance < minDist){
          others[i] = null;
          sizemult += 0.05;
          if (sizemult >=  2.5){
            sizemult = 1;
            for (int ii = 0; ii < fishes.length; ii++) {
                  if (fishes[ii] == null){fishes[ii] = fishes[ii] = new fish(x_pos,y_pos,155,ii,fish_food,mouth_fish,fish_pic, fishes);break;}
                  }
          }
          //diameter *= sizemult;
          for (int f = 0; f < numfish; f++) {
            if (fishes[f] != null){
            fishes[f].following = false; food_exsists = false;
            }
           }
        }
        
        else if (i==0){
        closest_food = others[i];closest_dist = distance;
        }
        
        else if (distance < closest_dist) {
        closest_food = others[i];
        closest_dist = distance;
        }
       }
       
      else{
        
      }
      
     }
       
       
        if (closest_food !=null){
        easing = f_ease;
        targetX = closest_food.x;
        targetY = closest_food.y;
       }
    }

  //fish idle swim
  void swim() {
    easing = s_ease;
    float dxs = mouseX - x_pos;
    float dys = mouseY - y_pos;
    float distances = sqrt(dxs*dxs + dys*dys);
    float minDists = 1 + diameter/2;
    if (distances < minDists) {
      easing = f_ease * 2;
    }

    if (dx < 0) {
      targetX = -1000;
    }
    
    else {
      targetX = 2500;
    }
    
    //targetY = random(500, 700);
  }

  //fish is grabbed
  void grabbed() {
    if (mousePressed) {
      targetX = mouseX;
      targetY = mouseY;
      x_pos = mouseX;
      y_pos = mouseY;
    } 
    
    else {
      picked_up = false;
    }
  }

  void display() {
    pushMatrix();
    
    translate(x_pos, y_pos);
    float angle = atan2(targetX - x_pos, targetY - y_pos);
    rotate(-angle-HALF_PI);

    if (dx > 0) {
      scale(-1.0, -1.0);
      im_width = -im_width;
    } 
    
    else {
      scale(-1, 1);
      im_height = abs(im_height);
    }
    
    if (following){
      image(follow, 0, 0, im_width*sizemult, im_height*sizemult);
    }
    
    else{
    image(swim, 0, 0, im_width*sizemult, im_height*sizemult);
    }
    popMatrix();
  }
}


class Ball {

  float x, y;
  float diameter;
  float vx = 0;
  float vy = -random(0.5, 1.5);
  int id;
  Ball[] others;
  float red = random(110, 160);
  float green = random(160, 210);
  float blue = random(230, 255);
  float alpha = random(150, 215);

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
    } else if (x - diameter/2 < 0) {
      x = diameter/2;
    }
    if (y - diameter > height) {
      y = height + diameter;
      x = random(width);
      vy = random(0.5, 1.5);
      diameter = random(15, 60);
    } else if (y + diameter < 0) {
      y = height + diameter/2;
    }
  }

  void display() {
    //rotate(PI);
    noStroke();
    fill(red, green, blue, alpha);
    ellipse(x, y, diameter, diameter);
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
  color c;

  food(float xin, float yin, float din, int idin, food[] oin, color col) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
    c = col;
  } 

  void collide() {
    if (mousePressed) {
      float dxs = mouseX - x;
      float dys = mouseY - y;
      float distances = sqrt(dxs*dxs + dys*dys);
      float minDists = 1 + diameter/2;
      if (distances < minDists) {
        grabbed = true;
      }
    }
      }
  void grabbed() {
    if ((mousePressed) && (grabbed == true)) {
      x = mouseX;
      y = mouseY;
    } 
    
    else {
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
    food_exsists = true;
    //fill(220, 170, 120);
    fill(c);
    stroke(2);
    ellipse(x, y, diameter, diameter);
  }
}
