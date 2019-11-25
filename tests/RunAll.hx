package tests;
import utest.ui.Report;
import utest.Runner;

class RunAll{
  public function new(){
  }
  static function main() {

    
      var run = new Runner();
      run.addCase(new TestHost());
      // run.addCase(new TestBase());
      // run.addCase(new TestSimpleMd());
      // run.addCase(new TestMarkdown());
      // run.addCase(new TestTemplate());
       run.addCase(new TestTemplate());
      
  // new utest.ui.text.PrintReport(run); 
   
      Report.create(run);
     run.run();
  }
}
