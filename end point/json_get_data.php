<?php

$host="sql207.epizy.com";
$user="epiz_25973763";
$password="TNVEEj5OUw";
$db="epiz_25973763_pothole";

$con=mysqli_connect($host,$user,$password,$db);

$sql="SELECT * FROM `pothole_data`;";

$result=mysqli_query($con,$sql);

$response=array();

while($row=mysqli_fetch_array($result))
{
	array_push($response,array("latitude"=>$row[0],"longitude"=>$row[1],"Ax"=>$row[2],"Ay"=>$row[3],"Az"=>$row[4],"Gx"=>$row[5],"Gy"=>$row[6],"Gz"=>$row[7]));
}

echo json_encode(array("server_response"=>$response));

mysqli_close($con);

?>