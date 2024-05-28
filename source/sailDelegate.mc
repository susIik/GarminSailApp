import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.ActivityRecording;

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
            if (( session == null ) || ( session.isRecording() == false )) {
                session = ActivityRecording.createSession({:name=>"Sailing", :sport=>Activity.SPORT_SAILING});
                session.start();
                System.println("Started recording");
            } else if ( session != null && session.isRecording() ) {
                session.stop();
                session.save();
                session = null;
                System.println("Stoped recording");
            }
            return true;
        }
        return false;
    }

}