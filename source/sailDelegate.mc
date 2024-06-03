import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.ActivityRecording;
using Toybox.Application as App;

class sailDelegate extends WatchUi.BehaviorDelegate {

    var session;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new sailMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onKey(evt) {
        if (evt.getKey() == KEY_ENTER) {
            App.getApp().manageSession();
            return true;
        }
        return false;
    }

}