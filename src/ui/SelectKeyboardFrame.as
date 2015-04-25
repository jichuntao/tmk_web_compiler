package ui
{
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	
	public class SelectKeyboardFrame extends JFrame
	{
		private var selectButton:JButton;
		public function SelectKeyboardFrame(owner:*=null, title:String="", modal:Boolean=true)
		{
			super(owner, title, modal);
			initControl();
		}
		private function initControl():void
		{
			this.setWidth(300);
			this.setHeight(200);
			this.setActivable(false);
			this.setResizable(false);
			this.setDragable(true);
			this.setClosable(false);
			this.getContentPane().setLayout(new FlowLayout());
			selectButton = new JButton('select');
			this.getContentPane().append(selectButton);
		}
	}
}