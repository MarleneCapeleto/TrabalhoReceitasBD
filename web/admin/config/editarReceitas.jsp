<%-- 
    Document   : editarReceitas
    Created on : 29 de nov. de 2022, 21:25:29
    Author     : Marlene Capeletto
--%>

<%@ page import="java.io.*" %>
<%@ page import= "java.sql.*" %>
<%@ page import= "org.postgresql.Driver" %>
<%@ page import= "util.Upload" %>

 
<%
 
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    String id = request.getParameter("id");
    String nameImg = request.getParameter("imagem");
    Upload up = new Upload();
    up.setFolderUpload("arquivos");
 
 
    if(up.formProcess(getServletContext(), request)) {
 
        String imagem = up.getFiles().get(0);
        String nome = up.getForm().get("nome").toString();
        String desc = up.getForm().get("desc").toString();
 
        String url = "jdbc:postgresql://localhost:5432/WebReceitas";
        String usuario = "postgres";
        String senhaBD = "123456";
 
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(url, usuario, senhaBD);
            st = con.createStatement();
            st.executeUpdate("UPDATE receitas set nome = '"+nome+"', descricao = '"+desc+"', imagem= '"+imagem+"' WHERE id = '"+id+"' ");
 
            File file = new File("C:\\Users\\Marlene Capeletto\\Documents\\NetBeans\\WebReceitas\\web\\admin\\arquivos\\"+nameImg);
            file.delete();
 
            response.sendRedirect("../receitas.jsp?status=2"); //Atualizado com sucesso.
        } catch (Exception e) {
            out.print(e);
        }
 
    }
 
%>
