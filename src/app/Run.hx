package app;

import tink.Anon;
import haxe.Template;
import asys.FileSystem;
import asys.io.FileSeek;
import asys.io.File;
using haxe.io.Path;
using tink.CoreApi;
import tink.Anon.*;

import marc.Exporter;
import  marc.Layouter;

class Run {
	function new() {
		var xp:Exporter = new Exporter(new Layouter());
        trace( "hello");

        new Layouter();
		xp.exporteFile('OJ.md','./sources')
        .recover(r->{
            trace("oups"+r);
            return Future.sync(Noise);
        })
         .handle(z -> {
             trace("oui");
         });

        
	}
    static public function main():Void
    {
       new Run();
    }
}






