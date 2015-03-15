//import java.util.Iterator;
//import java.util.ListIterator;

//float[][][] cubo = new int[6][4][3];
PGraphics offscreen;
float perspective = 0.0;//20;



class PMSurface {
    float[][]vertices3D = { 
        {
            -1.0, -1.0, -1.0
        }
        , {
            -1.0, 1.0, -1.0
        }
        , {
            1.0, 1.0, -1.0
        }
        , {
            1.0, -1.0, -1.0
        }
    };
    float[][]vertices2D = { 
        {
            -1.0, -1.0
        }
        , {
            -1.0, 1.0
        }
        , {
            1.0, 1.0
        }
        , {
            1.0, -1.0
        }
    };
    /*float[]Normal = {
        -1.0, -1.0, -1.0
    };*/
    float visibility;
}  


class PMObject3D { 
    //PMSurface [] surfaces;
    //List<PMSurface> surfaces = new ArrayList<PMSurface>();
    ArrayList<PMSurface> surfaces;

    PMObject3D () {  
        float[][][] cubo = 
        {
            { // face frontal
                {
                    -1.0, -1.0, 1.0
                }
                , {
                    -1.0, 1.0, 1.0
                }
                , {
                    1.0, 1.0, 1.0
                }
                , {
                    1.0, -1.0, 1.0
                }
            }
            , 
            { // face topo
                {
                    -1.0, -1.0, -1.0
                }
                , {
                    1.0, -1.0, -1.0
                }
                , {
                    1.0, -1.0, 1.0
                }
                , {
                    -1.0, -1.0, 1.0                    
                }
            }
            , 
            {    // face de baixo
                {
                    -1.0, 1.0, -1.0
                }
                , {
                    -1.0, 1.0, 1.0
                }
                , {
                    1.0, 1.0, 1.0
                }
                , {
                    1.0, 1.0, -1.0
                }
            }
            , 
            { // face esquerda
                {
                    -1.0, -1.0, -1.0
                }
                , {
                    -1.0, 1.0, -1.0
                }
                , {
                    -1.0, 1.0, 1.0
                }
                , {
                    -1.0, -1.0, 1.0
                }
            }
            , 
            {
                { // face direita
                    1.0, -1.0, -1.0
                }
                , {
                   1.0, -1.0, 1.0 
                }
                , {
                    1.0, 1.0, 1.0
                }
                , {                    
                    1.0, 1.0, -1.0
                }
            }
            , 
            {
                { // face do fundo
                    -1.0, -1.0, -1.0
                }
                , {
                    1.0, -1.0, -1.0
                }
                , {
                    1.0, 1.0, -1.0
                }
                , {
                    -1.0, 1.0, -1.0                    
                }
            }
        };

        surfaces = new ArrayList<PMSurface>();
        for (int s=0; s < cubo.length; s++) {
            PMSurface surface = new PMSurface();
            for (int v=0; v < 4; v++) {
                for (int p=0; p < 3; p++) {
                    surface.vertices3D[v][p] = cubo[s][v][p];
                }
            }
            surfaces.add(surface);
        }
    } // Constructor

    

