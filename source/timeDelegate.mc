import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.ActivityRecording;
using Toybox.Application as App;

class timeDelegate extends WatchUi.BehaviorDelegate {

    var session;
    private var _keyTime = null;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        //WatchUi.pushView(new Rez.Menus.MainMenu(), new sailMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onSwipe(swipeEvt) as Boolean {
        return true;
    }

    function onKeyPressed(evt) {
        if (evt.getKey() == KEY_ENTER) {
            _keyTime = System.getTimer();
            return true;
        }
        return false;
    }

    function onKeyReleased(evt) {
        if (evt.getKey() == KEY_ENTER) {
            if ( _keyTime && System.getTimer() - _keyTime > 1000) {
                App.getApp().manageSession();
            }
            _keyTime = null;
            return true;
        }
        return false;
    }

    function onKey(evt) {
        if (evt.getKey() == KEY_ESC) {
            App.getApp().lapSession();
            return true;
        } else if (evt.getKey() == KEY_DOWN) {
            WatchUi.switchToView(App.getApp().sailTab[0], App.getApp().sailTab[1], WatchUi.SLIDE_UP);
            //WatchUi.pushView(new sailTrackView(), new sailTrackDelegate(), WatchUi.SLIDE_UP);
            return true;
        } else if (evt.getKey() == KEY_UP) {
            WatchUi.switchToView(App.getApp().sailTab[0], App.getApp().sailTab[1], WatchUi.SLIDE_DOWN);
            //WatchUi.pushView(new sailTrackView(), new sailTrackDelegate(), WatchUi.SLIDE_UP);
            return true;
        }
        return false;
    }

}