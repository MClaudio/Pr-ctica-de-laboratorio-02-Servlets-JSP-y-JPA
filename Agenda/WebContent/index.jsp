<%-- 
    Document   : index
    Created on : 04-may-2020, 20:44:59
    Author     : claum
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>BookContact</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://kit.fontawesome.com/e564244708.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.2.2/dist/css/uikit.min.css" />
        <link rel="stylesheet" href="public/css/icofont.min.css">
        <link rel="stylesheet" href="public/css/style.css" />
        <link rel="stylesheet" href="public/css/styles.css">
    </head>
    <body>
        <c:set var = "userId" value = "${sessionScope['userID']}" />

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
                    <c:choose>
                        <c:when test="${userId == null}">
                            <div class="item">
                                <a href="registro" class="ui primary button">Registro</a>
                            </div>
                            <div class="item">
                                <a href="login" class="ui button">Iniciar Sesion</a> 
                            </div>
                        </c:when>    
                        <c:otherwise>
                            <div class="item">
                                <a href="my-agenda" class="ui primary button">Mi perfil</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="layout-header">
            <div class="column-description">
                <h1>Book<span>Contact</span></h1>
                <div>
                    <p>Somos tu compañero de recuerdos.</p>
                    <p>Guarda tus contactos de forma segura e ilimitada!</p>
                </div>
                <c:choose>
                    <c:when test="${userId == null}">
                        <a href="registro" class="ui primary button btn-index-register">Registro</a>
                    </c:when>    
                    <c:otherwise>

                        <a href="my-agenda" class="ui primary button btn-index-register">Ver mi agenda</a>

                    </c:otherwise>
                </c:choose>
            </div>
            <div class="column-bg">
            </div>
        </div>


        <div class="header-contet">
            <div class=" header-description">
                <h2>Por que elegirnos?</h2>
                <p>Ofrecemos almacenamiento de contactos ilimitados para nuestros usuarios para conocer mas sobre nuestros planes empresariales visita los siguientes enlaces.
                </p>
                <div class="buttuns-content">
                    <a href="#">Planes</a>
                    <a href="#">Almacenamiento</a>
                    <a href="busqueda?usuario=all">Ver todos los usuarios</a>
                </div>
            </div>
        </div>

        <div class="patners">
            <div class="uk-container">
                <h3>Nuestras caracteristicas:</h3>

                <div class="slide">
                    <div class="icon">
                        <i class="fas fa-chevron-left"></i>
                    </div>
                    <div class="icon">
                        <i class="fas fa-download"></i>
                        <p>Descarga la lista de tus contactos cuando quieras y donde quieras.</p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-users"></i>
                        <p>Encuentra a las personas u organizacion que buscas y mantente informado.</p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-book"></i>
                        <p>Manten tus contactos a salvo con nosotros ofrecemos almacenamiento ilimitado.</p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-comments"></i>
                        <p>Mantense siempre conectado y al dia con la actualizacion de contactos de los usuarios conectados.</p>
                    </div>
                    <div class="icon">
                        <i class="fas fa-chevron-right"></i>
                    </div>
                </div>
            </div>

        </div>
        <div class="patners">
            <div class="uk-container">
                <h3>Nuestras Opciones:</h3>
                <div class="icons-retailer">
                    <div class="icon">
                        <i class="fas fa-cloud"></i>
                    </div>
                    <div class="icon">
                        <i class="fas fa-server"></i>
                    </div>
                    <div class="icon">
                        <i class="fas fa-address-book"></i>
                    </div>
                    <a href="#">Ver todo</a>
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

        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/uikit@3.2.2/dist/js/uikit.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/uikit@3.2.2/dist/js/uikit-icons.min.js"></script>
    </body>
</html>
