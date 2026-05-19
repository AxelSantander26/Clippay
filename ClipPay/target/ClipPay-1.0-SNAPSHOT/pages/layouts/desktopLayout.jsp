<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="clippay.model.Usuario" %>

<%
Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
if (usuario == null) {
    return;
}
request.setAttribute("usuario", usuario);
%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="/components/sidebar.jsp" />
        
        <p>hola prueba</p>
    </body>
</html>