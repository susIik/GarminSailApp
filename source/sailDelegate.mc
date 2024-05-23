import Toybox.Lang;
import Toybox.WatchUi;

class sailDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new sailMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}