
<?php
if ($_FILES["file"]["error"] > 0)
  {
	  #echo "Error: " . $_FILES["file"]["error"] . "<br />";
	$webret['errorCode']= '1000';
	$webret['errorMsg'] =  $_FILES["file"]["error"];
	echo json_encode($webret);
	system("rm /tmp/EA-RSP-*.dat");

  }
else
  {
	$webret['errorCode'] = '0000';
	$webret['name'] = $_FILES["file"]["name"];
	$webret['type'] = $_FILES["file"]["type"];
	$webret['size'] = $_FILES["file"]["size"];
	$webret['tmpIn'] = $_FILES["file"]["tmp_name"];
	$webret['stored'] =  "/tmp/" . $_FILES["file"]["name"];

move_uploaded_file($_FILES["file"]["tmp_name"], "/tmp/" . $_FILES["file"]["name"]);
	echo json_encode($webret);

  }
?>
