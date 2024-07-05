import Toybox.Lang;
import Toybox.WatchUi;

//! Input handler for the map views
class sailTrackDelegate extends WatchUi.BehaviorDelegate {

    //! Constructor
    //! @param view The associated map view
    public function initialize() {
        BehaviorDelegate.initialize();

    }

    //! Handle the back event
    //! @return true if handled, false otherwise
    public function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_UP);
        return true;
    }
}