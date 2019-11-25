package tests;



import utest.Assert;
import marc.SimpleMd;

using tink.CoreApi;

class TestSimpleMd extends utest.Test {

   static var sources='testsources';
   static var out='testout';

   @:timeout(1000)
   function testSimple(async:utest.Async){

       var exp=  new SimpleMd()
            .setMd("##titre \n- un \n- deux - trois")
            // .withLayoutFile()
            // .withData()
            .render().next(
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

   

}