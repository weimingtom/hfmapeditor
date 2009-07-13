package com.heptafish.mapeditor.events
{
	import flash.events.Event;
	
	public class MapEditorEvent extends Event
	{
		public static const NEWMAPINFO_SUBMIT:String = "new_map_info_submit";//新地图信息提交
		public static const NEW_IMAGELIB_SUBMIT:String = "new_imageLib_submit";//新目录信息提交
		public static const EDIT_BUILD_SUBMIT:String = "edit_build_submit";//编辑建筑
		public static const NEW_EXIT_SUBMIT:String = "new_exit_submit";//新的出口
		
		
		private var _mapName:String;
		private var _mapWidth:Number;
		private var _mapHeight:Number;
		private var _cellWidth:Number;
		private var _cellHeight:Number;
		private var _mapImageFilePath:String;
		private var _newName:String;
		private var _buildXml:XML;
		private var _loadType:String;
		private var _sliceWidth:Number;
		private var _sliceHeight:Number;
		private var _preloadX:Number;
		private var _preloadY:Number;
		
		public var _parObj:Object;
		
		public function MapEditorEvent(type:String = null,bubbles:Boolean = false,cancelAble:Boolean = false)
		{
			var eventType:String = type||NEWMAPINFO_SUBMIT;
			super(type,bubbles,cancelAble);
		}
		
		public function get mapName():String{
			return _mapName;
		}
		
		public function set mapName(mapName:String):void{
			_mapName = mapName; 
		}
		
		public function get mapWidth():Number{
			return _mapWidth;
		}
		
		public function set mapWidth(mapWidth:Number):void{
			_mapWidth = mapWidth; 
		}
		
		public function get mapHeight():Number{
			return _mapHeight;
		}
		
		public function set mapHeight(mapHeight:Number):void{
			_mapHeight = mapHeight; 
		}
		
		public function get cellWidth():Number{
			return _cellWidth;
		}
		
		public function set cellWidth(cellWidth:Number):void{
			_cellWidth = cellWidth; 
		}
		
		public function get cellHeight():Number{
			return _cellHeight;
		}
		
		public function set cellHeight(cellHeight:Number):void{
			_cellHeight = cellHeight; 
		}
		
		public function get mapImageFilePath():String{
			return _mapImageFilePath;
		}
		
		public function set mapImageFilePath(mapImageFilePath:String):void{
			_mapImageFilePath = mapImageFilePath; 
		}
		
		public function get newName():String{
			return _newName;
		}
		
		public function set newName(newName:String):void{
			_newName = newName; 
		}
		
		public function get buildXml():XML{
			return _buildXml;
		}
		
		public function set buildXml(buildXml:XML):void{
			_buildXml = buildXml; 
		}
		
		public function get loadType():String{
			return _loadType;
		}
		
		public function set loadType(loadType:String):void{
			_loadType = loadType; 
		}
		
		
		
		public function get sliceWidth():Number{
			return _sliceWidth;
		}
		
		public function set sliceWidth(sliceWidth:Number):void{
			_sliceWidth = sliceWidth; 
		}
		
		
		public function get sliceHeight():Number{
			return _sliceHeight;
		}
		
		public function set sliceHeight(sliceHeight:Number):void{
			_sliceHeight = sliceHeight; 
		}
		
		public function get preloadX():Number{
			return _preloadX;
		}
		
		public function set preloadX(preloadX:Number):void{
			_preloadX = preloadX; 
		}
		
		public function get preloadY():Number{
			return _preloadX;
		}
		
		public function set preloadY(preloadY:Number):void{
			_preloadY = preloadY; 
		}
		
		
		

	}
}