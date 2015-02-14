<?php

if( isset($argv[1]) )
{
	require('servicespark/app/Config/database.php');
	$db = new DATABASE_CONFIG();
	echo $db->default[ $argv[1] ];
}

exit;