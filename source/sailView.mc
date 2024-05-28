import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.Position;
import Toybox.Activity;

class sailView extends WatchUi.View {

    private var _currentHeartRate;
    private var lasthr;
    private var _timer;

    function initialize() {
        View.initialize();
        lasthr = 0;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _currentHeartRate = findDrawableById("heart_rate");
        _timer = findDrawableById("timer");
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


        _timer.setText(self.formatTime(1000));

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

    function formatTime(t) {
        var h = t / 1000 / 60 / 60;
        var m = t / 1000 / 60 % 60;
        var s = t / 1000 % 60;
        return h.format("%d") + ":" + m.format("%d") + ":" + s.format("%d");
    }

}
