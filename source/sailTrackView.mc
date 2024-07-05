import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;


class sailTrackView extends WatchUi.MapTrackView {

    function initialize() {
        MapTrackView.initialize();

        setMapMode(WatchUi.MAP_MODE_PREVIEW);

        // create the bounding box for the map area
        var mypos = Position.getInfo().position.toDegrees();
        var top_left = new Position.Location({:latitude => mypos[0] + 0.001, :longitude =>mypos[1] - 0.001, :format => :degrees});
        var bottom_right = new Position.Location({:latitude => mypos[0] - 0.001, :longitude =>mypos[1] + 0.001, :format => :degrees});
        MapView.setMapVisibleArea(top_left, bottom_right);

        MapView.setScreenVisibleArea(0, System.getDeviceSettings().screenHeight / 2, System.getDeviceSettings().screenWidth, System.getDeviceSettings().screenHeight);

    }

     //! Load your resources here
    //! @param dc Device context
    public function onLayout(dc as Dc) as Void {
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    public function onShow() as Void {
    }

    //! Update the view
    //! @param dc Device context
    public function onUpdate(dc as Dc) as Void {
        // call the parent onUpdate function to redraw the layout
        MapView.onUpdate(dc);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
    }

}