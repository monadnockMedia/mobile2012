<?php
	 // header ("content-type: text/xml");
	
	$inc_status = require "gl_includes/globals.php";
	$all_tags = array();
	$taglist = array();


	$connection = mysql_connect($MySQL_Host, $MySQL_CliUsername, $MySQL_CliPassword) or die("Could not connect to MySQL server.");
	$db = mysql_select_db($MySQL_Database, $connection) or die("Could not select specified database ($MySQL_Database).");
	
	if($db){
		$q = "SELECT * FROM  `delicious` WHERE 1 LIMIT 0,10";
		$res= mysql_query($q,$connection);
	}
	
	$xml = new SimpleXMLElement('<delicious/>');
	$links = $xml->addChild("links");
	//$numrows = mysql_num_rows($res);
	//	print("Number of rows returned: $numrows");
	
	while ($row = mysql_fetch_object($res)){
		$i = $row->id;
		$des = addslashes($row->description);
		$url = $row->url;
		$extended = addslashes($row->extended);
		$tags = explode(" ",$row->tags);
		
		@$link = $links->addChild('link');
			
			$link->addAttribute("id","$i");
			$link->addAttribute("url","$url");
			@$description = $link->addChild("description","$des");
			@$description->addAttribute("extended","$extended");
			$tagnode = $link->addChild("tags")	;
		foreach ($tags as $tag){
			$tagnode->addChild('tag',"$tag");
			
		}
		$all_tags = array_merge($all_tags,$tags);
		
	}
	
	/*
	$meta_tags = $xml->addChild("all_tags");
	foreach ($all_tags as $tag){
		$meta_tags->addChild('tag',"$tag");
	}
	*/
	
	$taglist = array_unique($all_tags);
	/*
	
	foreach ($taglist as $tag){
		$list_tags->addChild('tag',"$tag");
	}
	*/
	$freq = array_count_values($all_tags);
	$list_tags = $xml->addChild("taglist");
	foreach ($taglist as $tag){
		$tag_node = $list_tags->addChild('tag',"$tag");
		$tag_node->addAttribute("freq",$freq[$tag]);
	}
	
	
//	print($xml->asXML());
	$dom = new DOMDocument('1.0');
	$dom->preserveWhiteSpace = false;
	$dom->formatOutput = true;
	$dom->loadXML($xml->asXML());
	echo $dom->saveXML();
//	print_r($xm)
	
	

?>


	
	
	
