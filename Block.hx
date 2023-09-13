import flash.display.BitmapData;
import flash.Lib;
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Graphics;
import flash.utils.Timer;
import flash.events.TimerEvent;
class Block extends MovieClip{
    private var checkCollision:Timer = new Timer(1000*(1/Lib.current.stage.frameRate), 0);
    public function new(){
        this.graphics.beginFill(0xFF0000, 1);
        this.graphics.drawRect(0, 0, 144, 16);
        super();
    }
    public function startCollisionDetection(obj:MovieClip):Void{
        //function(event){ searchKeyPressHandler(event, x,y,z); }
        //I wasn't sure how to make this look nicer:
        checkCollision.addEventListener(TimerEvent.TIMER, 
            function(event){ detectCollision(event, obj); }     
        );
        checkCollision.start();
    }
    public function detectCollision(event:TimerEvent, obj:MovieClip):Void{
        if(this.hitTestObject(obj)){
            obj.stopFalling();
        }
    }
}