<%-- 
    Document   : my-agenda
    Created on : 03-may-2020, 10:18:04
    Author     : claum
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Mi cuenta</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://kit.fontawesome.com/e564244708.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="public/css/styles.css">
    </head>
    <body>
        <c:set var = "user" value = "${requestScope['user']}" />
        <c:set var = "search" value = "${applicationScope['search']}" />
        <div class="ui container">
            <div class="ui secondary  menu">
                <div class="item logo">
                    <a href="/Agenda"><h2>Book<span>Contact</span></h2></a>
                </div>

                <div class="right menu">
                    <div class="item">
                        <form action="busqueda">
                            <div class="ui left icon action input">
                                <i class="users icon"></i>
                                <input type="text" placeholder="Buscar..." name="usuario">
                                <input type="submit" class="ui blue submit button" value="Buscar">
                            </div>
                        </form>
                    </div>

                    <div class="content-btns">
                        <div class="item">
                            <a href="my-agenda?logout=true" class="ui button">Cerrar Sesion</a> 
                        </div>
                        <button type="button" class="ui primary labeled icon button" data-toggle="modal" data-target="#modalInfo">
                            <i class="user icon"></i> Editar datos
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="ui container">

            <div class="ui mt-5"> 

                <c:choose>
                    <c:when test="${user.telefonos.size() > 0}">
                        <div class="ui grid">
                            <h1 class="four wide column">Mis Telefonos</h1>

                            <form class="form-inline my-2 my-lg-0">
                                <input class="form-control mr-sm-2" type="search" placeholder="Buscar en mi agenda" aria-label="Search" required="" name="mi-telefono">
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Buscar mi telefono</button>
                            </form>
                        </div>

                        <table class="ui compact celled definition table">
                            <thead class="full-width">
                                <tr>
                                    <th>#</th>
                                    <th>Numero</th>
                                    <th>Tipo</th>
                                    <th>Operadora</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>

                                <c:set var="i" value = "${0}"/>
                                <c:forEach var="telefono" items="${user.telefonos}">
                                    <c:set var="i" value = "${i+1}"/>
                                    <tr>
                                        <td>${i}</td> 
                                        <td>${telefono.numero}</td>
                                        <td>${telefono.tipo}</td>
                                        <td>${telefono.operadora}</td>
                                        <td>

                                            <div class="modal fade" id="confirm-delete${i}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5>Eliminar numero.</h5>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p>El número ${telefono.numero} se eliminara de tu agenda.</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                                            <a href="editar-telefono?delete=true&idTelefono=${telefono.id}" class="btn btn-danger btn-ok">Eliminar</a>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="ui right floated small red labeled icon button" data-toggle="modal" data-target="#confirm-delete${i}" >
                                                <i class="trash alternate icon"></i> Eliminar
                                            </div>
                                            <div class="ui right floated small green labeled icon button" data-toggle="modal" data-target="#exampleModalCenter${i}">
                                                <i class="edit icon"></i> Editar
                                            </div>
                                        </td>
                                    </tr>
                                    <!-- Modal -->
                                <div class="modal fade" id="exampleModalCenter${i}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalCenterTitle">Numero: ${telefono.numero}</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <form action="editar-telefono" method="POST">
                                                <input type="hidden" name="idtel" value="${telefono.id}" >
                                                <div class="modal-body">
                                                    <div class="form-group">
                                                        <label for="numero">Numero</label>
                                                        <input type="text" class="form-control" id="numero" name="numero" value="${telefono.numero}" required="" pattern="[0-9]+">
                                                    </div>
                                                    <div class="form-row">
                                                        <div class="form-group col-md-6">
                                                            <label for="tipo">Tipo</label>
                                                            <input type="text" class="form-control" id="tipo" name="tipo" required="" placeholder="Movil" value="${telefono.tipo}">
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label for="operadora">Operadora</label>
                                                            <input type="text" class="form-control" id="operadora" name="operadora" required="" placeholder="Movistar" value="${telefono.operadora}">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                                                    <button type="submit" class="btn btn-primary">Guardar</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            </tbody>
                            <tfoot class="full-width">
                                <tr>
                                    <c:choose>
                                        <c:when test="${search == 'true'}">
                                            <th colspan="2">
                                                <a href="my-agenda" class="ui right floated small primary labeled icon button mt-3"><i class="arrow alternate circle left outline icon"></i> Regresar </a>
                                            </th>
                                        </c:when>   
                                        <c:otherwise>
                                            <th></th>
                                            </c:otherwise>
                                        </c:choose>
                                    <th colspan="4">
                                        <button type="button" class="ui right floated small primary labeled icon button" data-toggle="modal" data-target="#exampleModalCenter">
                                            <i class="phone icon"></i> Agregar telefono
                                        </button>
                                    </th>

                                </tr>
                            </tfoot>
                        </table>

                    </c:when>    
                    <c:otherwise>


                        <c:choose>
                            <c:when test="${search == 'true'}">
                                <h2>No hay resultados.</h2>
                                <a href="my-agenda" class="ui left floated small primary labeled icon button mt-3"><i class="arrow alternate circle left outline icon"></i> Regresar </a>
                            </c:when>    
                            <c:otherwise>
                                <h2>No hay contactos aún agrega tu primer número.</h2>
                                <button type="button" class="ui left floated small primary labeled icon button mt-3" data-toggle="modal" data-target="#exampleModalCenter">
                                    <i class="phone icon"></i> Agregar telefono
                                </button>             
                            </c:otherwise>
                        </c:choose>


                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Agregar un telefono</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="agragar-telefono" method="POST">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="numero">Numero</label>
                                <input type="text" class="form-control" id="numero" name="numero" required="" placeholder="0985632146" pattern="[0-9]+">
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="tipo">Tipo</label>
                                    <input type="text" class="form-control" id="tipo" name="tipo" required="" placeholder="Movil">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="operadora">Operadora</label>
                                    <input type="text" class="form-control" id="operadora" name="operadora" required="" placeholder="Movistar">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="modalInfo" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">${user.nombre} ${user.apellido}</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="agragar-telefono" method="POST">
                        <div class="modal-body">

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="nombre">Nombre</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" value="${user.nombre}">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="apellido">Apellido</label>
                                    <input type="text" class="form-control" id="apellido" value="${user.apellido}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cedula">Cedula</label>
                                <input type="text" class="form-control" id="cedula" value="${user.cedula}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="correo">Correo</label>
                                <input type="email" class="form-control" id="correo" value="${user.correo}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="pass">Contraseña</label>
                                <input type="password" class="form-control" id="pass" name="pass" placeholder="Contraseña">
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <footer>
            <div class="icon_footer">
                <i class="fas fa-chevron-up"></i>
            </div>
            <div class="social_foote">
                <a href="https://www.instagram.com/claudio.mldo" target="_BLANK"><i class="fab fa-instagram"></i></a>
                <a href="https://www.facebook.com/Claudio.Mldo" target="_BLANK"><i class="fab fa-facebook-square"></i></a>
                <a href="https://github.com/MClaudio" target="_BLANK"><i class="fab fa-github-square"></i></a>
            </div>
            <p>&COPY; 2020 Todos los derechos reservados | Designed By Claudio Maldonado</p>
        </footer>



        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <script src="public/js/script.js"></script>
    </body>
</html>