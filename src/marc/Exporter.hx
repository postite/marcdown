package marc;

import asys.FileSystem;
import asys.io.File;
using haxe.io.Path;
using tink.CoreApi;

class Exporter {
   var layouter:ILayout;
   public static var globalVars={deg:"doudidou",dog:"dadad",dig:"gttftfs"};

   //  static var dirin="./";
   //  static var dirout='./out';

	public function new(layout:ILayout) {
      this.layouter=layout;
     
   }

    public function exportebatch(dir:String,dirOut:String):Promise<Noise>{
        return asys.FileSystem.readDirectory(dir)
        .next(tab->tab.map(
            item->exporteFile(item,dir,dirOut)
        ));
    }

    public function translateFile(name:String,dir:String):Promise<String>{
        return File.getContent('$dir/$name')   
        .next(translateHtml);
    }

    public function exportContent(md:String,withName:String,dirOut:String,?dir:String):Promise<Noise>{
        return 
        translateHtml(md)
            .next(content->
                    layouter.addVars(content,globalVars)
            )
            .next(p->{
                //for ( a in 0...2)
                    return layouter.addFile(p.Log("p"),dir);
                })
            .next(content->{
            trace("content="+content);
            // Promise.lift(layouter.addLayout(content,name.withoutExtension()));
            //layouter.addTemplate({content:content,titre:withName})
            layouter.addLayout({content:content,titre:withName});
            })
            .next(saveHtml.bind(_, withName,dirOut))
            ;
    }

	public function exporteFile(name:String,dir:String,dirOut:String):Promise<Noise> {
		return File.getContent('$dir/$name')
        .next(translateHtml)
        .next(content->
            layouter.addVars(content,globalVars)
        )
        .next(p->{
        //for ( a in 0...2)
        return layouter.addFile(p,dir);
        
        })
        .next(content->{
            trace("content="+content);
            layouter.addLayout({content:content,titre:name.withoutExtension()});
        })
        .next(
            saveHtml.bind(_, name,dirOut))
        ;
	}

	function translateHtml(md:String):Promise<String>{
		return Promise.lift(Markdown.markdownToHtml(md));
	}

	public function saveHtml(content:String, name:String,dirout:String):Promise<Noise> {
        //allow bypassing name et renseigne full path 
        // like //one/two/file.html
        var out= dirout+'/'+name.withExtension("html");
        if( Path.extension(dirout) != "" )
            out=dirout;
		return File.saveContent(out, content);
	}


}