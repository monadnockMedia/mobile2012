﻿package  com.mobile.GulfLinks {	import Box2DAS.Common.*;		public class worldUtil {								public function randomShove(tI:delBody,shoveScale:Number = 999):void		{						var locV:V2 = new V2(tI.x, tI.y);			var forceV:V2 = V2.multiplyN(randV2(),shoveScale);			tI.b2body.ApplyForce(forceV, locV);		}				public function repel(tI:delItem, repelScale:Number = 20):void		{			var originV:V2 = new V2(0,0)			var locV:V2 = new V2(tI.x, tI.y);			var dirV:V2 = V2.subtract(originV, locV)			var forceV:V2 = V2.multiplyN(dirV,repelScale);			forceV = addRandom(forceV,10);			tI.b2body.ApplyForce(forceV, locV);		}		public function randV2():V2		{			var rand:Number  = Math.random();			rand -= 0.5;			rand *= 2;			var randX = rand;			rand = Math.random();			rand -= 0.5;			rand *= 2;			var randY = rand;			return new V2(randX,randY);		}		public function addRandom(inV:V2, scale:Number = 1):V2		{			var _x:Number = Math.random();			var _y:Number = Math.random();			inV.x+=_x*scale;			inV.y+=_y*scale;			return inV;					}	}	}