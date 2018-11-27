<html>
    <body>
<?php
    $nome_meio = $_REQUEST['nome_meio'];
    $num_meio = $_REQUEST['num_meio'];
    $nome_entidade= $_REQUEST['nome_entidade'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist424774";
        $password = "mv1pnmdq2Av";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "UPDATE meio SET nome_meio = :nome_meio WHERE num_meio=:num_meio and nome_entidade=:nome_entidade and :num_meio IN (SELECT num_meio FROM meiocombate) and :nome_entidade IN (SELECT nome_entidade FROM meiocombate);";
        echo("<p>$sql</p>");

        $result = $db->prepare($sql);
        $result->execute([':nome_meio' => $nome_meio,':num_meio' => $num_meio,':nome_entidade' => $nome_entidade]);
        
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
