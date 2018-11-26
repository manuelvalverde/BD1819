<html>
    <body>
        <h3>Add new Emergency Event</h3>
        <form action="newEE.php" method="post">
            <p><input type="hidden" name="num_telefone" value="<?=$_REQUEST['num_telefone','intante_chamada','nome_pessoa','morada_local','num_processo_socorro']?>"/></p>
            <p>Numero Telefone: <input type="text" name="num_telefone"/></p>
            <p>Instante da chamada: <input type="text" name="intante_chamada"/></p>
            <p>Nome da pessoa: <input type="text" name="nome_pessoa"/></p>
            <p>Morada Local: <input type="text" name="morada_local"/></p>
            <p>Processo de Socorro: <input type="text" name="num_processo_socorro"/></p>
            <p><input type="submit" value="Submit"/></p>
        </form>
    </body>
</html>
