<html>
    <body>
        <h3>List Aid Vehicles of Local</h3>
        <?php
            $morada_local = $_REQUEST['morada_local'];
            try
            {
                $host = "db.ist.utl.pt";
                $port=5432;
                $user ="ist186468";
                $password = "manuel123";
                $dbname = $user;
	
                $connection = pg_connect("host=$host port=$port user=$user password=$password dbname=$dbname") or die(pg_last_error());
                
                $sql = "SELECT num_meio, nome_entidade, nome_meio FROM transporta NATURAL JOIN meio NATURAL JOIN eventoemergencia Where morada_local = '$morada_local';";
                
                $result = pg_query($sql) or die('ERROR: ' . pg_last_error());
                
                echo('<table border="5">');
                echo("<tr><td>Number of Vehicle</td><td>Name of Entity</td><td>Name of Vehicle</td></tr>");
                while ($row = pg_fetch_assoc($result))
                {
                    echo("<tr><td>");
                    echo($row["num_meio"]);
                    echo("</td><td>");
                    echo($row["nome_entidade"]);
                    echo("</td><td>");
                    echo($row["nome_meio"]);
                    echo("</td></tr>");
                }
                echo("</table>");
                    
                $result = pg_free_result($result) or die('ERROR: ' . pg_last_error());
                
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
