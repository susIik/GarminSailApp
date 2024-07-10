import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.Position;
import Toybox.Activity;
using Toybox.Application as App;

class sailView extends WatchUi.View {

    private var _currentHeartRate;
    private var _timer;
    private var _updateTimer;
    private var _speed;

    var cusfont = null;

    function initialize() {
        View.initialize();

        _updateTimer = new Timer.Timer();
        _updateTimer.start(new Lang.Method(WatchUi, :requestUpdate), 1000, true);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        cusfont = WatchUi.loadResource(Rez.Fonts.random);

        _currentHeartRate = findDrawableById("heart_rate");
        _timer = findDrawableById("timer");
        _speed = findDrawableById("speed");
    }


    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        self.updateHR(Sensor.getInfo());
        self.updateSpeed(Sensor.getInfo());
        self.updateTimer(Activity.getActivityInfo());
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        //dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
		//dc.clear();
		
		// Draw GPS Status
		var gpsinfo = Position.getInfo();
		dc.setColor( self.getGPSQualityColour(gpsinfo), Graphics.COLOR_BLACK);
        dc.setPenWidth(3);
        dc.drawCircle(dc.getWidth() * 7 / 8, dc.getHeight() / 2, 36);
        
        
        //Draw activity status
        dc.setColor( self.activityColor(), Graphics.COLOR_BLACK);
        dc.setPenWidth(6);
        dc.drawCircle(dc.getWidth() / 2, dc.getHeight() / 2, dc.getHeight() / 2 - 6);
        //dc.setColor( Graphics.COLOR_RED, Graphics.COLOR_ORANGE);
        //dc.drawText(100, 100, cusfont, "l", Graphics.TEXT_JUSTIFY_CENTER);


        // Write info
        self.updateHR(Sensor.getInfo());
        self.updateSpeed(Sensor.getInfo());
        self.updateTimer(Activity.getActivityInfo());
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }


    //Update heart rate info
    function updateHR(sensorInfo as Sensor.Info) as Void {
        var hr = sensorInfo.heartRate;
        if (hr != null) {
            _currentHeartRate.setText(hr.toString());
        } else {
            _currentHeartRate.setText("-");
        }
    }


    //Update heart rate info
    function updateSpeed(sensorInfo as Sensor.Info) as Void {
        var speed = sensorInfo.speed;
        if (speed != null) {
            speed = speed * 1.94384;
            _speed.setText(speed.format("%.1f"));
        } else {
            _speed.setText("-");
        }
    }


    //Update timer
    function updateTimer(activityInfo as Activity.Info) as Void {
        var timer = activityInfo.elapsedTime;
        if (timer != null) {
            _timer.setText(formatTime(timer));
        } else {
            _timer.setText("00:00:00");
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
        return h.format("%02d") + ":" + m.format("%02d") + ":" + s.format("%02d");
    }

    function activityColor() {
        return App.getApp().session && App.getApp().session.isRecording() ? Graphics.COLOR_DK_GREEN : Graphics.COLOR_DK_RED;
    }

}
