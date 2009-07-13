package com.heptafish.mapeditor.items
{
	import com.heptaFish.common.display.impl.HeptaFishBitMapMC;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class Exit extends HeptaFishBitMapMC
	{
		
		private var _nextX:Number;
		private var _nextY:Number;
		private var _nextMap:String;
		private var _nextInfo:String;
		
		private var _configXML:XML;
		
		public function Exit(pic:Bitmap = null,row:int = 1,col:int = 1,beginIndex:int=0,endIndex:int=0,playDirection:int = 0,nowx:int = 0 ,nowy:int = 0,speed:Number = 0.27777,total:* = null,cx:Number = -1 , cy:Number = -1)
		{
			super(pic,row,col,beginIndex,endIndex,playDirection,nowx,nowy,speed,total,cx,cy);
		}
		
		
		public function set nextX(nextX:Number):void{
			this._nextX = nextX;
		}
		
		public function get nextX():Number{
			return _nextX;
		}
		
		public function set nextY(nextY:Number):void{
			this._nextY = nextY;
		}
		
		public function get nextY():Number{
			return _nextY;
		}
		
		public function set nextMap(nextMap:String):void{
			this._nextMap = nextMap;
		}
		
		public function get nextMap():String{
			return _nextMap;
		}
		
		public function set nextInfo(nextInfo:String):void{
			this._nextInfo = nextInfo;
		}
		
		public function get nextInfo():String{
			return _nextInfo;
		}
		
		public function set configXML(configXML:XML):void{
			this._configXML = configXML;
		}
		
		public function get configXML():XML{
			return _configXML;
		}
//		
//		public static function getByXml(xml:XML,bitMapData:BitmapData):Exit{
//			
//			
//			
//			
//			var exit:Exit = new Exit(
//			
//		}


	}
}