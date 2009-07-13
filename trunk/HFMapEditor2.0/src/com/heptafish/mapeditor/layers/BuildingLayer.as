package com.heptafish.mapeditor.layers
{
	import com.heptaFish.common.loader.impl.ImageLoader;
	import com.heptafish.mapeditor.items.Building;
	import com.heptafish.mapeditor.utils.MapEditorConstant;
	import com.heptafish.mapeditor.utils.MapEditorUtils;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	
	public class BuildingLayer extends UIComponent
	{
		public var buildingArray:Array;	//所有building数组，数组索引对应building id
		private var maxNum:int = 0;		//建筑数		
		private var _roadLayer:RoadPointLayer;
		
		public function BuildingLayer(roadLayer:RoadPointLayer)
		{
			_roadLayer = roadLayer;
			buildingArray = new Array();
		}
		
		public function placeAndClone(bld:Building, /*map:Maps,*/ tilePoint:Point):Building
		{
			
			//放障碍
			this.placeSign(bld, tilePoint);
			var blXml:XML = new XML(bld.configXml.toXMLString());
			//clone
			var nbld:Building = new Building(this.maxNum);
			nbld.x = bld.x;
			nbld.y = bld.y;
			if(bld._bitMap != null){
				var blBitMap:BitmapData = bld._bitMap.bitmapData.clone();
				nbld.reset(blBitMap,blXml);
			}
			else{
				nbld.configXml = blXml;
				nbld.loadImage();
			}
			nbld.configXml.@id = maxNum;
			nbld.configXml.@px = nbld.x;
			nbld.configXml.@py = nbld.y;
			nbld.configXml.@ix = tilePoint.x;
			nbld.configXml.@iy = tilePoint.y;
			this.buildingArray[maxNum] = nbld;
			nbld = Building(this.addChild(nbld));
			this.maxNum++;
			return nbld;
		}
		
		
		private function placeSign(bld:Building, /*map:Maps,*/ tilePoint:Point):void
		{
			var tilePixelWidth:int = this.parentApplication._cellWidth;
			var tilePixelHeight:int = this.parentApplication._cellHeight;
			
			//阻挡和阴影标记
			var pt:Point = MapEditorUtils.getPixelPoint(tilePixelWidth, tilePixelHeight, tilePoint.x, tilePoint.y);
			var walkableStr:String = bld.configXml.walkable;
			if (walkableStr == null || walkableStr.length < 3) //没有阻挡设置
			{
				var xpw:int = pt.x - int(bld.configXml.@xoffset) - tilePixelWidth/2;
				var ypw:int = pt.y - int(bld.configXml.@yoffset) - tilePixelHeight/2;
		
				_roadLayer.drawWalkableBuilding(bld, xpw, ypw, false);
			}
			else  	//有阻挡信息
			{
				var wa:Array = walkableStr.split(",");
				if (wa == null || wa.length < 2) return; 	//xml错误

				// building的元点在地图坐标系中的tile坐标
				var pxt:int = pt.x - int(wa[0]) - tilePixelWidth/2;
				var pyt:int = pt.y - int(wa[1]) - tilePixelHeight/2;

				_roadLayer.drawWalkableBuilding(bld, pxt, pyt, false);
			}
		}
		//移除建筑
		public function removeBuild(bld:Building):void{
			var tilePixelWidth:int = this.parentApplication._cellWidth;
			var tilePixelHeight:int = this.parentApplication._cellHeight;
			var ct:Point = MapEditorUtils.getCellPoint(tilePixelWidth, tilePixelHeight,bld.x,bld.y);
			var pt:Point = MapEditorUtils.getPixelPoint(tilePixelWidth, tilePixelHeight, ct.x, ct.y);
			var originPX:int = pt.x - int(bld.configXml.@xoffset);// - tilePixelWidth/2;
			var originPY:int = pt.y - int(bld.configXml.@yoffset);// - tilePixelHeight/2;
			_roadLayer.drawWalkableBuilding(bld, originPX, originPY, true);
			delete buildingArray[bld.id];
			removeChild(bld);
		}
		
		//读取XML配置 放置建筑
		public function drawByXml(mapXml:XML):void{
			for each(var item:XML in mapXml.items.item){
				var bl:Building = new Building();
				var cellPoint:Point = new Point(item.@ix,item.@iy);
				bl.configXml = item;
				bl.x = item.@px;
				bl.y = item.@py;
				var nbl:Building = placeAndClone(bl,cellPoint);
//				var imageFile:File = MapEditorConstant.COMPONENT_LIB_HOME.resolvePath(item.@file[0]);
//				if(imageFile.exists){
//					var imageLoader:ImageLoader = new ImageLoader();
//					imageLoader.addEventListener(Event.COMPLETE,nbl.imageLoaded);
//					imageLoader.load(imageFile.nativePath);
//				}
			}
		}

	}
}