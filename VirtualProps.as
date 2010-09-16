
import com.tweenman.*;

class com.tweenman.VirtualProps {

	static var visible:Function 		= VisibleProp;
	static var frame:Function 			= FrameProp;
	static var scale:Function			= ScaleProp;
	static var rectangle:Function		= RectangleProp;
	static var color:Function			= ColorProp;
	static var volume:Function			= SoundProp;
	static var pan:Function				= SoundProp;

	static var colormatrix:Function		= ColorFilterProp;
	static var bevel:Function			= BevelFilterProp;
	static var blur:Function			= BlurFilterProp;
	static var convolution:Function		= ConvolutionProp;
	static var displace:Function		= DisplaceProp;
	static var dropshadow:Function		= DropShadowProp;
	static var glow:Function			= GlowFilterProp;

	static var backgroundColor:Function	= HexColorProp;
	static var borderColor:Function		= HexColorProp;
	static var textColor:Function		= HexColorProp;
	static var hexColor:Function		= HexColorProp;

}