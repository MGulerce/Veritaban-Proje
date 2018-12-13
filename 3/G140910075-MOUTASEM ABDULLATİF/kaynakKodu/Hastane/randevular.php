<?php
require("header.php")
?>

<?php

include("connect.php");

$kimlik = $_POST['kimlik-no'];

$sql = "SELECT * from randevu_goruntule('$kimlik');";
$res = pg_query($conn, $sql);
//
//print_r(pg_fetch_assoc($res));
//die();

?>

<div class="row">
    <a class="btn btn-success pull-right" style="margin-bottom:10px;" href="klinik.php">
        Yeni Randevu
        <span class="glyphicon glyphicon-plus">
    </span>
    </a>
    <div class="text-center">
        <table class="table table-stripped table-hover">
            <thead>
            <tr class="info">
                <th>
                    Kimlik No
                </th>
                <th>
                    Ad
                </th>
                <th>
                    Soyad
                </th>
                <th>
                    Cinsiyet
                </th>
                <th>
                    Sağlık Sigorta türü
                </th>
                <th>
                    Doktor Adı
                </th>
                <th>
                    Doktor Soyadı
                </th>
                <th>
                    Muayene Yeri
                </th>
                <th>
                    Ranvdevu Durumu
                </th>
            </tr>
            </thead>
            <tbody>
            <?php while ($row = pg_fetch_assoc($res)): ?>
                <?php
                if ($row['randevu_durum'] == 'devam') {
                    $class = 'success';
                } else if ($row['randevu_durum'] == 'iptal') {
                    $class = 'danger';
                } else {
                    $class = '';
                }
                ?>
                <tr class="<?= $class ?>">
                    <td>
                        <?= $row['kimlik_no'] ?>
                    </td>
                    <td>
                        <?= $row['hasta_adi'] ?>
                    </td>
                    <td>
                        <?= $row['hasta_soyadi'] ?>
                    </td>
                    <td>
                        <?= $row['Cinsiyet'] ?>
                    </td>
                    <td>
                        <?= $row['saglikSigortaTuru'] ?>
                    </td>
                    <td>
                        <?= $row['doktor_adi'] ?>
                    </td>
                    <td>
                        <?= $row['doktor_soyadi'] ?>
                    </td>
                    <td>
                        <?= $row['muayene_yeri'] ?>
                    </td>
                    <td>
                        <?= $row['randevu_durum'] ?>
                        <?php if ($row['randevu_durum'] == 'devam')
                            echo '<a href="randevu-iptal.php?no='.$row['randevu_no'].'&kimlik='.$row['kimlik_no'].'">
                                    <span class="label label-danger">
                                         Iptal
                                    </span>
                                 </a>';
                        ?>
                    </td>
                </tr>

            <?php endwhile; ?>
            </tbody>
        </table>
    </div>
</div>
<?php
require("footer.php")
?>

