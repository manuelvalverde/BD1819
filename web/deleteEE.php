<html>
    <body>
<?php
    $num_telefone = $_REQUEST['num_telefone'];
    $instante_chamada = $_REQUEST['instante_chamada'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186468";
        $port=5432;
        $password = "manuel123";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        
        $connection = pg_connect("host=$host port=$port user=$user password=$password dbname=$dbname") or die(pg_last_error());
        
        $sql = "SELECT num_processo_socorro FROM eventoemergencia WHERE num_telefone= '$num_telefone' and instante_chamada='$instante_chamada';";
        $result = pg_query($sql) or die('ERROR: ' . pg_last_error());
        $row = pg_fetch_assoc($result);
        $num_processo_socorro=$row["num_processo_socorro"];
        
        $sql = "SELECT COUNT(num_processo_socorro) FROM eventoemergencia WHERE num_processo_socorro='$num_processo_socorro';";
                
        $result = pg_query($sql) or die('ERROR: ' . pg_last_error());
        $row = pg_fetch_assoc($result);
        
       
        
        $sql = "DELETE FROM eventoemergencia WHERE num_telefone=:num_telefone and instante_chamada=:instante_chamada;";
        echo("<p>$sql</p>");
        
        $result = $db->prepare($sql);
        $result->execute([':num_telefone' => $num_telefone,':instante_chamada' => $instante_chamada]);
        
        if ($row["count"]=1){
            $sql = "DELETE FROM processosocorro WHERE num_processo_socorro=:num_processo_socorro;";
            echo("<p>$sql</p>");
        
            $result = $db->prepare($sql);
            $result->execute([':num_processo_socorro' => $num_processo_socorro]);
        }
        
        pg_close($connection);
         
         
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
        <form action="sgi.php" method="post">
            <p><input type="submit" value="Back"/></p>
        </form>
    </body>
</html>
