import flash.display.MovieClip;
import flash.Lib;
import PlayerImage;
class Main extends flash.display.MovieClip{
    public static function main():Void{
        var stage = Lib.current.stage;
        var goomba:PlayerImage = new PlayerImage();
        stage.addChild(goomba);
        goomba.gotoAndPlay("left");
    }
}
