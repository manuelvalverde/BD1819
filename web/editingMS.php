<html>
    <body>
<?php
    $nome_meio = $_REQUEST['nome_meio'];
    $num_meio = $_REQUEST['num_meio'];
    $nome_entidade= $_REQUEST['nome_entidade'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186468";
        $password = "manuel123";
        $port=5432;
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $connection = pg_connect("host=$host port=$port user=$user password=$password dbname=$dbname") or die(pg_last_error());
        
        $sql = "SELECT num_meio,nome_entidade FROM meiosocorro WHERE num_meio=$num_meio and nome_entidade='$nome_entidade';";
        $result = pg_query($sql) or die('ERROR: ' . pg_last_error());
        $row = pg_fetch_assoc($result);
        $num_meio_check=$row["num_meio"];
        $nome_entidade_check=$row["nome_entidade"];
        if($num_meio_check==$num_meio && $nome_entidade_check=$nome_entidade){
            $sql = "UPDATE meio SET nome_meio = :nome_meio WHERE num_meio=:num_meio and nome_entidade=:nome_entidade and :num_meio IN (SELECT num_meio FROM meiosocorro) and :nome_entidade IN (SELECT nome_entidade FROM meiosocorro);";
            
            $result = $db->prepare($sql);
            $result->execute([':nome_meio' => $nome_meio,':num_meio' => $num_meio,':nome_entidade' => $nome_entidade]);
        }else{throw new Exception("The vehicle given is not a Support vehicle");}
        echo("<p>$sql</p>");

        pg_close($connection);
        
        
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
    catch (Exception $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
        <form action="sgi.php" method="post">
            <p><input type="submit" value="Back"/></p>
        </form>
    </body>
</html>
