/**
 * Este exemplo requer a biblioteca Keystone 5
 *
 */

import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surface1, surface2;

PGraphics offscreen1, offscreen2;

void setup() {
  // Keystone will only work with P3D or OPENGL renderers, 
  // since it relies on texture mapping to deform
  size(800, 600, P3D);

  ks = new Keystone(this);
  surface1 = ks.createCornerPinSurface(400, 300, 20);
  surface2 = ks.createCornerPinSurface(300, 200, 20);
  
  // We need an offscreen buffer to draw the surface we
  // want projected
  // note that we're matching the resolution of the
  // CornerPinSurface.
  // (The offscreen buffer can be P2D or P3D)
  offscreen1 = createGraphics(400, 300, P3D);
  offscreen2 = createGraphics(400, 300, P3D);
  
  ks.load();
}

float time = 0;
float center = 400;
float oldx1 = 400;
float oldx2 = 400;

float cx1 = 200;
float cy1 = 150;
float cx2 = 200;
float cy2 = 150;

void draw() {

  // Convert the mouse coordinate into surface coordinates
  // this will allow you to use mouse events inside the 
  // surface from your screen. 
  PVector surfaceMouse = surface1.getTransformedMouse();

  // Draw the scene, offscreen
  /*offscreen1.beginDraw();
  offscreen1.background(255);
  offscreen1.fill(0, 255, 0);
  offscreen1.ellipse(surfaceMouse.x, surfaceMouse.y, 75, 75);
  offscreen1.endDraw();*/
  
  /*cx1 = cx1 + (random(10) - 5)/10;
  cy1 = cy1 + (random(10) - 5)/10;
  cx2 = cx2 + (random(10) - 5)/10;
  cy2 = cy2 + (random(10) - 5)/10;*/
  
  
  offscreen1.beginDraw();
  offscreen1.background(200, 130, 110);
  //offscreen2.fill(255, 0, 0);  
  offscreen1.noFill();
  offscreen1.stroke(255,0,0);
  for (int i=0; i < 100; i++) {
    offscreen1.ellipse(cx1, cy1, i * 20, i * 20);
  }
  offscreen1.endDraw();

   surfaceMouse = surface2.getTransformedMouse();

  // Draw the scene, offscreen
  offscreen2.beginDraw();
  offscreen2.background(110, 120, 200);
  offscreen2.fill(255, 0, 0);
  offscreen2.noFill();
  offscreen2.stroke(0,0,255);
  for (int i=0; i < 100; i++) {
      offscreen2.ellipse(cx2, cy2, i * 20, i * 20);
  }
  //offscreen2.ellipse(surfaceMouse.x, surfaceMouse.y, 75, 75);
  offscreen2.endDraw();  

  // most likely, you'll want a black background to minimize
  // bleeding around your pros cjection area
  background(0);
 
  // render the scene, transformed using the corner pin surface
  surface1.render(offscreen1);
  surface2.render(offscreen2);
  time = time + 0.001;
  float newx = center + (sin(time * 180 / 3.1415)) * 100;
  
  float offset1 = newx - oldx1;
  float offset2 = newx - oldx2;
  
  oldx1 = oldx1 + offset1;
  oldx2 = oldx2 + offset2;

  surface1.moveMeshPointBy(CornerPinSurface.TL, offset1, 0);
  surface1.moveMeshPointBy(CornerPinSurface.BL, offset1, 0);  
  surface2.moveMeshPointBy(CornerPinSurface.TR, offset2, 0);
  surface2.moveMeshPointBy(CornerPinSurface.BR, offset2, 0);
}

void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  }
}

