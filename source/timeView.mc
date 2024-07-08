import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.Position;
import Toybox.Activity;
using Toybox.Application as App;
import Toybox.Time.Gregorian;

class timeView extends WatchUi.View {
    private var _updateTimer;
    private var _clock;
    private var _date;

    function initialize() {
        View.initialize();

        _updateTimer = new Timer.Timer();
        _updateTimer.start(new Lang.Method(WatchUi, :requestUpdate), 1000, true);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.TimeLayout(dc));

        _clock = findDrawableById("clock");
        _date = findDrawableById("date");
    }


    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        self.getTime();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        //Draw activity status
        dc.setColor( self.activityColor(), Graphics.COLOR_BLACK);
        dc.setPenWidth(6);
        dc.drawCircle(dc.getWidth() / 2, dc.getHeight() / 2, dc.getHeight() / 2 - 6);

        self.getTime();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }


    //Update heart rate info
    function getTime() {
        var cur_time = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);

        _clock.setText(cur_time.hour.format("%02d") + ":" + cur_time.min.format("%02d"));
        _date.setText(cur_time.month + " " + cur_time.day.format("%d"));
    }

    function activityColor() {
        return App.getApp().session && App.getApp().session.isRecording() ? Graphics.COLOR_DK_GREEN : Graphics.COLOR_DK_RED;
    }
}
