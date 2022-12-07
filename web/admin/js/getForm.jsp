<%-- 
    Document   : getFrom
    Created on : 30 de nov. de 2022, 21:47:18
    Author     : Marlene Capeletto
--%>

<%@ page import="java.sql.*" %>
<%@ page import= "org.postgresql.Driver" %>
<%@page import="util.Upload"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    Upload up = new Upload();
    up.setFolderUpload("arquivos");
    if (up.formProcess(getServletContext(), request)) {
        //Arquivos
        String imagem = up.getFiles().get(0);
        String nome = up.getForm().get("nome").toString();
        String desc = up.getForm().get("desc").toString();
        Float valor = Float.parseFloat(up.getForm().get("valor").toString());
        String url = "jdbc:postgresql://localhost:5432/WebReceitas";
        String usuario = "postgres";
        String senhaBD = "123456";
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(url, usuario, senhaBD);
            st = con.createStatement();
            st.execute("INSERT INTO produtos(nome,descricao,valor,imagem) VALUES('" + nome + "','" + desc + "','" + valor + "','" + imagem + "') ");
            response.sendRedirect("usuarios.jsp?erro=1000");
        } catch (Exception e) {
            out.println(e);
        }
    } else {
    }
%>
<img src="../arquivos/<%=up.getFiles().get(0)%>"  />
