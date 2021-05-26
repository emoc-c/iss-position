

class coord{
  float x;
  float y;
  coord(float xin ,float yin){
    x=xin;
    y=yin;
  }
}
coord curs=new coord(0,0);
PShape globe;
PImage earth;
PImage space;
PShape fond;
void settings() {
  System.setProperty("jogl.disable.openglcore", "true");
  size(1000,1000, P3D);
  //fullScreen(P3D);
}
int d=400;
JSONObject json;
void setup() {
  background(255);
  
  earth = loadImage("///home/come/Documents/processing/testplanete/planete2.jpeg");
  globe= createShape(SPHERE, d);
  globe.setTexture(earth);
  globe.setStroke(0);
  
  space = loadImage("///home/come/Documents/processing/testplanete/espace2.jpeg");
  fond= createShape(SPHERE, 1000);
  fond.setTexture(space);
  fond.setStroke(0);
  
  stroke(255,0,0);
  strokeWeight(10);
  issgetcoord();
}

 void issgetcoord(){
  json = loadJSONObject("http://api.open-notify.org/iss-now.json");
  json=json.getJSONObject("iss_position");
  println(json);
  String getlat=json.getString("latitude");
  String getlong=json.getString("longitude");
  println(getlat);
  latdeg= float(getlat);
  longdeg= float(getlong);
  lati=(latdeg*(PI/2.))/90.;
  longi=(longdeg*(PI/2.))/90.;
 
 }

float angley=-PI/2.;
float anglex=PI;
float lmouseX=mouseX;
float lmouseY=mouseY;
int dis=0;
float latdeg= 47.5889664,  longdeg=1.7727488;
float lati=(latdeg*(PI/2.))/90.;
float longi=(longdeg*(PI/2.))/90.;



void draw() {
  if(frameCount%1000==0)
  issgetcoord();
  background(0);
  pushMatrix();
  translate(width/2, height/2, dis);
  rotateY(angley);
  rotateX(anglex);
  shape(fond);
  
   point((d+25.616)*cos(lati)*cos(longi),
        (d+25.616)*cos(lati)*sin(longi),
        -(d+25.616)*sin(lati)
        );
  /*repere
  stroke(255,0,0);
  line(-1000,0,0,1000,0,0);
  stroke(0,255,0);
  line(0,-1000,0,0,1000,0);
  stroke(0,0,255);
  line(0,0,-1000,0,0,1000);*/
  pushMatrix();
  rotateX(-PI/2.);
  rotateZ(PI);
  shape(globe);
  popMatrix();
  popMatrix();
  if(keyPressed)keyPressed();
  if(mousePressed)mousePressed();
  lmouseX=mouseX;
  lmouseY=mouseY;
}
void keyPressed(){
  if(key=='+' && dis<379)dis++;
  else if(key=='-' && dis>-210)dis--;
}
void mousePressed(){
  float dmouseX=mouseX-lmouseX;
  float dmouseY=mouseY-lmouseY;
  angley+=dmouseX/(80.+dis*0.3);
  anglex+=dmouseY/(80.+dis*0.3);
  
}
