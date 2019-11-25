package marc;
using tink.CoreApi;

interface ILayout{
   
   public function addVars(content:String,vars:Dynamic):Promise<String>;
   public function addFile(toFile:String, dir:String):Promise<String>;
   public function addLayout(data:Any):Promise<String>;
   public function addTemplateFile(path:String):Promise<String>;
   public function addTemplate(template:String):Promise<String>;

 }