import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Position;

class sailApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        Position.enableLocationEvents( Position.LOCATION_DISABLE, method(:onPosition));
    }

    function onPosition( info as Position.Info ) as Void {
        System.println( "Position " + info.position.toGeoString( Position.GEO_DM ) );
    }

    function initializeListener() as Void {
        Position.enableLocationEvents( Position.LOCATION_CONTINUOUS, method( :onPosition ) );
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new sailView(), new sailDelegate() ];
    }

}

function getApp() as sailApp {
    return Application.getApp() as sailApp;
}