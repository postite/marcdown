package tests;





import utest.Assert;
import marc.SimpleMd;
import asys.io.File;
using tink.CoreApi;

class TestTemplate extends utest.Test {

   static var sources='testsources';
   static var outDir='testout';

   var done:Promise<String>;

   function setup(){
          done= new SimpleMd()

            //.setMd("##titre \n- un \n- deux - trois")
             .setMdFile('./sources/magRoundUp.md')
             .withLayoutFile('./postite/template.html')
             .withAssets('./assets')

            // .withData()
            .render();  
   }

   function teardown(){
      done=null;
   }

   @:timeout(1000)
   function testTemplate(async:utest.Async){

            done.next(res->{
               var out='./postite/done.html';
               File.saveContent(out,res);
               out;
               })
            .next(res->File.getContent(res))
            .next(
               r->{
                  trace( "yo");
                  Assert.stringContains("<li>",r);
                  async.done();
                  r;
               }
            ).recover(
               (f:Dynamic)->{
                  trace( "errr"+f);
                  Future.sync(f.Log());
               }
            ).handle(m->m);
  
   }
@:timeout(2000)
   function testInline(async:utest.Async){
         done.next(html->
               new InlineCSS(html, {url:'${Sys.getCwd()}/postite/'}).asPromise()
              
         ).next(
            inlinehtml->{
            Assert.stringContains("background-color",inlinehtml);
            async.done();
            inlinehtml;
            }
         ).recover(
               (f:Dynamic)->{
                  trace( "errr"+f);
                  throw(f);
                  async.done();
                  Future.sync(f);
               }
            ).handle(m->m);
         
   }


}