import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.ActivityRecording;
using Toybox.Application as App;

class timeDelegate extends WatchUi.BehaviorDelegate {

    var session;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        //WatchUi.pushView(new Rez.Menus.MainMenu(), new sailMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onKey(evt) {
        if (evt.getKey() == KEY_ENTER) {
            App.getApp().manageSession();
            return true;
        } else if (evt.getKey() == KEY_ESC) {
            App.getApp().lapSession();
            return true;
        } else if (evt.getKey() == KEY_DOWN) {
            WatchUi.pushView(App.getApp().sailTab[0], App.getApp().sailTab[1], WatchUi.SLIDE_UP);
            //WatchUi.pushView(new sailTrackView(), new sailTrackDelegate(), WatchUi.SLIDE_UP);
            return true;
        } else if (evt.getKey() == KEY_UP) {
            WatchUi.pushView(App.getApp().sailTab[0], App.getApp().sailTab[1], WatchUi.SLIDE_DOWN);
            //WatchUi.pushView(new sailTrackView(), new sailTrackDelegate(), WatchUi.SLIDE_UP);
            return true;
        }
        return false;
    }

}