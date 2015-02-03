package ui
{
	
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.BoxLayout;
	import org.aswing.EmptyLayout;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JComboBox;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JTextField;
	import org.aswing.geom.IntPoint;

	public class KeyBoardPanel extends JPanel
	{
		private var content:KeyBoardEditContent;
		private var defaultAsFont:ASFont;
		private var editBtn:JButton;
		private var addLayerBtn:JButton;
		private var delLayerBtn:JButton;
		private var exampleLayoutComboBox:JComboBox;

		public function KeyBoardPanel()
		{
			this.setLayout(new EmptyLayout());
			defaultAsFont=new ASFont("Tahoma", 16, true, false, false, false);
			editBtn = new JButton('Edit Layout');
			editBtn.setFont(defaultAsFont);
			editBtn.setWidth(120)
			editBtn.setHeight(30);
			

			
			addLayerBtn = new JButton('Add Layer');
			addLayerBtn.setFont(defaultAsFont);
			addLayerBtn.setBackground(new ASColor(0x33cc66, 1));
			addLayerBtn.setWidth(120)
			addLayerBtn.setHeight(30);
			
			
			delLayerBtn = new JButton('Del Layer');
			delLayerBtn.setFont(defaultAsFont);
			delLayerBtn.setBackground(new ASColor(0xff3300, 1));
			delLayerBtn.setWidth(120)
			delLayerBtn.setHeight(30);
			
			
			exampleLayoutComboBox=new JComboBox();
			exampleLayoutComboBox.setFont(defaultAsFont);
			exampleLayoutComboBox.setMaximumRowCount(7);
			exampleLayoutComboBox.setWidth(120)
			exampleLayoutComboBox.setHeight(30);
			
			var la:JLabel=new JLabel('fffasdasdasdad');
			this.addChild(la);
			la.setWidth(100);
			la.setHeight(20);
			
			this.addChild(la);
			this.addChild(editBtn);
			this.append(addLayerBtn);
			this.append(delLayerBtn);
			this.append(exampleLayoutComboBox);
			
			
			content = new KeyBoardEditContent();
			this.addChild(content);
			content.y=50;
			content.x=30;
			
			editBtn.setLocationXY(30,10);
			addLayerBtn.setLocationXY(editBtn.getWidth()+editBtn.getX()+30,10);
			delLayerBtn.setLocationXY(addLayerBtn.getWidth()+addLayerBtn.getX()+4,10);
			exampleLayoutComboBox.setLocationXY(870-exampleLayoutComboBox.getWidth(),10);
			
			content.initConfig(Testconfig.getTestConfig());
			content.initData(Testconfig.getDefaultData());
			content.init();
			content.drawKeyboard();
			content.updateKeyLabel();
	
		}
		
	}
}