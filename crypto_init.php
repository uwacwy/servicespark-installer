<?php

$randNumberLength = 48;  // length of your giant random number
$cipherSeed = "";

for ($i = 0; $i < $randNumberLength; $i++)
{
    $cipherSeed .= rand(0, 9);  // add random number to growing giant random number
}

$hash = microtime();
$start = microtime();

for($i = 0; $i < 20000; $i++)
{
	$hash = md5($hash . $cipherSeed);
}

echo sprintf("Configure::write(\"Security.salt\", '%s');", $hash);
echo "\n";
echo sprintf("Configure::write(\"Security.cipherSeed\", '%s');", $cipherSeed);