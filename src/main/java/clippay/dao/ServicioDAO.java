package clippay.dao;

import clippay.model.Servicio;
import clippay.config.ConexionBD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServicioDAO {
    
    // Listar servicios (activos o todos)
    public List<Servicio> listarTodos(boolean soloActivos) {
        List<Servicio> servicios = new ArrayList<>();
        String sql;
        
        if (soloActivos) {
            sql = "SELECT ser_id, ser_nombre, ser_precio, ser_comision_porcentaje, ser_activo " +
                  "FROM servicios WHERE ser_activo = true ORDER BY ser_nombre";
        } else {
            sql = "SELECT ser_id, ser_nombre, ser_precio, ser_comision_porcentaje, ser_activo " +
                  "FROM servicios ORDER BY ser_nombre";
        }
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Servicio servicio = new Servicio();
                servicio.setSerId(rs.getInt("ser_id"));
                servicio.setSerNombre(rs.getString("ser_nombre"));
                servicio.setSerPrecio(rs.getDouble("ser_precio"));
                servicio.setSerComisionPorcentaje(rs.getDouble("ser_comision_porcentaje"));
                servicio.setSerActivo(rs.getBoolean("ser_activo"));
                servicios.add(servicio);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return servicios;
    }
    
    // Buscar por ID
    public Servicio buscarPorId(int serId) {
        Servicio servicio = null;
        String sql = "SELECT ser_id, ser_nombre, ser_precio, ser_comision_porcentaje, ser_activo " +
                     "FROM servicios WHERE ser_id = ?";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, serId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                servicio = new Servicio();
                servicio.setSerId(rs.getInt("ser_id"));
                servicio.setSerNombre(rs.getString("ser_nombre"));
                servicio.setSerPrecio(rs.getDouble("ser_precio"));
                servicio.setSerComisionPorcentaje(rs.getDouble("ser_comision_porcentaje"));
                servicio.setSerActivo(rs.getBoolean("ser_activo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return servicio;
    }
    
    // Verificar si existe nombre
    public boolean existeNombre(String nombre) {
        String sql = "SELECT 1 FROM servicios WHERE ser_nombre = ?";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, nombre);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Registrar nuevo servicio
    public boolean registrar(Servicio servicio) {
        String sql = "INSERT INTO servicios (ser_nombre, ser_precio, ser_comision_porcentaje) VALUES (?, ?, ?)";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, servicio.getSerNombre());
            stmt.setDouble(2, servicio.getSerPrecio());
            stmt.setDouble(3, servicio.getSerComisionPorcentaje());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Actualizar servicio
    public boolean actualizar(Servicio servicio) {
        String sql = "UPDATE servicios SET ser_nombre = ?, ser_precio = ?, ser_comision_porcentaje = ? WHERE ser_id = ?";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, servicio.getSerNombre());
            stmt.setDouble(2, servicio.getSerPrecio());
            stmt.setDouble(3, servicio.getSerComisionPorcentaje());
            stmt.setInt(4, servicio.getSerId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Desactivar servicio
    public boolean desactivar(int serId) {
        String sql = "UPDATE servicios SET ser_activo = false WHERE ser_id = ?";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, serId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Reactivar servicio
    public boolean reactivar(int serId) {
        String sql = "UPDATE servicios SET ser_activo = true WHERE ser_id = ?";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, serId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}