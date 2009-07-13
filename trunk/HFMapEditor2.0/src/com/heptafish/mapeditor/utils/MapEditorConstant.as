package com.heptafish.mapeditor.utils
{
	import flash.filesystem.File;
	
	public class MapEditorConstant
	{
		public function MapEditorConstant()
		{
		}
		
		//地图格类型 空白低点 最后会根据设置 转换为相应不可移动或者可移动区域
		public static const CELL_TYPE_SPACE:int = 0;
		
		//地图格类型 路点
		public static const CELL_TYPE_ROAD:int = 1;
		//地图格类型 障碍
		public static const CELL_TYPE_HINDER:int = 2;
		//保存时将空白区域转换为路点
		public static const TYPE_SAVE_MAP_ROAD:int = 0;
		//保存时将空白区域转换为障碍
		public static const TYPE_SAVE_MAP_HINDER:int = 1;
		//地图元件库目录
		public static const COMPONENT_LIB_HOME:File  = File.documentsDirectory.resolvePath("HFMapEdit/componetLib");
		//存储主目录
		public static const LIB_HOME:File = File.documentsDirectory.resolvePath("HFMapEdit");
	}
}