import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Position;

class sailApp extends Application.AppBase {

    private var session;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        Position.enableLocationEvents( Position.LOCATION_CONTINUOUS, method( :onPosition ) );
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        Position.enableLocationEvents( Position.LOCATION_DISABLE, method(:onPosition));
    }

    function onPosition( info as Position.Info ) as Void {
        //System.println( "Position " + info.position.toGeoString( Position.GEO_DM ) );
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new sailView(), new sailDelegate() ];
    }

    function manageSession() {
        if (session == null) {
                session = ActivityRecording.createSession({:name=>"Sailing", :sport=>Activity.SPORT_SAILING});
                session.start();
                Attention.vibrate([new Attention.VibeProfile(50, 2000)]);
                Attention.playTone(Attention.TONE_START);
                System.println("Started recording");
            } else if (session.isRecording()) {
                session.stop();
                WatchUi.pushView(new Rez.Menus.ExitMenu(), new exitMenuDelegate(), WatchUi.SLIDE_LEFT);
                WatchUi.requestUpdate();
                Attention.vibrate([new Attention.VibeProfile(50, 2000)]);
                Attention.playTone(Attention.TONE_STOP);
                System.println("Stoped recording");
            }
    }

    function saveSession() {
        session.save();
        session = null;
        System.exit();
    }

    function discardSession() {
        session.discard();
        session = null;
        System.exit();
    }

    function resumeSession() {
        session.start();
    }

    function lapSession() {
        if (session != null) {
            session.addLap();
        }
    }

}

function getApp() as sailApp {
    return Application.getApp() as sailApp;
}