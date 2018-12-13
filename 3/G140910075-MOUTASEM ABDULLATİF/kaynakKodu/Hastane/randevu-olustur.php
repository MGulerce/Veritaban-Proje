<?php


include ("connect.php");
$kimlik=$_POST['kimlik-no'];
$poliklinik=$_POST['poli'];
$doktor_no=$_POST['doktor'];
$sql="SELECT randevu_olustur('$kimlik','$poliklinik',$doktor_no)";

pg_query($conn,$sql);
?>

<form id="kimlik" method="post" action="randevular.php">
    <input type="hidden" name="kimlik-no" value="<?=$kimlik?>"/>
</form>

<script src="js/jquery-3.1.0.js"></script>
<script>
    $(function() {
        $('#kimlik').delay(10000).submit();
    });
</script>
