﻿package com.mobile.GulfLinks{		import Box2DAS.*;	import Box2DAS.Collision.*;	import Box2DAS.Collision.Shapes.*;	import Box2DAS.Common.*;	import Box2DAS.Dynamics.*;	import Box2DAS.Dynamics.Contacts.*;	import Box2DAS.Dynamics.Joints.*;	import cmodule.Box2D.*;	import wck.*;	import gravity.*;	import misc.*;	import flash.utils.*;	import flash.events.*;	import flash.display.*;	import flash.text.*;	import flash.geom.*;	import flash.ui.*;	import caurina.transitions.*;	/**	 * Provides radial gravity.	 */	public class gravWell extends Gravity {				public var origin:V2;		public var v:V2;		public var gravY:Number = 0;		public var gravX:Number = 0;		public var throwGrav:Number = 16;				public override function create():void {			super.create();			this.visible=false;			this.base.y=0;			this.base.x=0;			listenWhileVisible(world, StepEvent.STEP, initStep, false, 15);		}				public function gravityOn():void		{			this.base.y=10;			this.base.x=1;		}				public function gravityOff():void		{			this.base.y=0;			this.base.x=0;		}				public function repulse():void{			trace("Repulse");			gravX=-throwGrav;			gravX=throwGrav;			listenWhileVisible(world, StepEvent.STEP, initStep, false, 15);			Tweener.addTween(this, {gravX:0 ,gravY:10 ,time:2, transition:"linear"});		}				/**		 * Get the gravity origin in b2World coordinates.		 */		public override function initStep(e:Event):void {			origin = V2.fromP(Util.localizePoint(world, this)).divideN(world.scale);			v = V2.rotate(base, rotation * Util.D2R); // Added so rotating can change the gravity direction.		}				/**		 * Rotate the base vector gravity based on the direction of the point to the origin.		 */		public override function gravity(p:V2, b:b2Body = null, b2:BodyShape = null):V2 {			return V2.rotate(v, (V2.subtract(p, origin)).angle() + Math.PI / 2);		}	}}