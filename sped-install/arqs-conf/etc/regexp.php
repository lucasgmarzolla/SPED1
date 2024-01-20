#!/usr/bin/php -q
<?php
	global $argv;
	$pass = $argv[1];
	echo ereg_replace ("/", "\/", $pass);
?>
