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
    
        echo("<p>Insert</p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"addLocal.php\">Add Local</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"addEE.php\">Add Emergency Event</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"addPS.php\">Add Aid Process</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"addMeios.php\">Add Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"addMC.php\">Add Combat Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"addMA.php\">Add Support Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"addMS.php\">Add Aid Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"addEntity.php\">Add Entity</a></p>");
        
        echo("<p>Remove</p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"removeLocal.php\">Remove Local</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"remmoveEE.php\">Remove Emergency Event</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"removePS.php\">Remove Aid Process</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"removeMeios.php\">Remove Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"removeMC.php\">Remove Combat Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"removeMA.php\">Remove Support Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"removeMS.php\">Remove Aid Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"removeEntity.php\">Remove Entity</a></p>");
        
        echo("<p>Edit</p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"editMC.php\">Edit Combat Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"editMA.php\">Edit Support Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"editMS.php\">Edit Aid Vehicles</a></p>");
        
        echo("<p>List</p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"listPS.php\">List Aid Processes</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"listMeios.php\">List Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"listMofPS.php\">List Vehicles of a Aid Process</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"listLocal.php\">List Aid Vehicles on a Local</a></p>");
        
        echo("<p>Associate</p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"assPSMeios.php\">Associate Aid Processes to Vehicles</a></p>");
        echo("<p style=\"text-indent: 1.5em\"><a href=\"assPSEE.php\">Associate Aid Processes to Emergency Events</a></p>");
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
        
