class Macro {
    public static macro function getSoundFiles() {
        var files = sys.FileSystem.readDirectory("assets");
        return macro $v{files.filter(function(f) return StringTools.endsWith(f, ".mp3"))};
    }
}
