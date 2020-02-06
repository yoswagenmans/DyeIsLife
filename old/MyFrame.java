import javax.swing.*;
	
	class MyFrame extends JFrame {
	  public MyFrame() {
		setTitle("My Empty Frame");
		setSize(300,200); // default size is 0,0
		setLocation(10,200); // default is 0,0 (top left corner)
	  }
	
	  public static void main(String[] args) {
	    JFrame f = new MyFrame();
	    f.show();
	  }
	}
	