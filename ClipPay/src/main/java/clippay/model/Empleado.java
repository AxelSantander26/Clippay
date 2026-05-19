package clippay.model;

import java.sql.Date;

public class Empleado {
    private int empId;
    private String empDni;
    private String empNombre;
    private String empApellido;
    private String empCorreo;
    private String empTelefono;
    private boolean empActivo;
    private Date empFregistro;
    
    // Datos del usuario asociado (para mostrar en listado)
    private String usuNombre;
    private String rolNombre;
    private int usuId;
    
    // Constructores
    public Empleado() {}
    
    public Empleado(int empId, String empDni, String empNombre, String empApellido, 
                    String empCorreo, String empTelefono, boolean empActivo, Date empFregistro) {
        this.empId = empId;
        this.empDni = empDni;
        this.empNombre = empNombre;
        this.empApellido = empApellido;
        this.empCorreo = empCorreo;
        this.empTelefono = empTelefono;
        this.empActivo = empActivo;
        this.empFregistro = empFregistro;
    }
    
    // Getters y Setters
    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }
    
    public String getEmpDni() { return empDni; }
    public void setEmpDni(String empDni) { this.empDni = empDni; }
    
    public String getEmpNombre() { return empNombre; }
    public void setEmpNombre(String empNombre) { this.empNombre = empNombre; }
    
    public String getEmpApellido() { return empApellido; }
    public void setEmpApellido(String empApellido) { this.empApellido = empApellido; }
    
    public String getEmpCorreo() { return empCorreo; }
    public void setEmpCorreo(String empCorreo) { this.empCorreo = empCorreo; }
    
    public String getEmpTelefono() { return empTelefono; }
    public void setEmpTelefono(String empTelefono) { this.empTelefono = empTelefono; }
    
    public boolean isEmpActivo() { return empActivo; }
    public void setEmpActivo(boolean empActivo) { this.empActivo = empActivo; }
    
    public Date getEmpFregistro() { return empFregistro; }
    public void setEmpFregistro(Date empFregistro) { this.empFregistro = empFregistro; }
    
    public String getUsuNombre() { return usuNombre; }
    public void setUsuNombre(String usuNombre) { this.usuNombre = usuNombre; }
    
    public String getRolNombre() { return rolNombre; }
    public void setRolNombre(String rolNombre) { this.rolNombre = rolNombre; }
    
    public int getUsuId() { return usuId; }
    public void setUsuId(int usuId) { this.usuId = usuId; }
    
    // Método útil
    public String getNombreCompleto() {
        return empNombre + " " + empApellido;
    }
}