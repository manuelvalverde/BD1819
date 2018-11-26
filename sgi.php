<html>
    <body>
    <h3>Menu</h3>
<?php
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186468";
        $password = "manuel123";
        $dbname = $user;
    
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        $sql = "SELECT account_number, branch_name, balance FROM account;";
    
        $result = $db->prepare($sql);
        $result->execute();
    
        echo("Insert\n");
        echo("    <a href=\"addLocal.php\">Add Local</a>\n");
        echo("    <a href=\"addEE.php\">Add Emergency Event</a>\n");
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
        
