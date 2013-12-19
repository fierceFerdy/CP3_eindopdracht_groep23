/**
 * Created with IntelliJ IDEA.
 * User: ferdyfiers
 * Date: 12/12/13
 * Time: 13:37
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.conversion.view {
import be.devine.cp3.conversion.elements.ChoiceButton;
import be.devine.cp3.conversion.elements.MenuButton;
import be.devine.cp3.conversion.model.Appmodel;
import be.devine.cp3.conversion.utils.Utils;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class MenuView extends Sprite implements ICanBeViewed{
    private var _logoBitMapData:BitmapData;
    private var _logo:Image;
    private var _appModel:Appmodel;
    private var _conversions:ChoiceButton;
    private var _history:ChoiceButton;
    private var _profiles:ChoiceButton;
    private var _terminate:ChoiceButton;

    public function MenuView() {
        trace("[MenuView] started.");
        _appModel = Appmodel.getInstance();
    }

    private function profilesHandler(event:TouchEvent):void {
        var touch:Touch = event.getTouch(this, TouchPhase.ENDED);
        if(touch){
            _appModel.currentScreen = "ProfileView";
        }
    }

    private function historyHandler(event:TouchEvent):void {
        var touch:Touch = event.getTouch(this, TouchPhase.ENDED);
        if(touch){
            _appModel.currentScreen = "HistoryView";
        }
    }

    private function conversionsHandler(event:TouchEvent):void {
        var touch:Touch = event.getTouch(this, TouchPhase.ENDED);
        if(touch){
            _appModel.currentScreen = "ConversionsView";
        }
    }

    private function terminateHandler(event:TouchEvent):void {
        var touch:Touch = event.getTouch(this, TouchPhase.ENDED);
        if(touch){
            // Terminate the app

        }
    }

    private function drawMenu():void{
        // Draw the menu, please use a seperate method instead of doing sth similar in the constructor.
        _conversions = new ChoiceButton("Conversions");
        _conversions.addEventListener(TouchEvent.TOUCH, conversionsHandler);
        _conversions.y = 320*Utils.divideFactor;
        addChild(_conversions);

        var yPos:uint = _conversions.height + 5;

        _history = new ChoiceButton("History");
        _history.addEventListener(TouchEvent.TOUCH, historyHandler);
        _history.y = _conversions.y + yPos;
        addChild(_history);

        _profiles = new ChoiceButton("Profiles");
        _profiles.addEventListener(TouchEvent.TOUCH, profilesHandler);
        _profiles.y = _history.y + yPos;
        addChild(_profiles);
        _terminate = new ChoiceButton("Close");
        _terminate.addEventListener(TouchEvent.TOUCH, terminateHandler);
        _terminate.y = _profiles.y + yPos;
        addChild(_terminate);
    }

    private function drawLogo():void{
        // Make Flash asset in SWC
        var logo:Logo = new Logo();

        // Make Bitmapdata
        _logoBitMapData = new BitmapData(logo.width, logo.height, true, 0xFF0000);
        _logoBitMapData.draw(logo);

        _logo = Image.fromBitmap(new Bitmap(_logoBitMapData));
        _logoBitMapData.dispose();
        _logo.scaleX = Utils.divideFactor;
        _logo.scaleY = Utils.divideFactor;
        _logo.x = Utils.screenWidth/2 - _logo.width/2;
        _logo.y = 60*Utils.divideFactor;
        addChild(_logo);
    }

    public function resize(w:Number, h:Number):void{
        drawLogo();
        drawMenu();
    }
}
}