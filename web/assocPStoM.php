<html>
    <body>
<?php
    $num_meio = $_REQUEST['num_meio'];
    $nome_entidade = $_REQUEST['nome_entidade'];
    $num_processo_socorro = $_REQUEST['num_processo_socorro'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186468";
        $password = "manuel123";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "INSERT INTO acciona values(:num_meio, :nome_entidade, :num_processo_socorro);";
        echo("<p>$sql</p>");

        $result = $db->prepare($sql);
        $result->execute([':num_meio' => $num_meio,':nome_entidade' => $nome_entidade,':num_processo_socorro' => $num_processo_socorro]);
    
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
