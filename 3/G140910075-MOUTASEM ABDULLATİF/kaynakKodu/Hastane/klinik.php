<?php
require("header.php")
?>

<?php
include("connect.php");

$sql = 'SELECT * from "Poliklinik"';
$res = pg_query($conn, $sql);
//print_r(pg_fetch_assoc($res));
//die();
?>

    <div class="row">
        <div class="col-md-4 center">
            <div id="#main-panel" class="panel panel-primary">
                <div class="panel-heading">
                    Randevu Aliniz
                </div>
                <div class="panel-body" style="">
                    <form action="randevu-olustur.php" method="post" class="form-horizontal">
                        <div class="form-group">
                            <label for="tc" class="control-label col-md-3"> <i class="fa fa-id-card"></i>
                                Tc</label>
                            <div class="col-md-8">
                                <input name="kimlik-no" id="tc" type="text" class="form-control" required/>
                            </div>
                        </div>
                        <div class="form-group text-left">
                            <label for="poliklinik" class="control-label col-md-3"><i
                                    class="fa fa-stethoscope"></i> Poliklinik <span
                                    class="glyphicons glyphicons-heartbeat"></span></label>
                            <div class="col-md-8">
                                <select id="poliklinik" name="poli" class="form-control"
                                        onchange="showDoctor(this.value)">
                                    <option selected disabled>bir poliklinik sec</option>
                                    <?php while ($row = pg_fetch_assoc($res)): ?>
                                        <option value="<?= $row['POL_Kodu'] ?>"><?= $row['POL_adi'] ?></option>
                                    <?php endwhile; ?>
                                </select>
                            </div>
                        </div>
                        <div class="form-group" id="doctors">

                        </div>
                        <button id="add-button"  type="submit" style="margin-left: 15px;" class="btn btn-primary">randevu al </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showDoctor(str) {
            if (str == "") {
                document.getElementById("doctors").innerHTML = "";
                return;
            } else {
                if (window.XMLHttpRequest) {
                    // code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("doctors").innerHTML = this.responseText;
                    }
                };
                xmlhttp.open("GET", "doctors.php?q=" + str, true);
                xmlhttp.send();
            }
        }
    </script>


<?php
if ($conn != null) {
    pg_close($conn);
}
?>

<?php
require("footer.php")
?>