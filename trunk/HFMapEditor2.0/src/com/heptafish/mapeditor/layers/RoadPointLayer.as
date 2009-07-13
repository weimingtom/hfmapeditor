package com.heptafish.mapeditor.layers
{
	import com.heptaFish.common.map.impl.HashMap;
	import com.heptafish.mapeditor.items.Building;
	import com.heptafish.mapeditor.utils.MapEditorConstant;
	import com.heptafish.mapeditor.utils.MapEditorUtils;
	
	import flash.display.Shape;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	//路点层
	public class RoadPointLayer extends UIComponent
	{
		
		private var _tilePixelWidth:Number;
		private var _tilePixelHeight:Number;
		private var _childMap:HashMap;
		private var _gridLayer:GridLayer;
		
		public function RoadPointLayer(gridLayer:GridLayer)
		{
			_gridLayer = gridLayer;
			_childMap = new HashMap();
		}
		
		//根据类型画出单元格
		public function drawCell(xIndex:int,yIndex:int,cellType:int):void{
			
//			var oldCell = _childMap.getValue(mapKey);
//			if(oldCell!=null && oldCell.parent == this){
//				removeChild(oldCell);
//			}
			var cellColor:Number;
			if(cellType == MapEditorConstant.CELL_TYPE_ROAD){//如果是路点
				cellColor = 0x33FF33;
			}else if(cellType == MapEditorConstant.CELL_TYPE_HINDER){//如果是障碍
				cellColor = 0xFF0033;
			}else{
				throw new Error("未知单元格类型！");
			}
			var p:Point = MapEditorUtils.getPixelPoint(_tilePixelWidth,_tilePixelHeight,xIndex,yIndex);
			resetCell(xIndex,yIndex);
//			var cellContainer:Sprite = new Sprite();
			
			var cell:Shape = new Shape();
			cell.graphics.beginFill(cellColor,0.5);
			cell.graphics.drawCircle(0,0,_tilePixelHeight/4);
			cell.graphics.endFill();
			cell.x = p.x;
			cell.y = p.y;
			addChild(cell);
			var mapKey:String = xIndex + "," + yIndex;
			_childMap.put(mapKey,cell);
//			cell.graphics.drawRect(0,0,60,60);
//			var matrix:Matrix = new Matrix();
//			matrix.rotate(45*Math.PI/180);//旋转45度
//			matrix.scale(1,1/2);//高度压缩一半
//			cell.transform.matrix = matrix;
//			cellContainer.addChild(cell);
//			cellContainer.x = p.x;
//			cellContainer.y = p.y - _tilePixelHeight/2 + 1;
//			cellContainer.width = _tilePixelWidth - 2;
//			cellContainer.height = _tilePixelHeight - 2;
//			this.addChild(cellContainer);
		}
		
		//将制定单元格设置为初始状态
		public function resetCell(xIndex:int,yIndex:int):void{
			var mapKey:String = xIndex + "," + yIndex;
			var oldCell:* = _childMap.getValue(mapKey);
			if(oldCell!=null && oldCell.parent == this){
				removeChild(oldCell);
			}
		}
		
		/**
		 * 
		 * originPX, originPY	建筑物元点在地图坐标系中的像素坐标
		 * building				
		 * walkable 			是否可行走
		 */
		public function drawWalkableBuilding(building:Building, originPX:int, originPY:int, wb:Boolean):void
		{
			var walkableStr:String = building.configXml.walkable;
			var wa:Array = walkableStr.split(",");
			if (wa == null || wa.length < 2) return;
			var cellWidth:Number = this.parentApplication._cellWidth;
			var cellHeight:Number = this.parentApplication._cellHeight;
			var row:int = this.parentApplication._mapHeight/cellHeight;
			var col:int = this.parentApplication._mapWidth/cellWidth;
			var xtmp:int, ytmp:int;
			for (var i:int=0; i<wa.length; i+=2)
			{
				ytmp = originPY + int(wa[i+1]);
				xtmp = originPX + int(wa[i]);

				var pt:Point = MapEditorUtils.getCellPoint(cellWidth, cellHeight, xtmp, ytmp);
//				var ip:int = pt.y * col + pt.x;
				var tile:* = _childMap.getValue(pt.x + "," + pt.y);
				
				
				if (wb == false)		//增加阻挡
				{
					
					if (tile == null)	//如果原来不是阻挡，则画
					{
						drawCell(pt.x,pt.y,MapEditorConstant.CELL_TYPE_HINDER);
						this.parentApplication._mapArr[pt.y][pt.x] = MapEditorConstant.CELL_TYPE_HINDER;
					}
				}
				else					//删除阻挡
				{
					
					if (tile != null)	//如果原来不是阻挡
					{
						removeChild(tile);
						this.parentApplication._mapArr[pt.y][pt.x] = MapEditorConstant.CELL_TYPE_SPACE;
					}
				}
			}

		}
		//打开时 先画出原来的障碍点
		public function drawArr(arr:Array,roadType:int):void{
			for(var iy:int=0;iy < arr.length;iy++){
				for(var ix:int=0;ix < arr[0].length;ix++){
					var cell:int = arr[iy][ix];
					if(roadType == MapEditorConstant.TYPE_SAVE_MAP_HINDER){
						if(cell == 0){
							drawCell(ix,iy,MapEditorConstant.CELL_TYPE_ROAD);
						}
					}else if(roadType == MapEditorConstant.TYPE_SAVE_MAP_ROAD){
						if(cell == 1){
							drawCell(ix,iy,MapEditorConstant.CELL_TYPE_HINDER);
						}
					}
				}
			}
		}
		
		public function set cellWidth(cellWidth:Number):void{
			this._tilePixelWidth = cellWidth;
		}
		
		public function get cellWidth():Number{
			return this._tilePixelWidth;
		}

		public function set cellHeight(cellHeight:Number):void{
			this._tilePixelHeight = cellHeight;
		}
		
		public function get cellHeight():Number{
			return this._tilePixelHeight;
		}
	}
}