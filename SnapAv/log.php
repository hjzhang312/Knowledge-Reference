
<?php
$fileName = "debuglog.log";
$filePath = "/media/userdata/".$fileName;

 
$fp=fopen($filePath,"r"); 
$file_size=filesize($filePath); 

Header("Content-type: application/octet-stream"); 
Header("Accept-Ranges: bytes"); 
Header("Accept-Length:".$file_size); 
Header("Content-Disposition: attachment; filename=".$fileName); 
$buffer=1024;  
$file_count=0; 

while(!feof($fp) && $file_count<$file_size){ 
$file_con=fread($fp,$buffer); 
$file_count+=$buffer; 
echo $file_con; 
} 
fclose($fp);
 

?>
