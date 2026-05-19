package clippay.dto;

import java.time.LocalDate;

public class PeriodoPreviewDTO {
    private String nombre;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;
    private boolean yaExiste;
    
    public PeriodoPreviewDTO(String nombre, LocalDate fechaInicio, LocalDate fechaFin, boolean yaExiste) {
        this.nombre = nombre;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.yaExiste = yaExiste;
    }
    
    // Getters
    public String getNombre() { return nombre; }
    public LocalDate getFechaInicio() { return fechaInicio; }
    public LocalDate getFechaFin() { return fechaFin; }
    public boolean isYaExiste() { return yaExiste; }
    
    public String getRango() {
        return String.format("%02d/%02d/%d - %02d/%02d/%d",
            fechaInicio.getDayOfMonth(), fechaInicio.getMonthValue(), fechaInicio.getYear(),
            fechaFin.getDayOfMonth(), fechaFin.getMonthValue(), fechaFin.getYear());
    }
}