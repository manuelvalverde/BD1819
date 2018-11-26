<html>
    <body>
        <h3>Add new Local <?=$_REQUEST['morada_local']?></h3>
        <form action="newLocal.php" method="post">
            <p><input type="hidden" name="morada_local" value="<?=$_REQUEST['morada_local']?>"/></p>
            <p>New Local: <input type="text" name="local"/></p>
            <p><input type="submit" value="Submit"/></p>
        </form>
    </body>
</html>
