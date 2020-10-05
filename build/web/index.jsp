<%-- 
    Document   : index
    Created on : Sep 18, 2020, 7:49:41 AM
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/app.js"></script>
        <title>Login Page</title>
    </head>
    <body>
        <div class="container"> 
            <div class="columns is-vcentered is-centered" style="height: 100vh">
                <div class="column is-half">
                    <div class="box">
                        <div class="level">
                            <img src="${pageContext.request.contextPath}/img/instagram-logo.png" width="64" class="image is-11 is-level-item is-centered-img">
                        </div>
                        <form action="MainController" method="POST">
                            <div class="field">
                                <label class="label">Email </label>
                                <div class="control">
                                    <input class="input" type="email" name="txtEmail" value="${requestScope.EMAIL}"/>
                                </div>
                            </div>
                            <div class="field">
                                <label class="label">Password</label>
                                <div class="control">
                                    <input class="input" type="password" name="txtPassword" id="txtPassword" value="">
                                </div>
                            </div>
                            <button class="button is-primary is-fullwidth" type="submit"name="action" value="login">Login</button>
                        </form>
                        <c:if test="${requestScope.INVALID != null}">
                            <div class="notification is-warning mt-3">
                                <button class="delete"></button>
                                ${requestScope.INVALID}
                            </div>
                        </c:if>
                        <c:if test="${requestScope.SUCCESS != null}">
                            <div class="notification is-success mt-3">
                                <button class="delete"></button>
                                ${requestScope.SUCCESS}
                            </div>
                        </c:if>
                    </div>
                    <div class="box has-text-centered">
                        <p>Don't have an account. Go to <a href="register.jsp"> register page</a></p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
