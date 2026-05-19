package clippay.dao;

import clippay.config.ConexionBD;
import clippay.model.Empleado;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAO {
    
    private static final String PIN_POR_DEFECTO = "123456";
    
    // Listar todos los empleados (activos o todos según filtro)
    public List<Empleado> listarTodos(boolean soloActivos) {
        List<Empleado> empleados = new ArrayList<>();
        String sql;
        
        if (soloActivos) {
            sql = """
                SELECT e.*, u.usu_nombre, r.rol_nombre, u.usu_id
                FROM empleados e
                LEFT JOIN usuarios u ON e.emp_id = u.emp_id
                LEFT JOIN roles r ON u.rol_id = r.rol_id
                WHERE e.emp_activo = true
                ORDER BY e.emp_fregistro DESC
            """;
        } else {
            sql = """
                SELECT e.*, u.usu_nombre, r.rol_nombre, u.usu_id
                FROM empleados e
                LEFT JOIN usuarios u ON e.emp_id = u.emp_id
                LEFT JOIN roles r ON u.rol_id = r.rol_id
                ORDER BY e.emp_activo DESC, e.emp_fregistro DESC
            """;
        }
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Empleado emp = new Empleado();
                emp.setEmpId(rs.getInt("emp_id"));
                emp.setEmpDni(rs.getString("emp_dni"));
                emp.setEmpNombre(rs.getString("emp_nombre"));
                emp.setEmpApellido(rs.getString("emp_apellido"));
                emp.setEmpCorreo(rs.getString("emp_correo"));
                emp.setEmpTelefono(rs.getString("emp_telefono"));
                emp.setEmpActivo(rs.getBoolean("emp_activo"));
                emp.setEmpFregistro(rs.getDate("emp_fregistro"));
                emp.setUsuNombre(rs.getString("usu_nombre"));
                emp.setRolNombre(rs.getString("rol_nombre"));
                emp.setUsuId(rs.getInt("usu_id"));
                empleados.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return empleados;
    }
    
    // Buscar empleado por ID
    public Empleado buscarPorId(int empId) {
        String sql = """
            SELECT e.*, u.usu_nombre, r.rol_nombre, u.usu_id, u.rol_id
            FROM empleados e
            LEFT JOIN usuarios u ON e.emp_id = u.emp_id
            LEFT JOIN roles r ON u.rol_id = r.rol_id
            WHERE e.emp_id = ?
        """;
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, empId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Empleado emp = new Empleado();
                    emp.setEmpId(rs.getInt("emp_id"));
                    emp.setEmpDni(rs.getString("emp_dni"));
                    emp.setEmpNombre(rs.getString("emp_nombre"));
                    emp.setEmpApellido(rs.getString("emp_apellido"));
                    emp.setEmpCorreo(rs.getString("emp_correo"));
                    emp.setEmpTelefono(rs.getString("emp_telefono"));
                    emp.setEmpActivo(rs.getBoolean("emp_activo"));
                    emp.setEmpFregistro(rs.getDate("emp_fregistro"));
                    emp.setUsuNombre(rs.getString("usu_nombre"));
                    emp.setRolNombre(rs.getString("rol_nombre"));
                    emp.setUsuId(rs.getInt("usu_id"));
                    return emp;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Registrar nuevo empleado + usuario
    public boolean registrar(Empleado empleado, String usuNombre, int rolId, String pinPlano) {
        Connection conn = null;
        try {
            conn = ConexionBD.conectar();
            conn.setAutoCommit(false);
            
            String sqlEmpleado = """
                INSERT INTO empleados (emp_dni, emp_nombre, emp_apellido, emp_correo, emp_telefono, emp_fregistro)
                VALUES (?, ?, ?, ?, ?, CURRENT_DATE)
            """;
            PreparedStatement psEmp = conn.prepareStatement(sqlEmpleado, Statement.RETURN_GENERATED_KEYS);
            psEmp.setString(1, empleado.getEmpDni());
            psEmp.setString(2, empleado.getEmpNombre());
            psEmp.setString(3, empleado.getEmpApellido());
            psEmp.setString(4, empleado.getEmpCorreo());
            psEmp.setString(5, empleado.getEmpTelefono());
            psEmp.executeUpdate();
            
            ResultSet rs = psEmp.getGeneratedKeys();
            int empId = 0;
            if (rs.next()) {
                empId = rs.getInt(1);
            }
            psEmp.close();
            
            String hash = BCrypt.hashpw(pinPlano, BCrypt.gensalt(12));
            String sqlUsuario = """
                INSERT INTO usuarios (usu_nombre, usu_pin_hash, emp_id, rol_id)
                VALUES (?, ?, ?, ?)
            """;
            PreparedStatement psUsu = conn.prepareStatement(sqlUsuario);
            psUsu.setString(1, usuNombre);
            psUsu.setString(2, hash);
            psUsu.setInt(3, empId);
            psUsu.setInt(4, rolId);
            psUsu.executeUpdate();
            psUsu.close();
            
            conn.commit();
            return true;
            
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
    
    // Actualizar empleado
    public boolean actualizar(Empleado empleado) {
        String sql = """
            UPDATE empleados 
            SET emp_dni = ?, emp_nombre = ?, emp_apellido = ?, emp_correo = ?, emp_telefono = ?
            WHERE emp_id = ?
        """;
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, empleado.getEmpDni());
            stmt.setString(2, empleado.getEmpNombre());
            stmt.setString(3, empleado.getEmpApellido());
            stmt.setString(4, empleado.getEmpCorreo());
            stmt.setString(5, empleado.getEmpTelefono());
            stmt.setInt(6, empleado.getEmpId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Actualizar nombre de usuario
    public boolean actualizarUsuario(int usuId, String nuevoUsuNombre) {
        String sql = "UPDATE usuarios SET usu_nombre = ? WHERE usu_id = ?";
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nuevoUsuNombre);
            stmt.setInt(2, usuId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Desactivar empleado
    public boolean desactivar(int empId) {
        String sql = "UPDATE empleados SET emp_activo = false WHERE emp_id = ?";
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, empId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Reactivar empleado
    public boolean reactivar(int empId) {
        String sql = "UPDATE empleados SET emp_activo = true WHERE emp_id = ?";
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, empId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Resetear PIN a valor fijo 123456
    public boolean resetearPin(int usuId) {
        String hash = BCrypt.hashpw(PIN_POR_DEFECTO, BCrypt.gensalt(12));
        String sql = "UPDATE usuarios SET usu_pin_hash = ? WHERE usu_id = ?";
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, hash);
            stmt.setInt(2, usuId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean existeDni(String dni) {
        String sql = "SELECT 1 FROM empleados WHERE emp_dni = ?";
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, dni);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean existeUsuario(String usuNombre) {
        String sql = "SELECT 1 FROM usuarios WHERE usu_nombre = ?";
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, usuNombre);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<String> listarRoles() {
        List<String> roles = new ArrayList<>();
        String sql = "SELECT rol_nombre FROM roles WHERE rol_nombre != 'ADMIN'";
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                roles.add(rs.getString("rol_nombre"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }
    
    public int obtenerRolId(String rolNombre) {
        String sql = "SELECT rol_id FROM roles WHERE rol_nombre = ?";
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, rolNombre);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("rol_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}