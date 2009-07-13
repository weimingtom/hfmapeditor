package com.heptafish.mapeditor.utils
{
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.controls.Alert;
	
	public class HeptaFishXmlWriter extends EventDispatcher
	{
        private var _urlStr:String;
        private var _file:File;
        private var _xml:XML;
        private var _fileStream:FileStream;
        
		public function HeptaFishXmlWriter(tgareXml:XML,url:String)
		{
			_xml = new XML();
            _urlStr = File.applicationDirectory.nativePath;
            _xml = tgareXml;
            _file = new File();
            _urlStr = _urlStr.replace(/\\/g, "/");
            _file = _file.resolvePath(_urlStr + url);
            _fileStream = new FileStream();
            return;
		}
		
		 public function writeFun() : void
        {
            _fileStream.openAsync(_file, FileMode.WRITE);
            _fileStream.writeUTFBytes(_xml);
            Alert.show("文件写入成功！路径：" + _file.nativePath);
            return;
        }// end function

	}
}