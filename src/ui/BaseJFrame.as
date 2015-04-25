package ui
{
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.JFrame;
	import org.aswing.plaf.ASColorUIResource;
	import org.aswing.plaf.ComponentUI;
	
	public class BaseJFrame extends JFrame
	{
		public function BaseJFrame(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, title, modal);
			var uic:ComponentUI = this.getUI();
			uic.putDefault("Frame.mideground",new ASColorUIResource(0x119FCF));
			this.setUI(uic);
			var titleBar:Component = this.getTitleBar().getSelf();
			titleBar.setForeground(new ASColor(0xcccccc));
//			frame.getTitleBar().getLabel().setHorizontalAlignment(1);
//			uic = titleBar.getUI();
//			uic.putDefault("FrameTitleBar.foreground",new ASColorUIResource());
//			uic.putDefault("FrameTitleBar.mideground",new ASColorUIResource(0x0000FF,0.5));
//			titleBar.setUI(uic);
		}
	}
}