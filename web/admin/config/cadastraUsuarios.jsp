<%-- 
    Document   : cadastraUsuarios
    Created on : 29 de nov. de 2022, 20:56:01
    Author     : Marlene Capeletto
--%>

<%@ page import= "java.sql.*" %>
<%@ page import="org.postgresql.Driver" %>

<%
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
        st.execute("Insert into usuarios(nome,email,telefone,senha)VALUES('"+nome+"', '"+email+"', '"+telefone+"', '"+senha+"') ");
        response.sendRedirect("../usuarios.jsp?status=1");
    }catch(Exception e){
        out.print(e);
    }
%>