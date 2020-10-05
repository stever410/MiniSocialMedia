<%-- 
    Document   : header
    Created on : Sep 19, 2020, 2:07:19 PM
    Author     : ngota
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bulma.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/additional-methods.min.js" integrity="sha512-6Uv+497AWTmj/6V14BsQioPrm3kgwmK9HYIyWP+vClykX52b0zrDGP7lajZoIY1nNlX4oQuh7zsGjmF7D0VZYA==" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js" integrity="sha512-frFP3ZxLshB4CErXkPVEXnd5ingvYYtYhE5qllGdZmcOlRKNEPbufyupfdSTNmoF5ICaQNO6SenXzOZvoGkiIA==" crossorigin="anonymous"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/app.js"></script>
        <title>JSP Page</title>
    </head>
    <nav class="navbar" role="navigation" aria-label="main navigation">
        <div class="navbar-brand">
            <c:url value="MainController" var="homepageLink">
                <c:param name="action" value="load_article"/>
            </c:url>
            <a class="navbar-item" href="${pageScope.homepageLink}">
                <img src="${pageContext.request.contextPath}/img/instagram-logo.png">
            </a>
            <a role="button" class="navbar-burger" data-target="navMenu" aria-label="menu" aria-expanded="false">
                <span aria-hidden="true"></span>
                <span aria-hidden="true"></span>
                <span aria-hidden="true"></span>
            </a>
        </div>
        <div class="navbar-menu" id="navMenu">
            <div class="navbar-start">
                <form action="MainController" method="GET">
                    <div class="navbar-item">
                        <span class="control mr-2">
                            <input class="input is-rounded" type="text" name="txtSearch" value="${param.txtSearch}" placeholder="Find post here">
                            <input type="hidden" name="txtCurrentPage" value="1"/>
                            <input type="submit" name="action" value="search_article" style="display: none">
                        </span>
                    </div>
                </form>
            </div>
            <div class="navbar-end">
                <div class="navbar-item has-dropdown is-hoverable">
                    <c:url value="MainController" var="notificationLink">
                        <c:param name="action" value="load_notification"/>
                        <c:param name="txtSearch" value="${param.txtSearch}"/>
                    </c:url>
                    <a class="navbar-item" href="${pageScope.notificationLink}">
                        <span>Notification</span>
                        <span class="icon is-medium"><i class="far fa-bell fa-lg"></i></span>
                    </a>
                </div>
                <div class="navbar-item has-dropdown is-hoverable">
                    <a class="navbar-item">
                        <span>${sessionScope.DTO.name}</span>
                        <span class="icon is-medium"><i class="far fa-user fa-lg"></i>
                    </a>
                    <c:url var="logOutLink" value="MainController">
                        <c:param name="action" value="logout"/>
                    </c:url>
                    <div class="navbar-dropdown is-right">
                        <a class="navbar-item" href="${pageScope.logOutLink}">Logout</a>
                    </div>
                </div>
            </div>
        </div>
    </nav>
