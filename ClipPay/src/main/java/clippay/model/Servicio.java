package clippay.model;

public class Servicio {
    private int serId;
    private String serNombre;
    private double serPrecio;
    private double serComisionPorcentaje;
    private boolean serActivo;
    
    // Constructores
    public Servicio() {}
    
    public Servicio(int serId, String serNombre, double serPrecio, double serComisionPorcentaje, boolean serActivo) {
        this.serId = serId;
        this.serNombre = serNombre;
        this.serPrecio = serPrecio;
        this.serComisionPorcentaje = serComisionPorcentaje;
        this.serActivo = serActivo;
    }
    
    // Getters y Setters
    public int getSerId() { return serId; }
    public void setSerId(int serId) { this.serId = serId; }
    
    public String getSerNombre() { return serNombre; }
    public void setSerNombre(String serNombre) { this.serNombre = serNombre; }
    
    public double getSerPrecio() { return serPrecio; }
    public void setSerPrecio(double serPrecio) { this.serPrecio = serPrecio; }
    
    public double getSerComisionPorcentaje() { return serComisionPorcentaje; }
    public void setSerComisionPorcentaje(double serComisionPorcentaje) { this.serComisionPorcentaje = serComisionPorcentaje; }
    
    public boolean isSerActivo() { return serActivo; }
    public void setSerActivo(boolean serActivo) { this.serActivo = serActivo; }
    
    // Método para obtener nombre completo del servicio
    public String getNombreCompleto() {
        return serNombre;
    }
}