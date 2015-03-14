  

//float[][][] cubo = new int[6][4][3];
PGraphics offscreen;

float[][][] cubo = 
  {
    {
      {-1.0, -1.0, -1.0},  {-1.0, 1.0, -1.0},  {1.0, 1.0, -1.0},  {1.0, -1.0, -1.0}
    }, 
    {
      {-1.0, -1.0, -1.0},  {-1.0, -1.0, 1.0},  {1.0, -1.0, 1.0},  {1.0, -1.0, -1.0}
    },
    {
      {-1.0, 1.0, -1.0},  {-1.0, 1.0, 1.0},  {1.0, 1.0, 1.0},  {1.0, 1.0, -1.0}
    },
    {
      {-1.0, -1.0, -1.0},  {-1.0, 1.0, -1.0},  {-1.0, 1.0, 1.0},  {-1.0, -1.0, 1.0}
    },
    {
      {1.0, -1.0, -1.0},  {1.0, 1.0, -1.0},  {1.0, 1.0, 1.0},  {1.0, -1.0, 1.0}
    },
    {
      {-1.0, -1.0, 1.0},  {-1.0, 1.0, 1.0},  {1.0, 1.0, 1.0},  {1.0, -1.0, 1.0}
    }
  };    

float centerx;
float centery;
float zoom = 100;
float perspective = 20;

void setup() {
    size(800,  600,  P3D);
    //offscreen = createGraphics(400,  300,  P2D);
    centerx = width / 2;
    centery = height / 2;
}

Boolean b = true;
//float xangle = 30.0 * 3.1415 / 180.0;
//float yangle = 30.0 * 3.1415 / 180.0;
//float zangle = 30.0 * 3.1415 / 180.0;

float [] angle3d = {0,0,0};
   

/*float [] getProjectedXY(int surface, int vertice)
{   
    
    float x = cubo[surface][vertice][0];
    float y = cubo[surface][vertice][1];   
    float z = cubo[surface][vertice][2];
     
    x = cos(yangle)* x + sin(yangle)*sin(xangle)*y - sin(yangle)*cos(xangle)*z;
    y = 0 + cos(xangle)*y + sin(xangle)*z;
    z= sin(yangle)*x + cos(yangle)*-sin(xangle) *y + cos(yangle)*cos(xangle)*z;
    
    z = 1;
    
    float x2d = x / (z * 1.0);
    float y2d = y / (z * 1.0);
    
    x2d = centerx + x2d * 100;
    y2d = centery + y2d * 100;    
    
    float []ret = {x2d, y2d};
    
    return ret;
}*/

