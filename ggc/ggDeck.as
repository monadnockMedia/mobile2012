﻿package com.mobile.ggc {	import com.nestor.tools.aUtil;	import flash.system.System;	import flash.events.EventDispatcher;	//Decks for each player keep track of player's hand, discard, and draw deck.	//Methods for dealer to draw	public class ggDeck extends EventDispatcher {		private var numCards:Number;				//cards per deck		private var table:String;					//name of DB table		private var path:String;					//relative path to db file		private var playerDecks:Object = {};		//contains arrays of id's by playername		private var util:aUtil = new aUtil;			//util to shuffle arrays		private var dbc:DBConnection = new DBConnection();			private var currentCards:Array; 			//buffer the pulled cards until a choice is made by player and relayed by dealer				//Set this first		public function set config(cfg:XML):void		{			numCards = Number(cfg.numCards);			table = cfg.db.@table.toString();			path = cfg.db.@path.toString();						System.disposeXML(cfg);			cfg = null;						dbc.filePath = path;			openDB();		}				//Set this second		//takes an object containing names and IDs of all players, generates shuffled idDecks.		public function set players(p:Object):void		{			for each (var o:Object in p)			{				var playerName:String =  o.name;				var deckSet:Object = {};									deckSet.name = playerName;					deckSet.deck = buildDeck(numCards);					deckSet.discard = new Array();					deckSet.hand = new Array();										playerDecks[playerName] = deckSet;							}			deckSet = null;			dbc.players = p;		}				//Draw top card according to player name		public function drawTwo(p:String):void		{			checkDeck(p);			dbc.addEventListener(DBConnectionEvent.DB_RETURN, dbReturnHandler);			//remove top two card IDs from deck and place it in hand						var cardNum:Number = playerDecks[p].deck.shift();			playerDecks[p].hand.push(cardNum);			cardNum = playerDecks[p].deck.shift();			playerDecks[p].hand.push(cardNum);						dbc.pull(table,p,playerDecks[p].hand);				}						//dealer cals when player makes a choice (right place for this????)		public function 								//place card *from hand* to bottom of deck		private function drop(p:String, card:Number):void		{			playerDecks[p].deck.push(card);		}				//move cards *from hand* to discard pile		private function discard(p:String, card:Number):void		{			playerDecks[p].discard.push(card);		}				private function checkDeck(p:String):void		{			(playerDecks[p].deck.length > 1) ? null : resetDeck(p) ;		}						//called when DB returns pulled card		private function dbReturnHandler(d:DBConnectionEvent):void		{			dispatchEvent(new DeckEvent(DeckEvent.PULLED, false, false, buildChoiceCards(d.data)));		}				private function buildChoiceCards(d:*):Array		{			//store current cards in order to create various views when player choice is made.			currentCards = d;						//create views containing only necessary info on two cards drawn.			var ret:Array = new Array();			for each (var o:Object in currentCards)			{				var card:Object = {};				card.Body = o.Body;				card.Topic = o.Topic;				card.DeckId = o.DeckId;				ret.push(card);			}			return ret;					}						//Builds a stack of ids, which can be treated as a "deck" to reference the DB.		private function buildDeck(n:Number):Array		{			var deck:Array = new Array;			//Deck must be 1-indexed!!			for (var i:Number = 1; i<=n; i++)			{				deck.push(i);			}			deck = shuffleDeck(deck);			return deck;		}		//resets deck, don't use in middle of turn.		private function resetDeck(p:String):void{			playerDecks[p].deck = buildDeck(numCards);			playerDecks[p].discard = new Array();			playerDecks[p].hand = new Array();		}						public function openDB() {						dbc.addEventListener(DBConnectionEvent.DB_OPEN, dbOpenHandler);			dbc.openConn()		}				private function dbOpenHandler(d:DBConnectionEvent):void		{			dbc.removeEventListener(DBConnectionEvent.DB_OPEN, dbOpenHandler);		}		//shuffle the deck		private function shuffleDeck(a:Array):Array		{			return util.shuffle(a);		}	}	}