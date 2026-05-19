package clippay.config;

import clippay.config.ConexionBD;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class TestSupabase {

    public static void main(String[] args) {

        try (Connection con = ConexionBD.conectar()) {

            System.out.println("✅ CONEXIÓN EXITOSA");

            Statement st = con.createStatement();

            // Probar tabla roles
            ResultSet rsRoles = st.executeQuery("SELECT * FROM roles");

            System.out.println("\n===== TABLA ROLES =====");

            while (rsRoles.next()) {
                System.out.println(
                        "ID: " + rsRoles.getInt(1)
                        + " | Nombre: " + rsRoles.getString(2)
                );
            }

            // Probar tabla usuarios
            ResultSet rsUsuarios = st.executeQuery("SELECT * FROM usuarios");

            System.out.println("\n===== TABLA USUARIOS =====");

            while (rsUsuarios.next()) {

                System.out.println(
                        "ID: " + rsUsuarios.getInt(1)
                        + " | Usuario: " + rsUsuarios.getString(2)
                );
            }

        } catch (Exception e) {

            System.out.println("❌ ERROR:");

            e.printStackTrace();
        }
    }
}