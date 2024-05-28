import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.Position;

class sailView extends WatchUi.View {

    private var _currentHeartRate;
    private var lasthr;

    function initialize() {
        View.initialize();
        lasthr = 0;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _currentHeartRate = findDrawableById("heart_rate");
        Sensor.enableSensorEvents( method(:updateHeartRate) );
    }


    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
		//dc.clear();
		
		// Draw GPS Status
		var gpsinfo = Position.getInfo();
		//var gpsIsOkay = ( gpsinfo.accuracy == Position.QUALITY_GOOD || gpsinfo.accuracy == Position.QUALITY_USABLE );
		
		dc.setColor( self.getGPSQualityColour(gpsinfo), Graphics.COLOR_BLACK);
		dc.fillRectangle(0, dc.getHeight() -35, dc.getWidth(), 20);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }


    //Update heart rate info
    function updateHeartRate(sensorInfo as Sensor.Info) as Void {
        var hr = sensorInfo.heartRate;
        if (hr != lasthr) {
            if (hr != null) {
                _currentHeartRate.setText(hr.toString());
            } else {
                _currentHeartRate.setText("-");
            }
            lasthr = hr;
            WatchUi.requestUpdate();
            System.println("cool");
        }
    }


    function getGPSQualityColour(g) {
		var gpsInf;
		if( g == null ) {
			gpsInf = Position.getInfo();
		} else {
			gpsInf = g;
		}
	
		if( gpsInf.accuracy == Position.QUALITY_GOOD ) {
			return Graphics.COLOR_DK_GREEN;
		} else if( gpsInf.accuracy == Position.QUALITY_USABLE ) {
			return Graphics.COLOR_YELLOW;
		}
		return Graphics.COLOR_DK_RED;
	}

}
