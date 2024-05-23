import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;

class sailView extends WatchUi.View {

    private var _currentHeartRate;

    function initialize() {
        View.initialize();
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
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }


    //Update heart rate info
    function updateHeartRate(sensorInfo as Sensor.Info) as Void {

            if (sensorInfo.heartRate != null) {
                _currentHeartRate.setText(sensorInfo.heartRate.toString());
            } else {
                _currentHeartRate.setText("???");
            }

            WatchUi.requestUpdate();
    }

}
