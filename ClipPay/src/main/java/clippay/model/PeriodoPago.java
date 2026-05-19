package clippay.model;

import java.time.LocalDate;

public class PeriodoPago {
    private int perId;
    private String perNombre;
    private LocalDate perFechaInicio;
    private LocalDate perFechaFin;
    private boolean perCerrado;
    private LocalDate perFechaCierre;
    private Integer perCerradoPor;
    
    // Constructores
    public PeriodoPago() {}
    
    public PeriodoPago(int perId, String perNombre, LocalDate perFechaInicio, LocalDate perFechaFin, 
                       boolean perCerrado, LocalDate perFechaCierre, Integer perCerradoPor) {
        this.perId = perId;
        this.perNombre = perNombre;
        this.perFechaInicio = perFechaInicio;
        this.perFechaFin = perFechaFin;
        this.perCerrado = perCerrado;
        this.perFechaCierre = perFechaCierre;
        this.perCerradoPor = perCerradoPor;
    }
    
    // Getters y Setters
    public int getPerId() { return perId; }
    public void setPerId(int perId) { this.perId = perId; }
    
    public String getPerNombre() { return perNombre; }
    public void setPerNombre(String perNombre) { this.perNombre = perNombre; }
    
    public LocalDate getPerFechaInicio() { return perFechaInicio; }
    public void setPerFechaInicio(LocalDate perFechaInicio) { this.perFechaInicio = perFechaInicio; }
    
    public LocalDate getPerFechaFin() { return perFechaFin; }
    public void setPerFechaFin(LocalDate perFechaFin) { this.perFechaFin = perFechaFin; }
    
    public boolean isPerCerrado() { return perCerrado; }
    public void setPerCerrado(boolean perCerrado) { this.perCerrado = perCerrado; }
    
    public LocalDate getPerFechaCierre() { return perFechaCierre; }
    public void setPerFechaCierre(LocalDate perFechaCierre) { this.perFechaCierre = perFechaCierre; }
    
    public Integer getPerCerradoPor() { return perCerradoPor; }
    public void setPerCerradoPor(Integer perCerradoPor) { this.perCerradoPor = perCerradoPor; }
    
    // Método para obtener el rango como string
    public String getRango() {
        return formatDate(perFechaInicio) + " - " + formatDate(perFechaFin);
    }
    
    private String formatDate(LocalDate date) {
        if (date == null) return "";
        return String.format("%02d/%02d/%d", date.getDayOfMonth(), date.getMonthValue(), date.getYear());
    }
}