#!/usr/bin/php -q
<?php
	global $argv;
	$domain = $argv[1];
	
	$array = split ('\.', $domain);
	
	$dn = '';
	$i = 0;
	foreach ($array as $part_domain)
	{
		$dn_array[$i] = "dc=$part_domain";
		$i++;
	}
	
	$dn = implode(",", $dn_array);
	
	echo $dn;
?>
