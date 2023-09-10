import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.Lib;
import flash.display.Sprite;
import flash.display.MovieClip;
class PlayerImage extends MovieClip{
    public function new() {
        super();
        this.stop();
    }
    public function ShortTimer(){
        // creates a new five-second Timer
        var minuteTimer:Timer = new Timer(4, 0);

        // designates listeners for the interval and completion events
        //minuteTimer.addEventListener(TimerEvent.TIMER, onTick);
        minuteTimer.addEventListener(TimerEvent.TIMER_COMPLETE, switchFrame);

        // starts the timer ticking
        minuteTimer.start();
    } 
    public function switchFrame(event:TimerEvent){
        nextFrame();
    }
    public function onTimerComplete(event:TimerEvent):Void{
        trace("Time's Up!");
    }
}