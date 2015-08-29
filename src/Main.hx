import luxe.Input;
import luxe.Sprite;
import luxe.Color;
import luxe.tween.Actuate;
import luxe.Vector;
import Luxe.Ev;

class EventOnClick extends luxe.Component {
    var visual:luxe.Visual;

    override function init() {
        visual = cast entity;
    }

    override function onmousedown(event :MouseEvent) {
        if (Luxe.utils.geometry.point_in_geometry(event.pos, visual.geometry)) {
            entity.events.fire('clicked', entity);
        }
    }
}

class Main extends luxe.Game {
    static var soundFiles = Macro.getSoundFiles();

    override function config(config:luxe.AppConfig) {
        for (name in soundFiles)
            config.preload.sounds.push({id: 'assets/$name', name: name, is_stream: false});
        return config;
    }

    override function ready() {
        var rows = 3, cols = 4, spacing = 10;
        var blockWidth = (Luxe.screen.width - spacing * cols)/ cols;
        var blockHeight = (Luxe.screen.height - spacing * rows) / rows;

        for (y in 0...rows) {
            for (x in 0...cols) {
                var block = new Sprite({
                    centered: true,
                    pos: new Vector(blockWidth / 2 + x * (blockWidth + spacing), blockHeight / 2 + y * (blockHeight + spacing)),
                    size: new Vector(blockWidth, blockHeight),
                    color: Color.random(),
                });
                block.add(new EventOnClick());
                block.events.listen("clicked", playRandomSound);
            }
        }
    }

    function playRandomSound(ent:Sprite) {
        Luxe.audio.play(soundFiles[Std.random(soundFiles.length)]);
        Actuate.tween(ent.scale, 0.25, {x: 0.8, y: 0.8}).onComplete(function() Actuate.tween(ent.scale, 0.3, {x: 1, y: 1}));
    }
}
