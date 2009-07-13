package com.heptafish.mapeditor.layers
{
	import com.heptaFish.common.config.Config;
	import com.heptaFish.common.hack.HeptaFishGC;
	import com.heptaFish.common.loader.impl.ImageLoader;
	import com.heptafish.mapeditor.events.MapEditorEvent;
	import com.heptafish.mapeditor.items.Exit;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import mx.core.UIComponent;
	//地图层 图片
	public class MapLayer extends UIComponent
	{
		//图片读取器
		private var _imageLoader:ImageLoader;
		
		private var _exitArr:Array = new Array();
		
		private var _exitId:int = 0;
		
		private var _image:Bitmap;
		
		private var _exitBitMapData:BitmapData;
		
		private var _mapXml:XML;
		
		public function MapLayer()
		{
			
		}
		//读取地图图片
		public function load(mapXml:XML):void{
			_mapXml = mapXml;
			var src:String = _mapXml.@filename;
			_imageLoader = new ImageLoader();
			_imageLoader.load(src);
			_imageLoader.addEventListener(Event.COMPLETE,loadSuccess);
			
		}
		
		public function exitLoaded(evet:Event):void{
			var exitImageLoader:ImageLoader = ImageLoader(evet.target);
			exitImageLoader.removeEventListener(Event.COMPLETE,exitLoaded);
			_exitBitMapData = exitImageLoader._data;
			for each(var exit:XML in _mapXml.mapExits.mapExit){
				var exitX:Number = exit.@px;
				var exitY:Number = exit.@py;
				var nextX:Number = exit.@nextX;
				var nextY:Number = exit.@nextY;
				var nextMap:String = exit.@nextMap;
				var nextInfo:String = exit.@info;
				var exitMc:Exit = new Exit(new Bitmap(_exitBitMapData),Config.getInt("exitImageCol"),Config.getInt("exitImageRow"));
				exitMc.x = exitX;
				exitMc.y = exitY;
				exitMc.nextX = nextX;
				exitMc.nextY = nextY;
				exitMc.nextMap = nextMap;
				exitMc.nextInfo = nextInfo;
				exitMc.id = _exitId;
				exitMc.configXML = exit;
				addChild(exitMc);
				exitMc.startMove();
				_exitId++;
				_exitArr.push(exitMc);
				HeptaFishGC.gc();
			}
		}
		
		//读取成功
		public function loadSuccess(evet:Event):void{
			dispatchEvent(evet);
			_image = new Bitmap(_imageLoader._data);
			addChild(_image);
			this.width = _image.width;
			this.height = _image.height;
			_imageLoader.removeEventListener(Event.COMPLETE,loadSuccess);
		}
		
		public function addExit(evet:MapEditorEvent):void{
			var exitInfoPanel:ExitInfoPanel = ExitInfoPanel(evet.target);
			exitInfoPanel.removeEventListener(MapEditorEvent.NEW_EXIT_SUBMIT,addExit);
			var parObj:Object = evet._parObj;
			var exitX:uint = parObj.mouseX;
			var exitY:uint = parObj.mouseY;
			var exitMc:Exit = new Exit(new Bitmap(_exitBitMapData),Config.getInt("exitImageCol"),Config.getInt("exitImageRow"));
			exitMc.x = exitX;
			exitMc.y = exitY - exitMc.height/2;
			exitMc.nextX = parObj.nextX;
			exitMc.nextY = parObj.nextY;
			exitMc.nextMap = parObj.nextMap;
			exitMc.nextInfo = parObj.nextInfo;
			exitMc.id = _exitId;
			addChild(exitMc);
			exitMc.startMove();
			_exitId++;
			var exitXml:XML = <mapExit/>;
			exitXml.@nextX = parObj.nextX;
			exitXml.@nextY = parObj.nextY;
			exitXml.@nextMap = parObj.nextMap;
			exitXml.@px = exitMc.x;
			exitXml.@py = exitMc.y;
			exitXml.@info = parObj.nextInfo;
//			exitXml.@id = exitMc.id;
			exitMc.configXML = exitXml;
			_exitArr.push(exitMc);
			HeptaFishGC.gc();
		}
		
		public function removeExit(ex:Exit):void{
			removeChild(ex);
			delete _exitArr[ex.id];
		}
		
		public function get exitArr():Array{
			return _exitArr;
		}
		
		

	}
}