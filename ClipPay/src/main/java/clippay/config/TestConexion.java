package clippay.config;

import java.sql.Connection;
import java.sql.SQLException;

public class TestConexion {

    public static void main(String[] args) {
        try {
            Connection con = ConexionBD.conectar();

            if (con != null && !con.isClosed()) {
                System.out.println("Conexión exitosa a PostgreSQL");
                con.close();
            } else {
                System.out.println("Error en la conexión");
            }

        } catch (SQLException e) {
            System.out.println("Falló la conexión:");
            e.printStackTrace();
        }
    }
}