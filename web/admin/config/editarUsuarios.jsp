<%-- 
    Document   : editarUsuarios
    Created on : 29 de nov. de 2022, 21:29:26
    Author     : Marlene Capeletto
--%>

<%@ page import= "java.sql.*" %>
<%@ page import="org.postgresql.Driver" %>

<%
    String id = request.getParameter("id");
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String telefone = request.getParameter("telefone");
    String senha = request.getParameter("senha");
    
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    
    String url = "jdbc:postgresql://localhost:5432/WebReceitas";
    String usuario = "postgres";
    String senhaBD = "123456";
    
    try{
        Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection(url,usuario,senhaBD);
        st = con.createStatement();
        st.executeUpdate("update usuarios set nome='"+nome+"', email='"+email+"', telefone='"+telefone+"', senha='"+senha+"' WHERE id='"+id+"' ");
        response.sendRedirect("../usuarios.jsp?status=2");//Registro atualizado com sucesso!
    }catch(Exception e){
        out.print(e);
    }
%>