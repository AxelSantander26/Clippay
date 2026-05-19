package clippay.dao;

import clippay.config.ConexionBD;
import clippay.model.PeriodoPago;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class PeriodoPagoDAO {
    
    private static final DateTimeFormatter DB_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    // Listar todos los periodos
    public List<PeriodoPago> listarTodos() {
        List<PeriodoPago> periodos = new ArrayList<>();
        String sql = "SELECT per_id, per_nombre, per_fecha_inicio, per_fecha_fin, " +
                     "per_cerrado, per_fecha_cierre, per_cerrado_por " +
                     "FROM periodos_pago ORDER BY per_fecha_inicio ASC";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                PeriodoPago periodo = new PeriodoPago();
                periodo.setPerId(rs.getInt("per_id"));
                periodo.setPerNombre(rs.getString("per_nombre"));
                periodo.setPerFechaInicio(rs.getDate("per_fecha_inicio").toLocalDate());
                periodo.setPerFechaFin(rs.getDate("per_fecha_fin").toLocalDate());
                periodo.setPerCerrado(rs.getBoolean("per_cerrado"));
                if (rs.getDate("per_fecha_cierre") != null) {
                    periodo.setPerFechaCierre(rs.getDate("per_fecha_cierre").toLocalDate());
                }
                periodo.setPerCerradoPor(rs.getInt("per_cerrado_por") == 0 ? null : rs.getInt("per_cerrado_por"));
                periodos.add(periodo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return periodos;
    }
    
    // Buscar por ID
    public PeriodoPago buscarPorId(int perId) {
        String sql = "SELECT per_id, per_nombre, per_fecha_inicio, per_fecha_fin, " +
                     "per_cerrado, per_fecha_cierre, per_cerrado_por " +
                     "FROM periodos_pago WHERE per_id = ?";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, perId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                PeriodoPago periodo = new PeriodoPago();
                periodo.setPerId(rs.getInt("per_id"));
                periodo.setPerNombre(rs.getString("per_nombre"));
                periodo.setPerFechaInicio(rs.getDate("per_fecha_inicio").toLocalDate());
                periodo.setPerFechaFin(rs.getDate("per_fecha_fin").toLocalDate());
                periodo.setPerCerrado(rs.getBoolean("per_cerrado"));
                if (rs.getDate("per_fecha_cierre") != null) {
                    periodo.setPerFechaCierre(rs.getDate("per_fecha_cierre").toLocalDate());
                }
                periodo.setPerCerradoPor(rs.getInt("per_cerrado_por") == 0 ? null : rs.getInt("per_cerrado_por"));
                return periodo;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Verificar si ya existe un periodo para un rango de fechas
    public boolean existePeriodoEnRango(LocalDate fechaInicio, LocalDate fechaFin) {
        String sql = "SELECT 1 FROM periodos_pago WHERE per_fecha_inicio = ? AND per_fecha_fin = ?";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDate(1, Date.valueOf(fechaInicio));
            stmt.setDate(2, Date.valueOf(fechaFin));
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Obtener fechas de periodos ya existentes (para no duplicar)
    public List<LocalDate[]> getFechasExistentes() {
        List<LocalDate[]> fechas = new ArrayList<>();
        String sql = "SELECT per_fecha_inicio, per_fecha_fin FROM periodos_pago";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                fechas.add(new LocalDate[]{
                    rs.getDate("per_fecha_inicio").toLocalDate(),
                    rs.getDate("per_fecha_fin").toLocalDate()
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fechas;
    }
    
    // Crear múltiples periodos
    public int crearPeriodos(List<PeriodoPago> periodos) {
        String sql = "INSERT INTO periodos_pago (per_nombre, per_fecha_inicio, per_fecha_fin, per_cerrado) " +
                     "VALUES (?, ?, ?, false)";
        int creados = 0;
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            conn.setAutoCommit(false);
            
            for (PeriodoPago periodo : periodos) {
                stmt.setString(1, periodo.getPerNombre());
                stmt.setDate(2, Date.valueOf(periodo.getPerFechaInicio()));
                stmt.setDate(3, Date.valueOf(periodo.getPerFechaFin()));
                stmt.addBatch();
            }
            
            int[] results = stmt.executeBatch();
            conn.commit();
            
            for (int result : results) {
                if (result > 0) creados++;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return creados;
    }
    
    // Cerrar periodo
    public boolean cerrarPeriodo(int perId, int usuId) {
        String sql = "UPDATE periodos_pago SET per_cerrado = true, per_fecha_cierre = CURRENT_DATE, per_cerrado_por = ? " +
                     "WHERE per_id = ? AND per_cerrado = false";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, usuId);
            stmt.setInt(2, perId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Verificar si se puede eliminar un periodo (no debe tener pagos asociados)
    public boolean tienePagosAsociados(int perId) {
        String sql = "SELECT 1 FROM pagos_nomina WHERE per_id = ? LIMIT 1";
        
        try (Connection conn = ConexionBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, perId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}