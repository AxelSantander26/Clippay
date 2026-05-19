package clippay.servlet;

import clippay.dao.PeriodoPagoDAO;
import clippay.dto.PeriodoPreviewDTO;
import clippay.logic.PeriodoLogic;
import clippay.model.PeriodoPago;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/admin/periodos")
public class PeriodosServlet extends HttpServlet {
    
    private PeriodoPagoDAO periodoDAO = new PeriodoPagoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            // Listar periodos existentes
            List<PeriodoPago> periodos = periodoDAO.listarTodos();
            request.setAttribute("periodos", periodos);
            request.getRequestDispatcher("/pages/admin/periodos/listar.jsp").forward(request, response);
            
        } else if (action.equals("nuevo")) {
            // Mostrar formulario para crear periodos
            List<Integer> anios = PeriodoLogic.getAniosDisponibles();
            List<Integer> meses = PeriodoLogic.getMesesDisponibles();
            request.setAttribute("anios", anios);
            request.setAttribute("meses", meses);
            request.setAttribute("mesActual", PeriodoLogic.getMesActual());
            request.setAttribute("anioActual", PeriodoLogic.getAnioActual());
            request.getRequestDispatcher("/pages/admin/periodos/crear.jsp").forward(request, response);
            
        } else if (action.equals("preview")) {
            // Vista previa de periodos a crear
            int mesInicio = Integer.parseInt(request.getParameter("mesInicio"));
            int mesFin = Integer.parseInt(request.getParameter("mesFin"));
            int anio = Integer.parseInt(request.getParameter("anio"));
            
            if (!PeriodoLogic.validarRangoMeses(mesInicio, mesFin)) {
                request.setAttribute("error", "El mes de inicio debe ser menor o igual al mes de fin");
                doGet(request, response);
                return;
            }
            
            List<LocalDate[]> fechasExistentes = periodoDAO.getFechasExistentes();
            List<PeriodoPreviewDTO> preview = PeriodoLogic.getPeriodosPreview(mesInicio, mesFin, anio, fechasExistentes);
            List<PeriodoPreviewDTO> nuevos = PeriodoLogic.filtrarPeriodosNoExistentes(preview);
            
            request.setAttribute("preview", preview);
            request.setAttribute("nuevos", nuevos);
            request.setAttribute("totalPrevisualizados", preview.size());
            request.setAttribute("totalNuevos", nuevos.size());
            request.setAttribute("totalExistentes", preview.size() - nuevos.size());
            request.setAttribute("mesInicio", mesInicio);
            request.setAttribute("mesFin", mesFin);
            request.setAttribute("anio", anio);
            
            request.getRequestDispatcher("/pages/admin/periodos/preview.jsp").forward(request, response);
            
        } else if (action.equals("cerrar")) {
            // Cerrar periodo
            int perId = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            Integer usuId = (Integer) session.getAttribute("usuId");
            
            if (usuId == null) {
                usuId = 1; // Usuario admin por defecto si no hay sesión
            }
            
            PeriodoPago periodo = periodoDAO.buscarPorId(perId);
            
            if (periodo.isPerCerrado()) {
                request.getSession().setAttribute("error", "El periodo ya está cerrado");
            } else {
                if (periodoDAO.cerrarPeriodo(perId, usuId)) {
                    request.getSession().setAttribute("mensaje", "Periodo \"" + periodo.getPerNombre() + "\" cerrado correctamente");
                } else {
                    request.getSession().setAttribute("error", "Error al cerrar el periodo");
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/periodos");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action.equals("crear")) {
            int mesInicio = Integer.parseInt(request.getParameter("mesInicio"));
            int mesFin = Integer.parseInt(request.getParameter("mesFin"));
            int anio = Integer.parseInt(request.getParameter("anio"));
            
            List<LocalDate[]> fechasExistentes = periodoDAO.getFechasExistentes();
            List<PeriodoPreviewDTO> preview = PeriodoLogic.getPeriodosPreview(mesInicio, mesFin, anio, fechasExistentes);
            List<PeriodoPreviewDTO> nuevos = PeriodoLogic.filtrarPeriodosNoExistentes(preview);
            
            if (nuevos.isEmpty()) {
                request.getSession().setAttribute("error", "No hay periodos nuevos para crear. Todos ya existen.");
                response.sendRedirect(request.getContextPath() + "/admin/periodos");
                return;
            }
            
            List<PeriodoPago> periodosAGuardar = PeriodoLogic.convertirAPeriodos(nuevos);
            int creados = periodoDAO.crearPeriodos(periodosAGuardar);
            
            if (creados > 0) {
                request.getSession().setAttribute("mensaje", "Se crearon " + creados + " periodos correctamente");
            } else {
                request.getSession().setAttribute("error", "Error al crear los periodos");
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/periodos");
        }
    }
}