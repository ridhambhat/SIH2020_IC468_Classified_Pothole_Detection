<?php

$host="sql207.epizy.com";
$user="epiz_25973763";
$password="TNVEEj5OUw";
$db="epiz_25973763_pothole";

$con=mysqli_connect($host,$user,$password,$db);

if(!$con)
{
	die("Error in connection ".mysqli_connect_error());
}
else
{
	echo"<br><h3>Connection Success .. </h3>";
}
?>