    //private void rotateSurface (int surfaceId, float[]angle3d)
    public void rotate3D (float[] angle3d)
    {    
        float ax=0;
        float ay=0;
        float az=0;
        float bx=0;
        float by=0;
        float bz=0;
        
        for (int s=0; s < surfaces.size(); s++) {            
            PMSurface surface = surfaces.get(s);
            for (int vertice=0; vertice < 4; vertice++) {                
                float x3d = surface.vertices3D[vertice][0];
                float y3d = surface.vertices3D[vertice][1];   
                float z3d = surface.vertices3D[vertice][2];
    
                float x2d = 0;
                float y2d = 0;
                float z2d = 0;
    
                float xaxis = 0;
                float yaxis = 0;   
                float zaxis = 0;
    
                float [][] matrix = {
                    {
                        0, 0, 0
                    }
                    , {
                        0, 0, 0
                    }
                    , {
                        0, 0, 0
                    }
                };    
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
                    
                    
                    //x2d = x2d * (0.05 * z2d + 0.95);
                    //y2d = y2d * (0.05 * z2d + 0.95);
                    x2d = x2d * (perspective * z2d + (1-perspective));
                    y2d = y2d * (perspective * z2d + (1-perspective));
    
                    x3d = x2d; 
                    y3d = y2d; 
                    z3d = z2d;
                }
                
                if (vertice == 0) {
                    ax = x3d; ay = y3d; az = z3d;
                    bx = x3d; by = y3d; bz = z3d;
                }                 
                if (vertice == 1) {
                    ax = x3d - ax; ay = y3d - ay; az = z3d - az;                    
                }
                if (vertice == 3) {
                    bx = x3d - bx; by = y3d - by; bz = z3d - bz;                    
                }
            
                
    
                // No eixo x rotacionamos a camera, nao o objeto
    
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
                
                x2d = x2d * (perspective * z2d + (1-perspective));
                y2d = y2d * (perspective * z2d + (1-perspective));
                //x2d = x2d * (z2d / perspective);
                //y2d = y2d * (z2d / perspective);
                
                
                //----
                
              
    
                //----
    
                //x2d = centerx + x2d * (zoom + z2d * perspective);
                //y2d = centery + y2d * (zoom+ z2d * perspective);  
                x2d = centerx + x2d * (zoom);
                y2d = centery + y2d * (zoom);
                surface.vertices2D[vertice][0] = x2d;
                surface.vertices2D[vertice][1] = y2d;
            } // vertices
            
            // calcula a normal da superficie
            float nx = ay*bz - az*by;
            //float ny = ax*bz - az*bx;
            float ny = az*bx - ax*bz;
            float nz = ax*by - ay*bx;
            
            // ponto de origem da camera (vetor da camera)
            float cx = 0;
            float cy = angle3d[0];
            float cz = 100;
            
            // calcula N.C (produto escalar entre normal e camera)
            float dot = cx * nx + cy * ny + cz * nz;
            
            // calcula modulo de vetor camera e modulo de vetor normal
            float mc = sqrt(cx*cx + cy*cy + cz*cz);
            float mn = sqrt(nx*nx + ny*ny + nz*nz);
            
            // calcula a visibilidade usando o angulo entre a normal da superficie e o vetor da camera
            surface.visibility = dot / (mc*mn);
            
            /*if (s == 1) {
                println(nx + ", " + ny + ", " + nz);//surface.visibility);
            }            
            println("ddd " + angle3d[0]);*/
            
            surfaces.set(s, surface);
        } // for surfaces
        //return ret;
    } //rotate3D
    
    public void draw() 
    {
        background(0, 0, 100);  
        strokeWeight(1);
        stroke(0, 0, 150);
        for (int y=0; y < 20; y++) {
            line(0, height / 20 * y, width, height / 20 * y);
        }
        for (int x=0; x < 20; x++) {
            line(width / 20 * x, 0, width / 20 * x, height);
        }

        //fill(150, 0, 0, 100);
        //noFill(); 
        strokeWeight(2);
        stroke(255, 0, 0);
        for (int s=0; s < surfaces.size(); s++) {
            if (s == 0) {
                if (surfaces.get(s).visibility < 0) {
                    fill(150, 0, 0, 100);
                } else {
                    noFill();
                }
            } else {
                noFill();
            }
        
            //if (surfaces.get(s).visibility < 1) {
            if (true) {
                beginShape();         
                for (int v=0; v < 4; v++) {            
                    float x2d = surfaces.get(s).vertices2D[v][0];
                    float y2d = surfaces.get(s).vertices2D[v][1];
                    vertex(x2d, y2d);
                    //println(s + ", " + v + ": " + x2d + ", " + y2d);               
                }
                // repete o primeiro vertice pra fechar o shape
                float x2d = surfaces.get(s).vertices2D[0][0];
                float y2d = surfaces.get(s).vertices2D[0][1];
                vertex(x2d, y2d);
                endShape();
                           
                if (surfaces.get(s).visibility < 0) {                                
                    float x2d1 = surfaces.get(s).vertices2D[2][0];
                    float y2d1 = surfaces.get(s).vertices2D[2][1];
                    line(x2d, y2d, x2d1, y2d1);
                    
                    x2d = surfaces.get(s).vertices2D[1][0];
                    y2d = surfaces.get(s).vertices2D[1][1];                
                    x2d1 = surfaces.get(s).vertices2D[3][0];
                    y2d1 = surfaces.get(s).vertices2D[3][1];                    
                    line(x2d, y2d, x2d1, y2d1);
                }
                
                
            }
        }
        
    } // drawWireFrame
    
} // class   

float centerx;
float centery;
float zoom = 100;

PMObject3D cubo;

void setup() {
    size(800, 600, P3D);
    //offscreen = createGraphics(400,  300,  P2D);
    centerx = width / 2;
    centery = height / 2;
    cubo = new PMObject3D();
}

float [] angle3d = {
    0, 0, 0
};
float step = 1;

void draw() {    
    cubo.rotate3D(angle3d);   
    cubo.draw(); 

    //angle3d[0] += step;
    //angle3d[1] += step;
    //angle3d[2] += step;
}

void keyPressed() {
    //println(key);
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
            perspective -= 0.001;
        } 
        break;
    case '=':
        if (perspective < 0.1) {
            perspective += 0.001;
        } 
        break;    

    case 'z':
        if (angle3d[0] < 60) {
            angle3d[0] += 1;
            angle3d[0] = angle3d[0] % 360;
        }            
        break;
    case 'a':
        if (angle3d[0] > -15) {
            angle3d[0] -= 1;
            angle3d[0] = angle3d[0] % 360;
        } 
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

