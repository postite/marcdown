import tink.core.Promise;

typedef Opts={
   url:String
}
@:jsRequire("inline-css")
extern class InlineCSS {
      public  function new(html:String,options:Opts):Void;
      public inline function asPromise():Promise<String>{
         return Promise.ofJsPromise(cast this);
      }

      public static inline function inliner(str:String):Promise<String>{
         return new InlineCSS(str,{url:""}).asPromise();
      }
      

      
}  