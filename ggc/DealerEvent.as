﻿package com.mobile.ggc{	import flash.events.Event;	public class DealerEvent extends Event 	{		// Event types.				public static const EVENT_DEFAULT:String = "default";		public static const CARDS_DEALT:String = "cardsDealt";		public static const DECISION_DEALT:String = "cardsDealt"; 		public var cardViews:*;				public function DealerEvent(type:String = DealerEvent.EVENT_DEFAULT, bubbles:Boolean = false, cancelable:Boolean = false, _data:* = null) 		{			cardViews = _data;			super(type, bubbles, cancelable);		} 		override public function clone():Event {			// Return a new instance of this event with the same parameters.			return new DealerEvent(type, bubbles, cancelable);		}	}}