package marc;

import asys.io.File;
import tink.Anon;
import haxe.Template;

using tink.CoreApi;

class Layouter implements ILayout{

      static var externe:Map<String,String>=[];
    public static var basicTemplate='<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>::titre::</title>
    <link href="kult.css" rel="stylesheet">
</head>
<body>
        ::content::
</body>
</html>
    ';

    var template:Promise<String>;

    public function new(){
        Template.globals={deg:"papapa"};
         addTemplate(basicTemplate);//default
    }

    public function addTemplateFile(path:String):Promise<String>{
        return template=File.getContent(path);
            
    }

    public function addTemplate(stringTemplate:String):Promise<String>{
        return template=Promise.lift(stringTemplate);
    }

    

    
    static var vars:Dynamic={};
    public  function addVars(content:String,vars:Dynamic):Promise<String>{
        var template = new haxe.Template(content);
        
        var output = template.execute(vars,{display:display});
       // var output = template.execute(vars);
        return output;
    }

    static var count2=0;
    static var ids=[];
    static var buffer={};

    public  function addFile(toFile:String, dir:String):Promise<String>{
        //trace(externe.get('externe$count') );
        //return Promise.lift(toFile);
        var polo:Array<Promise<String>>=[];
        trace( "esxterne="+externe);
        //
        
        //trace('id=$id' );

        for ( id in externe.keys()){
            ids.push(id.Log("id"));
            var xp=new Exporter(this).translateFile(externe.get(id),dir);
            polo.push(xp);
        }
        // var seq= Promise.inSequence(polo)
        // .next(p->{
        //     var t=[];
        //      for ( n in p){
        //     var  v=addVars(n,{});
        //      t.push(v);
        //      trace(v);
             
        //      }
        //      t;
            // })

        //return Promise.inSequence(seq)
       var seq= Promise.inSequence(polo)
       .next(
           p->{
             var t=[];
              for ( n in p){
             t.push (addVars(n,Exporter.globalVars));
              
              }
              return Promise.inSequence(t);
           }
       )
        .next(
            tab->{
                var buffed=[];
                for ( s in tab){
                    trace(s);
                   Reflect.setField(buffer,ids.shift(),s); 
                   var t=Anon.merge(buffer,Exporter.globalVars);
                   buffed.push(addVars(toFile,buffer));
                }
                
                return Promise.inSequence(buffed);
            }
        );
        return seq.next(tab->tab.pop().Log());
        // var xp=new Exporter().translateFile(externe.get(id),'./testsources');
        
        //  xp.next(p->{
        //     trace( p);
        //     addVars(p,{});
            
        //     });
        // count2=count2+1;       
        // return  xp.next(s->{
        //     //  vars={};
        //      Reflect.setField(buffer,id,s);
        //      trace(buffer);
        //     addVars(toFile,buffer);
        // });
        
        
        // trace( externe.get('externe$count2'));
        // var id='externe$count2';
        // var xp=new Exporter().translateFile(externe.get(id),'./sources');
        // xp.next(p->addVars(p,{}));
        // count2=count2+1;
        
        //  xp.next(s->{
        //     //  vars={};
        //      Reflect.setField(buffer,id,s);
        //      trace( buffer);
            
        //     addVars(toFile,buffer);
        // });

    }

    public function addLayout(data:Any):Promise<String>{
       return  template.next(

            t->{
                var template = new haxe.Template(t);
                return template.execute(data.Log());
            }
        );
    // var template = new haxe.Template(_layout);
    // var output = template.execute(data);
    // return output;
    }
    
    static var count:Int=0; 
    

    /// template function == $$display(file.md)
     function display(resolve:String->Dynamic,a:String) {

         externe.set('externe'+count,a);
         trace('display $a');
         Reflect.setField(vars,'externe'+count,a);
         //var exerp= a.substr(0,5);
         trace('::externe$count::');
         var last=count;
         count=count+1;
         return '::externe$last::';
       
    }
     function details(resolve:String->Dynamic,a:String) {
         //externe=a;
         return "::externe::";
       
    }

}