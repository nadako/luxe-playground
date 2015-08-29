class Macro {
    public static macro function getSoundFiles() {
        var files = sys.FileSystem.readDirectory("assets/sounds");
        return macro $v{[for (f in files) if (StringTools.endsWith(f, ".ogg")) f]};
    }
}
