import java.applet.*;
import java.awt.*;
import java.util.*;

public class HelloWorldApplet extends Applet 
{
   int squareSize = 50;   // initialized to default size
   private Color parseColor (String param) 
   {
   return Color.yellow;
   }
   public void paint (Graphics g) 
   {  
   
		/* Draw the squares of the checkerboard and the checkers. */

		for (int row = 0; row < 8; row++) {
			for (int col = 0; col < 8; col++) {
				if (row % 2 == col % 2)
					g.setColor(Color.lightGray);
				else
					g.setColor(Color.gray);
				g.fillRect(2 + col * 50, 2 + row * 50, 50, 50);
							}
            }
			}
         
   //public  final Pieces[][] board; 
   public void init () 
   {
 
   
}

}