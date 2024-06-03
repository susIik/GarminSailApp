import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Application as App;

class exitMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :save) {
            App.getApp().saveSession();
        } else if (item == :resume) {
            App.getApp().resumeSession();
        } else if (item == :discard) {
            App.getApp().discardSession();
        }
    }

}