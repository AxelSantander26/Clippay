package clippay.dao;

import clippay.config.ConexionBD;
import clippay.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

public class UsuarioDAO {

    public Usuario login(String username, String pin) {
        Usuario usuario = null;

        // Usando la vista_login que creaste en PostgreSQL
        String sql = "SELECT * FROM vista_login WHERE usu_nombre = ?";

        try (Connection conn = ConexionBD.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            System.out.println("🔍 Buscando usuario: " + username);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashedPin = rs.getString("usu_pin_hash");
                    boolean activo = rs.getBoolean("usu_activo");
                    
                    System.out.println("📌 Hash en BD: " + hashedPin);
                    System.out.println("📌 Usuario activo: " + activo);
                    
                    if (activo && BCrypt.checkpw(pin, hashedPin)) {
                        System.out.println("✅ PIN válido - Login exitoso");
                        usuario = new Usuario();
                        usuario.setUsuId(rs.getInt("usu_id"));
                        
                        // emp_id puede ser null (para admin)
                        int empId = rs.getInt("emp_id");
                        usuario.setEmpId(rs.wasNull() ? null : empId);
                        
                        usuario.setUsuNombre(rs.getString("usu_nombre"));
                        usuario.setUsuPinHash(null);
                        usuario.setRolNombre(rs.getString("rol_nombre"));
                        usuario.setEmpNombre(rs.getString("emp_nombre"));
                        usuario.setEmpApellido(rs.getString("emp_apellido"));
                    } else {
                        System.out.println("❌ PIN incorrecto o usuario inactivo");
                    }
                } else {
                    System.out.println("❌ Usuario no encontrado: " + username);
                }
            }

        } catch (SQLException e) {
            System.err.println("❌ Error SQL en UsuarioDAO.login:");
            System.err.println("   Mensaje: " + e.getMessage());
            System.err.println("   Código: " + e.getErrorCode());
            e.printStackTrace();
        }

        return usuario;
    }
}