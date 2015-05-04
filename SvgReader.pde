
import geomerative.*;
import java.util.Collections;

public class SVGReader {
  //shapes and points for the SVG storage

  float scaler;
  RShape rs;
  RPoint[] points;
  ArrayList ve= new ArrayList();

  //plot device

  PApplet parent;
  ArrayList<Integer> colorpresent = new ArrayList<Integer>();

  int targetWidth;
  int targetHeight;
  int Xorigine;
  int Yorigine;
  float maxWidth=0;
  int id=0;


  SVGReader(PApplet parent, String svgName, int widths, int heights, int xorigine, int yorigine) {
    this.parent = parent;
    //run setups for geomerative library
    RG.init(parent);
   // RG.setPolygonizer(RG.UNIFORMLENGTH); 
   // RG.setPolygonizerLength(0.01);
    RG.setPolygonizer(RG.ADAPTATIVE); 
    RG.setPolygonizerAngle(10);
    targetWidth=widths;
    targetHeight=heights;
    Xorigine=xorigine;
    Yorigine=yorigine;
   
    //load SVG into shape
    rs = RG.loadShape(svgName);

    println();
    println("STARTING SVGReader CLASS");
    println("Image width is: " + rs.width + " Image height is: " + rs.height);
    float scaleW = targetWidth/rs.width;
    float scaleH = targetHeight/rs.height;
    println("Scale based on width:  " + scaleW);
    println("Scale based on height: " + scaleH);
    scaler = min(scaleW, scaleH);
    println("Using smaller scale:   " + scaler);
    exVert(rs);

    Collections.sort(ve);
  }

  void exVert(RShape s) {
    RShape[] ch; // children
    int n, i, j;
    RPoint[][] pa;
    float z=0;


    n = s.countChildren();
    if (n > 0) {
      ch = s.children;
      for (i = 0; i < n; i++) {
        exVert(ch[i]);
      }
    }
    else { // no children -> work on vertex
      int couleur= s.getStyle().strokeColor;
      float weight= s.getStyle().strokeWeight;
      if (weight>maxWidth) {
        maxWidth=weight;
      }
      boolean strokeisnew=true;
      for (int k=0;k<colorpresent.size(); k++) {
        if (couleur==colorpresent.get(k)  ) {
          strokeisnew=false;
        }
      }
      if (strokeisnew==true) {
        colorpresent.add(couleur);
      }
      pa = s.getPointsInPaths();
      if (pa!=null ) {
        if (pa[0]!=null) {
          n = pa.length;
          for (i=0; i<n; i++) {
            if (pa[i]!=null) {
              for ( j=0; j<pa[i].length; j++) {
                if (j==0) {
                  z=pa[i][j].y;
                  id=id+1;


                  ve.add(new Point(pa[i][j].x*scaler+Xorigine, pa[i][j].y*scaler+Yorigine, z, id, couleur, weight));
                }
                else
                  ve.add(new Point(pa[i][j].x*scaler+Xorigine, pa[i][j].y*scaler+Yorigine, z, id, couleur, weight));
              }
            }
          }
          println("#paths: " + pa.length);
        }
      }
    }
  }

  float returnMaxWidth() {
    return maxWidth;
  }

  ArrayList returnPointArray() {
    return ve;
  }


  int returnColor(int number) {
    if (number<colorpresent.size()) {

      return colorpresent.get(number);

    }
    else {
      println("no such color");
      return -1;
    }
  }
  
  
  int returnColorNum(){
    return colorpresent.size();}
    


 void display(float scale, float x, float y){
   pushMatrix();
   translate(x+Xorigine,y+Yorigine);
   scale(scale*scaler);
rs.draw();   
popMatrix();
 }
  int findcolorstart(int couleur) {
    int taille=ve.size();
    for (int i=1;i<taille;i++) {
      if (((Point) ve.get(i)).couleur==couleur & ((Point) ve.get(i-1)).couleur!=couleur) {


        return i;
      }
    }

    if (((Point) ve.get(0)).couleur==couleur) {
      return(0);
    }
    else {
      return(-1);
    }
  }



  int findcolorend(int couleur) {
    int taille=ve.size();
    for (int i=1;i<taille-1;i++) {
      if (((Point) ve.get(i)).couleur!=couleur & ((Point) ve.get(i-1)).couleur==couleur) {

        return (i-1);
      }
    }
    return(taille-1);
  }
}









class Point implements Comparable {
  float x, y, z;
  int id;
  int couleur;
  float weight;
  Point(float x, float y, float z, int id, int couleur, float weight) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.id = id;
    this.couleur = couleur;
    this.weight = weight;
  }

  void set(float x, float y, float z, int id, int couleur, float weight) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.id = id;
    this.couleur = couleur;
    this.weight = weight;
  }

  int compareTo(Object o) {
    Point pt = (Point)o;
    float d1=z;
    float col1=couleur;
    float col2=pt.couleur;
    float d2=pt.z;
    if (col1==col2) {
      if (d1 < d2) {
       // return -1;
        return 0;
      } 
      else if (d1 > d2) {
       // return 1;
        return 0;
      } 
      else {
        return 0;
      }
    }
    else {
      if (col1<col2) {
        return -1;
      }
      else { 
        return 1;
      }
    }
  }
}



