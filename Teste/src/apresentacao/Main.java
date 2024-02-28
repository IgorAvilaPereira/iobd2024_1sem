/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package apresentacao;

import java.sql.*;
/**
 *
 * @author iapereira
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws SQLException {
        // TODO code application logic here
        
        String username = "postgres";
        String host = "localhost";
        String password = "postgres";
        String dbname = "instapoble";
        String port = "5432";
        
        String url = "jdbc:postgresql://"+host+":"+port+"/"+dbname;
        Connection conexao = DriverManager.getConnection(url, username, password);
        
        String comentario = "Meu comentario";
        
        String insertSQL = "INSERT INTO comentario (publicacao_id, conta_id, texto) values\n" +
"(2, 3, '"+comentario+"');";
        
        conexao.prepareStatement(insertSQL).execute();
        
    }
    
}
