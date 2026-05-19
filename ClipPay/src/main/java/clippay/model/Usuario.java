package clippay.model;

public class Usuario {
    private int usuId;
    private Integer empId;        // Puede ser null (para admin sin empleado)
    private String usuNombre;
    private String usuPinHash;
    private int rolId;
    private String empNombre;
    private String empApellido;
    private String rolNombre;

    public Usuario() {
    }

    public Usuario(int usuId, Integer empId, String usuNombre, String usuPinHash, 
                   int rolId, String empNombre, String empApellido, String rolNombre) {
        this.usuId = usuId;
        this.empId = empId;
        this.usuNombre = usuNombre;
        this.usuPinHash = usuPinHash;
        this.rolId = rolId;
        this.empNombre = empNombre;
        this.empApellido = empApellido;
        this.rolNombre = rolNombre;
    }

    // Getters y Setters
    public int getUsuId() { return usuId; }
    public void setUsuId(int usuId) { this.usuId = usuId; }

    public Integer getEmpId() { return empId; }
    public void setEmpId(Integer empId) { this.empId = empId; }

    public String getUsuNombre() { return usuNombre; }
    public void setUsuNombre(String usuNombre) { this.usuNombre = usuNombre; }

    public String getUsuPinHash() { return usuPinHash; }
    public void setUsuPinHash(String usuPinHash) { this.usuPinHash = usuPinHash; }

    public int getRolId() { return rolId; }
    public void setRolId(int rolId) { this.rolId = rolId; }

    public String getEmpNombre() { return empNombre; }
    public void setEmpNombre(String empNombre) { this.empNombre = empNombre; }

    public String getEmpApellido() { return empApellido; }
    public void setEmpApellido(String empApellido) { this.empApellido = empApellido; }

    public String getRolNombre() { return rolNombre; }
    public void setRolNombre(String rolNombre) { this.rolNombre = rolNombre; }
    
    // Método útil para obtener nombre completo
    public String getNombreCompleto() {
        if (empNombre != null && empApellido != null) {
            return empNombre + " " + empApellido;
        }
        return usuNombre; // Para el admin que no tiene empleado
    }
}