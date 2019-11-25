package tests;
import utest.Assert;
class TestHost extends utest.Test{


   function testhost(){
      var p =Sys.getCwd();
      Assert.equals("e",p);
   }
}