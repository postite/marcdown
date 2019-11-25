package tests;

import asys.io.File;
import utest.Assert;


import marc.Exporter;
import marc.Layouter;

using tink.CoreApi;

class TestBase extends utest.Test {

   static var sources='testsources';
   static var out='testout';

	public function testOne() {
		Assert.isTrue(1 == 1);
	}
//  @:timeout(1000)
// 	public function testMe(async:utest.Async) {
// 		var xp:Exporter = new Exporter(new Layouter());
		
// 		xp.exporteFile('one.md','./$sources','./$out')
//       .next(p -> File.getContent('./$out/one.html'))
//       .handle(z -> switch (z) {
// 			case Success(v):
// 				Assert.stringContains("html", v);
// 				Assert.stringContains("doudidou", v);
// 				async.done();
// 			case Failure(f):
// 				trace("nope");
//             async.done();
// 		});
// 	}


@:timeout(1200)
   public function testbatch(async:utest.Async)
   {
      var xp:Exporter = new Exporter(new Layouter());
		
      xp.exportebatch('./$sources','./$out')
         .next(p -> File.getContent('./$out/two.html'))
         .handle(z -> switch (z) {
			case Success(v):
				Assert.stringContains("html", v);
				Assert.stringContains("doudidou", v);
				async.done();
			case Failure(f):
				Assert.warn("paglop" + f);
            async.done();
		});
   }
@:timeout(2000)
	public function testCustomLayout(async:utest.Async){
		var layouter= new Layouter();
		layouter.addTemplateFile('./$sources/template.html');
		var xp:Exporter = new Exporter(layouter);
		xp.exporteFile('one.md','./$sources','./$out/custom.html')
      .next(p -> File.getContent('./$out/custom.html'))
      .handle(z -> switch (z) {
			case Success(v):
				Assert.stringContains("html", v);
				Assert.stringContains("doudidou", v);
				Assert.stringContains("badaboum", v);
				async.done();
			case Failure(f):
				trace("nope");
				throw (f);
            async.done();
		});
	}

		@:timeout(500)
	public function testMe2(async:utest.Async) {
		var xp:Exporter = new Exporter(new Layouter());
		xp.exportContent("##One *** $$display(three.md) __b__","me2",'./$out','./$sources')
      .next(p -> File.getContent('./$out/me2.html'))
      .handle(z -> switch (z) {
			case Success(v):
				Assert.stringContains("html", v);
				Assert.stringContains("dadad", v);
				async.done();
			case Failure(f):
				trace("nope" +f);
            async.done();
		});
	}
	
}
