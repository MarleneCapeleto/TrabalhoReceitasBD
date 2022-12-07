<%@ page import="java.sql.*" %>
<%@ page import="org.postgresql.Driver" %>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <%
         String nomeUsuario = (String) session.getAttribute("NomeUsuario");
            if(nomeUsuario == null ){
                response.sendRedirect("index.jsp?erro=3");
            }
        %>
        <jsp:include page="includes/nav.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="includes/sidenav.jsp" />
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Receitas</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Cadastrar Receitas</li>
                        </ol>
                    </div>
                    <div class="container-fluid px-4">
                        <small>Formulario de cadastro de Receitas</small>
                        <form action="config/cadastraReceitas.jsp" method="POST" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label class="form-label">Nome da Receitas</label>
                                <input type="text" class="form-control" name="nome" placeholder="Nome do Receita"/> 
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Descriçao</label>
                                <input type="text" class="form-control" name="desc" placeholder="Descricao do Receita"/> 
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Imagem da Receita</label>
                                <input type="file" class="form-control" name="file[]" multiple /> 
                            </div>
                            <button type="submit" class="btn btn-primary">Cadastrar</button>
                        </form>
                    </div>
                    <div class="container-fluid px-4">
                        <hr>
                        <small>Receitas cadastrados</small>
                        <hr>
                        <table id="datatablesSimple">
                            <thead>
                                <tr>
                                    <th>id  </th>
                                    <th>Nome  </th>
                                    <th>Descrição  </th>
                                    <th>imagem  </th>
                                    <th>Açoes  </th>
                                </tr>
                            </thead>
                            <tfoot>
                                    <th>id  </th>
                                    <th>Nome  </th>
                                    <th>Descrição  </th>
                                    <th>imagem  </th>
                                    <th>Açoes  </th>
                            </tfoot>
                            <tbody>
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
                                          <tr>
                                              <td><%=rs.getString("id")%></td>
                                              <td><%=rs.getString("nome")%></td>
                                              <td><%=rs.getString("descricao")%></td>
                                              <td> <img src="../arquivos/<%=rs.getString("imagem")%>" width="50" /> </td>
                                              <td>
                                                  <a href="editarReceitas.jsp?id=<%=rs.getString("id")%>" class="text-info" ><i class="fa fa-pencil-square"></i></a>
                                                  <a href="" class="text-danger" data-bs-toggle="modal" data-bs-target="#exampleModal<% out.print(id); %>" ><i class="fa fa-trash"></i></a>
                                              </td>
                                          </tr>
                                          <!-- Modal Excluir -->
                                            <div class="modal fade" id="exampleModal<% if(id==id)out.print(id); %>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                              <div class="modal-dialog">
                                                <div class="modal-content">
                                                  <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Excluir usuario</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                  </div>
                                                  <div class="modal-body">
                                                    Tem certeza que deseja excluir <%=rs.getString("nome")%> ??
                                                  </div>
                                                  <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                                    <a href="receitas.jsp?funcao=excluir&id=<%=rs.getString(1)%>&imagem=<%=rs.getString("imagem")%>" class="btn btn-danger">Excluir</a>
                                                  </div>
                                                </div>
                                              </div>
                                            </div>
                                    <%    }
                                    }catch(Exception e){
                                        out.print(e);
                                    }
                                
                                %>
                               
                            </tbody>
                        </table>
                    </div>
                    <%
                        if(request.getParameter("funcao")!= null && request.getParameter("funcao").equals("excluir")){
                            String id = request.getParameter("id");
                            String nameImg = request.getParameter("imagem");
                            File file = new File("C:\\Users\\Marlene Capeletto\\Documentos\\NetBeans\\WebReceitas\\web\\arquivos\\"+nameImg);
                            file.delete();
                            try{
                                Class.forName("org.postgresql.Driver");
                                con = DriverManager.getConnection(url,usuario,senhaBD);
                                st = con.createStatement();
                                st.executeUpdate("DELETE from receitas WHERE id = '"+id+"' ");
                                response.sendRedirect("receitas.jsp?status=3");//Registro deletado com sucesso
                            }catch(Exception e){
                                out.println(e);
                            }
                        }
                    %>  
                </main>
              
                <jsp:include page="includes/footer.jsp" />
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>