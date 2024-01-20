#!/usr/bin/php -q
<?php
	global $argv;
	$domain = $argv[1];
	
	$array = split ('\.', $domain);
	
	echo $array[0];
?>
