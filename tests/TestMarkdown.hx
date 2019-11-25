package tests;
import utest.Assert;
class TestMarkdown extends utest.Test{


   function testLi(){

         var md="##titre \n- un \n- deux \n- trois";
         var ext=Markdown.markdownToHtml(md);
         Assert.stringContains("li",ext);


   }

   function testCheck(){

         var md="##titre \n- [x] un \n- [ ] deux \n- [x]trois";
         var ext=Markdown.markdownToHtml(md);
         trace(ext);
         Assert.stringContains("checkbox",ext);


   }



}