float [] getProjectedXY(int surface, int vertice)
{      
    float []ret = {0, 0};
    
    float x3d = cubo[surface][vertice][0];
    float y3d = cubo[surface][vertice][1];   
    float z3d = cubo[surface][vertice][2];
    
    float x2d = 0;
    float y2d = 0;
    float z2d = 0;
    
    //angle3d[0] = 30 * 3.1415 / 180;
    //angle3d[1] = 30 * 3.1415 / 180;
    
    float xaxis = 0;
    float yaxis = 0;   
    float zaxis = 0;
    
    float [][] matrix = {{0,0,0},{0,0,0},{0,0,0}};
    
    for (int axis = 1; axis < 3; axis++) { // x, y, z        
        if (axis == 1) {
            xaxis = 0;
            yaxis = 1;
        } else {
            if (axis == 2) {
                yaxis = 0;
                zaxis = 1;
            }               
        }
        
        float sn = sin(angle3d[axis] * 3.1415 / 180.0);
        float cs = cos(angle3d[axis] * 3.1415 / 180.0);
    
        float xSin = xaxis * sn;
        float ySin = yaxis * sn;
        float zSin = zaxis * sn;  
        float oneMinusCS = 1.0f - cs;
        float xym = xaxis * yaxis * oneMinusCS;
        float xzm = xaxis * zaxis * oneMinusCS;
        float yzm = yaxis * zaxis * oneMinusCS;
    
        matrix[0][0] = (xaxis * xaxis) * oneMinusCS + cs;
        matrix[0][1] = xym + zSin;
        matrix[0][2] = xzm - ySin;
        matrix[1][0] = xym - zSin;
        matrix[1][1] = (yaxis * yaxis) * oneMinusCS + cs;
        matrix[1][2] = yzm + xSin;
        matrix[2][0] = xzm + ySin;
        matrix[2][1] = yzm - xSin;
        matrix[2][2] = (zaxis * zaxis) * oneMinusCS + cs;
        
        x2d = matrix[0][0] * x3d + matrix[0][1] * y3d + matrix[0][2] * z3d;
        y2d = matrix[1][0] * x3d + matrix[1][1] * y3d + matrix[1][2] * z3d;
        z2d = matrix[2][0] * x3d + matrix[2][1] * y3d + matrix[2][2] * z3d;
        
        x3d = x2d; 
        y3d = y2d; 
        z3d = z2d;        
    }
    
    
    //----
    
    float sn = sin(angle3d[0] * 3.1415 / 180.0);
    float cs = cos(angle3d[0] * 3.1415 / 180.0);
    
    xaxis = 1;
    yaxis = 0;   
    zaxis = 0;

    float xSin = xaxis * sn;
    float ySin = yaxis * sn;
    float zSin = zaxis * sn;  
    float oneMinusCS = 1.0f - cs;
    float xym = xaxis * yaxis * oneMinusCS;
    float xzm = xaxis * zaxis * oneMinusCS;
    float yzm = yaxis * zaxis * oneMinusCS;    

    matrix[0][0] = (xaxis * xaxis) * oneMinusCS + cs;
    matrix[0][1] = xym + zSin;
    matrix[0][2] = xzm - ySin;
    matrix[1][0] = xym - zSin;
    matrix[1][1] = (yaxis * yaxis) * oneMinusCS + cs;
    matrix[1][2] = yzm + xSin;
    matrix[2][0] = xzm + ySin;
    matrix[2][1] = yzm - xSin;
    matrix[2][2] = (zaxis * zaxis) * oneMinusCS + cs;
    
    x2d = matrix[0][0] * x3d + matrix[0][1] * y3d + matrix[0][2] * z3d;
    y2d = matrix[1][0] * x3d + matrix[1][1] * y3d + matrix[1][2] * z3d;
    z2d = matrix[2][0] * x3d + matrix[2][1] * y3d + matrix[2][2] * z3d;
    
    
    //----
    
    x2d = centerx + x2d * (zoom + z2d * perspective);
    y2d = centery + y2d * (zoom+ z2d * perspective);    
   
    ret[0] = x2d;
    ret[1] = y2d;
    
    return ret;
}
       

void drawSurface(int s) 
{
    float []point2D = {0.0, 0.0};

    beginShape();         
    for (int v=0; v < 4; v++) {
        point2D = getProjectedXY(s, v);                
        vertex(point2D[0], point2D[1]);                  
    }
    // repete o primeiro vertice pra fechar o cubo
    point2D = getProjectedXY(s, 0);                
    vertex(point2D[0], point2D[1]);
    endShape();
}

float step = 1;

void draw() {
    background(0,0,100);  
    strokeWeight(1);
    stroke(0,0,150);
    for (int y=0; y < 20; y++) {
        line(0, height / 20 * y, width, height / 20 * y);
    }
    for (int x=0; x < 20; x++) {
        line(width / 20 * x, 0, width / 20 * x, height);
    }    
   // beginDraw();
  
    //offscreen.background(110,  120,  200);
   fill(150,0,0,100);
    //noFill(); 
    strokeWeight(1);
    stroke(255,0,0);
  
    for (int s=0; s < 6; s++) {
        drawSurface(s);
        
    }  
    b = false;
    //angle3d[0] += step;
    //angle3d[0] = 30;
    //angle3d[1] += step;
    //angle3d[2] += step;
   // endDraw(); 
}

void keyPressed() {
    println(key);
    switch(key) {
        case 'w':
            if (zoom < 1000) {
                zoom += 1;
            } 
        break;        
        case 'q':
            if (zoom > 10) {
                zoom -= 1;
            } 
        break;
        
        case '-':
            if (perspective > 0) {
                perspective -= 1;
            } 
        break;
        case '=':
            if (perspective < 30) {
                perspective += 1;
            } 
        break;    
        
        case 'z':
            angle3d[0] += 1;
            angle3d[0] = angle3d[0] % 360;                
        break;
        case 'a':
            angle3d[0] -= 1;
            angle3d[0] = angle3d[0] % 360; 
        break;
        
         case 'x':
            angle3d[1] += 1;
            angle3d[1] = angle3d[1] % 360;                
        break;
        case 's':
            angle3d[1] -= 1;
            angle3d[1] = angle3d[1] % 360; 
        break;
        
         case 'c':
            angle3d[2] += 1;
            angle3d[2] = angle3d[2] % 360;                
        break;
        case 'd':
            angle3d[2] -= 1;
            angle3d[2] = angle3d[2] % 360; 
        break;
    }
}

