<html>
    <body>
<?php
    $num_telefone = $_REQUEST['num_telefone'];
    $instante_chamada = $_REQUEST['instante_chamada'];
    $nome_pessoa = $_REQUEST['nome_pessoa'];
    $morada_local = $_REQUEST['morada_local'];
    $num_processo_socorro = $_REQUEST['num_processo_socorro'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186468";
        $password = "manuel123";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "INSERT INTO eventoemergencia values(:num_telefone,:instante_chamada,:nome_pessoa,:morada_local,:num_processo_socorro);";
        echo("<p>$sql</p>");

        $result = $db->prepare($sql);
        $result->execute([':num_telefone' => $num_telefone,':instante_chamada' => $instante_chamada,':nome_pessoa' => $nome_pessoa,':morada_local' => $morada_local,':num_processo_socorro' => $num_processo_socorro]);
        
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
