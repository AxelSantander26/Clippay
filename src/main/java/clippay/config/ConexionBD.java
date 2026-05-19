package clippay.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    // true = Supabase | false = Local
    private static final boolean ONLINE = true;

    // Línea 1: Supabase | Línea 2: Local
    private static final String URL = ONLINE
        ? "jdbc:postgresql://aws-1-us-east-1.pooler.supabase.com:5432/postgres?sslmode=require"
        : "jdbc:postgresql://localhost:5432/barberia";

    // Línea 1: usuario Supabase | Línea 2: usuario Local
    private static final String USER = ONLINE
        ? "postgres.miyvhtatohecwiamlppl"
        : "postgres";

    // Línea 1: contraseña Supabase | Línea 2: contraseña Local
    private static final String PASSWORD = ONLINE
        ? "Santanderaxel159"
        : "1234";

    // Cargar driver PostgreSQL
    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Obtener conexión
    public static Connection conectar() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}