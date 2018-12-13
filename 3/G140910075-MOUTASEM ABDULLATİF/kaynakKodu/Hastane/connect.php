<?php

$db="Hastane";
$user="postgres";
$password="19911992";

$conn=pg_connect("host=localhost dbname=$db user=$user password=$password");

if(!$conn){
    die("couldn't connect to the database ");
}
?>