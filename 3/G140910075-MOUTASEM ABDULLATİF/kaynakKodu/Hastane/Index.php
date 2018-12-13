<?php
require("header.php")
?>

<div class="row">

    <div class="col-md-4"></div>
    <div class="col-md-4 ">
        <div id="#main-panel" class="panel panel-primary">
            <div class="panel-heading">
                Randevulari listelemek icin TC nizi giriniz
            </div>
            <div class="panel-body">
                <form action="randevular.php" class="form-inline" method="post">
                    <div class="form-group">
                        <input id="tc" name="kimlik-no" type="text" class="form-control" placeholder="Tc giriniz" required="required">
                    </div>
                    <button id="add-button" type="submit" class="btn btn-primary col-md-offset-2">ilerle</button>
                </form>
            </div>
        </div>
    </div>
    <div class="col-md-4"></div>
</div>

<?php
require("footer.php")
?>

