<html>
    <body>
        <h3>List of All Aid Processes</h3>
        <?php
            try
            {
                $host = "db.ist.utl.pt";
                $port=5432;
                $user ="ist186468";
                $password = "manuel123";
                $dbname = $user;
	
                $connection = pg_connect("host=$host port=$port user=$user password=$password dbname=$dbname") or die(pg_last_error());
                
                $sql = "SELECT * FROM processosocorro;";
                
                $result = pg_query($sql) or die('ERROR: ' . pg_last_error());
                
                echo('<table border="5">');
                echo("<tr><td>Number of Process</td></tr>");
                while ($row = pg_fetch_assoc($result))
                {
                    echo("<tr><td>");
                    echo($row["num_processo_socorro"]);
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
