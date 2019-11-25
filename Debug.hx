class Debug{
   public static function Log<T>(val:T,?msg:String="",? pos:haxe.PosInfos):T{
    trace('${pos.className} ${pos.lineNumber} $msg',val);
    return val;
  }
}