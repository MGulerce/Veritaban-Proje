

<?php
include ('connect.php');

$no = $_GET['no'];

$sql="SELECT randevu_iptal($no);";
pg_query($conn,$sql);

$kimlik=$_GET['kimlik'];
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

