<?php
$numero[0]= "1"; 
$numero[1]= "2"; 
$numero[2]= "3"; 

$get= count($numero)-1; 
$aleatoreo= rand(0,$get); 
echo $numero[$aleatoreo]; 
?>