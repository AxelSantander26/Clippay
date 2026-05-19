package clippay.logic;

import clippay.dto.PeriodoPreviewDTO;
import clippay.model.PeriodoPago;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class PeriodoLogic {
    
    private static final int DIA_INICIO_PRIMERA_QUINCENA = 1;
    private static final int DIAS_QUINCENA = 14;
    
    /**
     * Calcula el último día de la primera quincena
     * Ejemplo: inicio=1 → fin=14, inicio=15 → fin=último día del mes
     */
    public static LocalDate calcularFinQuincena(LocalDate inicio, YearMonth mes) {
        if (inicio.getDayOfMonth() == DIA_INICIO_PRIMERA_QUINCENA) {
            // Primera quincena: día 1 al día 14
            return LocalDate.of(mes.getYear(), mes.getMonth(), DIAS_QUINCENA);
        } else {
            // Segunda quincena: desde día 15 hasta último día del mes
            return mes.atEndOfMonth();
        }
    }
    
    /**
     * Obtiene todas las quincenas de un rango de meses
     * @param mesInicio Mes inicial (1-12)
     * @param mesFin Mes final (1-12)
     * @param anio Año
     * @param fechasExistentes Lista de fechas que ya existen (para marcar duplicados)
     * @return Lista de periodos con preview
     */
    public static List<PeriodoPreviewDTO> getPeriodosPreview(int mesInicio, int mesFin, int anio, 
                                                              List<LocalDate[]> fechasExistentes) {
        List<PeriodoPreviewDTO> periodos = new ArrayList<>();
        
        for (int mes = mesInicio; mes <= mesFin; mes++) {
            YearMonth yearMonth = YearMonth.of(anio, mes);
            String nombreMes = yearMonth.getMonth().getDisplayName(java.time.format.TextStyle.FULL, new java.util.Locale("es", "ES"));
            nombreMes = nombreMes.substring(0, 1).toUpperCase() + nombreMes.substring(1).toLowerCase();
            
            // Primera quincena (día 1 al 14)
            LocalDate inicio1 = LocalDate.of(anio, mes, 1);
            LocalDate fin1 = calcularFinQuincena(inicio1, yearMonth);
            boolean existe1 = existePeriodo(inicio1, fin1, fechasExistentes);
            
            periodos.add(new PeriodoPreviewDTO(
                "Quincena 1 - " + nombreMes + " " + anio,
                inicio1, fin1, existe1
            ));
            
            // Segunda quincena (día 15 al último día del mes)
            LocalDate inicio2 = LocalDate.of(anio, mes, 15);
            LocalDate fin2 = yearMonth.atEndOfMonth();
            
            // Solo agregar segunda quincena si el día 15 existe en el mes
            if (inicio2.isBefore(fin2) || inicio2.equals(fin2)) {
                boolean existe2 = existePeriodo(inicio2, fin2, fechasExistentes);
                periodos.add(new PeriodoPreviewDTO(
                    "Quincena 2 - " + nombreMes + " " + anio,
                    inicio2, fin2, existe2
                ));
            }
        }
        
        return periodos;
    }
    
    /**
     * Filtra solo los periodos que NO existen aún
     */
    public static List<PeriodoPreviewDTO> filtrarPeriodosNoExistentes(List<PeriodoPreviewDTO> periodos) {
        List<PeriodoPreviewDTO> nuevos = new ArrayList<>();
        for (PeriodoPreviewDTO p : periodos) {
            if (!p.isYaExiste()) {
                nuevos.add(p);
            }
        }
        return nuevos;
    }
    
    /**
     * Convierte PeriodoPreviewDTO a PeriodoPago para guardar
     */
    public static List<PeriodoPago> convertirAPeriodos(List<PeriodoPreviewDTO> previews) {
        List<PeriodoPago> periodos = new ArrayList<>();
        for (PeriodoPreviewDTO p : previews) {
            if (!p.isYaExiste()) {
                PeriodoPago periodo = new PeriodoPago();
                periodo.setPerNombre(p.getNombre());
                periodo.setPerFechaInicio(p.getFechaInicio());
                periodo.setPerFechaFin(p.getFechaFin());
                periodos.add(periodo);
            }
        }
        return periodos;
    }
    
    /**
     * Obtener años disponibles (desde 2024 hasta año actual + 1)
     */
    public static List<Integer> getAniosDisponibles() {
        List<Integer> anios = new ArrayList<>();
        int añoActual = LocalDate.now().getYear();
        for (int i = 2024; i <= añoActual + 1; i++) {
            anios.add(i);
        }
        return anios;
    }
    
    /**
     * Obtener meses disponibles (enero a diciembre)
     */
    public static List<Integer> getMesesDisponibles() {
        List<Integer> meses = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            meses.add(i);
        }
        return meses;
    }
    
    /**
     * Obtener nombre del mes en español
     */
    public static String getNombreMes(int mes) {
        String[] nombres = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", 
                            "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
        return nombres[mes - 1];
    }
    
    private static boolean existePeriodo(LocalDate inicio, LocalDate fin, List<LocalDate[]> existentes) {
        for (LocalDate[] fechas : existentes) {
            if (fechas[0].equals(inicio) && fechas[1].equals(fin)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Obtener el mes actual (para selector por defecto)
     */
    public static int getMesActual() {
        return LocalDate.now().getMonthValue();
    }
    
    /**
     * Obtener el año actual
     */
    public static int getAnioActual() {
        return LocalDate.now().getYear();
    }
    
    /**
     * Validar que mesInicio <= mesFin
     */
    public static boolean validarRangoMeses(int mesInicio, int mesFin) {
        return mesInicio <= mesFin;
    }
}