import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.Lib;
import flash.display.Sprite;
import flash.display.MovieClip;
class PlayerImage extends MovieClip{
    private var velocityY:Float = 0;
    private var gravity:Float = 0.1;
    private var time:Float = 0;
    //17 milliseconds is basically the lowest it reccomends I work with for timer
    /*
        I don't know if it is better to use 1000*(1/60) for the gravity Timer,
        or if I should just use whatever the swf's framerate in place of "60",
        and technically I think I should try to keep mt code as independent 
        of the swf's framerate as possible though. (Which I might have to 
        look into implementing a deltaTime sort of thing in Flash if I 
        am not provided with one already).
        
        I am just not sure what way I should do that, to mimic the passage of time, for a 
        velocity calculation and whatever else I would need the emulation of the passage of time for.
    */
    private var gravityTimer:Timer = new Timer(1000*(1/Lib.current.stage.frameRate), 0); //Lib.current.stage.frameRate
    
    // Constructor
    public function new(){
        super();
        //trace();
        this.stop();
    }
    /*
        So figuring out how to time this animation took a while, a lot of reading.
        So basically, I have a method of this class that will start the 
        animation and keep it running forever.
        So you call that function, it makes a timer with a delay
        (how many milliseconds before the next frame) and a repeat count.
        I make the repeat count 0 so that it loops forever in the case of a 
        goomba, and the millisecond delay is how long before it switches frames
        And I have to use these two things:
        flash.utils.Timer
        flash.events.TimerEvent
        To get the functionality I want in this particular case
        So for this one:
        flash.events.TimerEvent
        I have to use the:
        TimerEvent.TIMER, because for the event listener that will call the
        function of the event listener every however many milliseconds you
        chose from earlier.
        And the function I call in this case is a function that will deal
        with MovieClip frames
        And the way that function currently deals with MovieClip frames is
        since it only has two frames, it checks which one of two
        frames the MovieClip is on, and then goes to the next one if
        it is on the first frame, and goes to the previous frame if
        it is on the last frame.
    */
    /*
        A very sad mistake I was making at first was that I THOUGHT when you have the:
        TIMER_COMPLETE
        in the event listener it called the function when the amount of time you called for a delay passed,
        but I was very wrong about that, so that was me mis-understanding what the different ENUMS do and stand for.
    */
    /*
        Another thing that took me a while to figure out is: If Flash starts MovieClip frames at 0, or at 1.
        It turns out that it starts MovieClip frames at 1 and goes up from there.
    */
    public function shortTimer(){
        // (delay, count) keep count 0, for infinite
        var minuteTimer:Timer = new Timer(300, 0);

        minuteTimer.addEventListener(TimerEvent.TIMER, switchFrame);

        // starts the timer ticking
        minuteTimer.start();
    } 
    public function switchFrame(event:TimerEvent){
        // The first frame starts at 1, NOT 0, keep that in mind.
        if(this.currentFrame==1){
            this.nextFrame();
        }else if(this.currentFrame==2){
            this.prevFrame();
        }
        
    }
    public function onTimerComplete(event:TimerEvent):Void{
        trace("Time's Up!");
    }
    public function startFalling():Void{
        gravityTimer.addEventListener(TimerEvent.TIMER, fall);
        gravityTimer.start();
    }
    public function stopFalling():Void{
        gravityTimer.reset();
        time=0;
    }
    public function fall(event:TimerEvent):Void{
        /*
            Velocity = gravity times time. (v=g*t)
            So you change the x position by the amount velocity.
        */
        increaseTime();
        velocityY=gravity*time;
        this.y+=velocityY;

    }
    public function increaseTime():Void{
        time+=1;
    }
    /*
        For reference: v=g*t
        So currently I was able to make the object fall due to gravity, by
        making a method that starts the "gravity", and in that method, I add 
        an eventlistener to a private timer variable, that calls a method 
        called fall(), at the inverse of the framerate, and then I start 
        that timer.
        And so in the fall method I first update/increase time because for 
        objects to be in motion I have to mimic the passage of time, or
        else techically no time has passed, so objects can't be in motion
        and then I use an implementation of the v=g*f equation:
        velocityY=gravity*time
        and then to actually move the object I update the MovieClip's
        object y coordinate by adding the velocity to it.
        Which not only mimics a falling object, but is also quite cool
        because it is like a real x and y coordinate system
        --
        which makes it easier to build things from and off of.
        Such as the collision detection which I worked on afterwards.
    */
}