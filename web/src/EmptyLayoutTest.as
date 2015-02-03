package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	
	import org.aswing.AsWingManager;
	import org.aswing.JFrame;
	import org.aswing.JButton;
	import org.aswing.EmptyLayout;
	
	public class EmptyLayoutTest extends Sprite
	{
		public function EmptyLayoutTest()
		{
			AsWingManager.setRoot(this);
			
			var frame:JFrame = new JFrame(this, "EmptyLayoutTest");
			frame.getContentPane().setLayout(new EmptyLayout());
			
			var button1:JButton = new JButton("button1");
			button1.setSizeWH(80, 30);
			button1.setLocationXY(50, 20);
			frame.getContentPane().append(button1);
			
			var button2:JButton = new JButton("button2");
			button2.setSizeWH(200,150);
			button2.setLocationXY(60, 70);
			frame.getContentPane().append(button2);  
			
			frame.show();
			frame.setSizeWH(350, 280);
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
		}
	}
}