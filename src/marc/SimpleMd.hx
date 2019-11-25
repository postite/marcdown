package marc;

using haxe.io.Path;
using tink.CoreApi;
using Debug;

class SimpleMd{
   var md:Promise<String>;
   var layout:Promise<String>;
   var data:Dynamic={assetsPath:""};
   var assetsPath:String;
   public function new(){

   }
   public function setMd(md:String):SimpleMd{
      this.md=Promise.lift(md);
      return this;
   }
   public function setMdFile(path:String):SimpleMd{
      this.md=asys.io.File.getContent(path);
      return this;
   }
   public function withData(obj:Dynamic):SimpleMd{
      this.data=obj;
     
      return this;
   }
   public function withLayoutVar(f:String):SimpleMd{
      this.layout= Promise.lift(f);
      return this;
   }
   public function withLayoutFile(path:String):SimpleMd{
      this.layout=asys.io.File.getContent(path);
      return this;
   }
   public function withAssets(path:String):SimpleMd{
      this.assetsPath=path.normalize().removeTrailingSlashes();
      
      return this;
   }
   public function render():Promise<String>{
     return  md.Log().next(_md->{
         var template= new haxe.Template(_md);
         var  ex= template.execute(Debug.Log(this.data));
         
         return ex;
      })
      .next(ex->Markdown.markdownToHtml(ex))
      .next(ex->{
          if( layout != null)
       return layout.next(
            lay->{
               var template2= new haxe.Template(lay);
               return template2.execute({content:ex, assetsPath:assetsPath});
            })
            
         else
         return ex;
      }
      );
      
     
   }

   



//   new SimpleMd().setMd("kldjhfhfhdjkfhkds").withLayoutFile().withData().render();

}