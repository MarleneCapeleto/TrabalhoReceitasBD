<%-- 
    Document   : index
    Created on : 28 de nov. de 2022, 22:27:08
    Author     : Marlene Capeletto
--%>

    <%@ page import="java.sql.*" %>
    <%@ page import="org.postgresql.Driver" %>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
        <head>
            <style> @import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap'); </style>
            <link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>JSP Page</title>
            <link rel="stylesheet" href="css/style.css" />
            <!-- CSS only -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
            <!-- JavaScript Bundle with Popper -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
        </head>
        <body>

            <jsp:include page="includes/navbar.jsp" />
            <jsp:include page="includes/carousel.jsp" />

            <section class="container-fluid bg-light"  class="box">
                <div class="row row-cols-1 row-cols-md-4 g-4 pt-5">
                    <%
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
                        rs = st.executeQuery("SELECT * FROM receitas ORDER BY id DESC");
                        while(rs.next()){
                            String id = rs.getString("id");
                        %>    
                        <div class="col">
                            <div class="card ">
                                <img style="width:100%;height:200px;object-fit:cover;" class="card-posisao-img" src="arquivos\<%=rs.getString("imagem")%>" class="card-img-top" alt="...">
                              <div class="card-body">
                                <h5 class="card-title font-titulo"><%=rs.getString("nome") %></h5>
                                <p class="card-text font-titulo"><%=rs.getString("descricao") %></p>
                                <hr>
                                <button class="btn btn-warning " style="width:50%;"class="font-titulo">Ver Receita</button>
                              </div>
                            </div>
                          </div>
                    <%    }
                    }catch(Exception e){
                        out.print(e);
                    }

                    %>

                  </div>
            </section>
                    

            <jsp:include page="includes/footer.jsp"  />
        </body>
    </html>