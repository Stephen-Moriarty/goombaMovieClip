import flash.display.MovieClip;
import flash.Lib;
import PlayerImage;
class Main extends flash.display.MovieClip{
    public static function main():Void{
        var stage = Lib.current.stage;
        
        var goomba:PlayerImage = new PlayerImage();
        stage.addChild(goomba);
        goomba.shortTimer();
        goomba.startFalling();
        trace(Lib.current.stage.frameRate);

        var block:Block = new Block();
        stage.addChild(block);
        block.y=128;
        block.startCollisionDetection(goomba);
    }
}
