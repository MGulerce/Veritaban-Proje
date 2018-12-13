<?php
/**
 * Created by PhpStorm.
 * User: Moutasem
 * Date: 12/11/2016
 * Time: 12:13 AM
 */

include("connect.php");
$poli = $_GET['q'];
$sql = "SELECT * from doktorlari_sirala('$poli')";
$res = pg_query($conn, $sql);
?>

<label for="doktor" class="control-label col-md-3" ><i class="fa fa-heartbeat"></i> Doktorlar</label>
<div class="col-md-8">
    <select id="doktor" name="doktor" class="form-control">
        <?php while ($row = pg_fetch_assoc($res)) : ?>
            <option value="<?= $row['doktor_no'] ?>"><?= $row['doktor_adi'] ?></option>
        <?php endwhile; ?>
    </select>
</div>