import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Application as App;

class exitMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId();

        if (id == :save) {
            App.getApp().saveSession();
        } else if (id == :resume) {
            App.getApp().resumeSession();
        } else if (id == :discard) {
            App.getApp().discardSession();
        }
    }

    function onBack() as Void {
    }

}