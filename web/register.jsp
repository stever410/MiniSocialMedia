<%-- 
    Document   : login
    Created on : Sep 19, 2020, 9:39:14 AM
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
        <title>Register page</title>
    </head>
    <body>
        <div class="container"> 
            <div class="columns is-vcentered is-centered" style="height: 100vh">
                <div class="column is-half">
                    <div class="box">
                        <h1 class="title is-1 has-text-centered instagram-h1">Register</h1>
                        <form action="MainController" method="POST" id="registrationForm">
                            <div class="field">
                                <label class="label">Email </label>
                                <div class="control">
                                    <input class="input"type="email" name="txtEmail" value="${requestScope.DTO.email}"/>
                                </div>
                            </div>
                            <div class="field">
                                <label class="label">Name</label>
                                <div class="control">
                                    <input class="input" type="text" name="txtName" value="${requestScope.DTO.name}"/>
                                </div>
                            </div>
                            <div class="field">
                                <label class="label">Password</label>
                                <div class="control">
                                    <input class="input" type="password" name="txtPassword" id="txtPassword" value="">
                                </div>
                            </div>
                            <div class="field">
                                <label class="label">Retype your password</label>
                                <div class="control">
                                    <input class="input" type="password" name="txtRetype" value=""/>
                                </div>
                            </div>
                            <c:if test="${requestScope.INVALID != null}">
                                <div class="notification is-warning">
                                    <button class="delete"></button>
                                    ${requestScope.INVALID}
                                </div>
                            </c:if>
                            <button class="button is-primary is-fullwidth" type="submit"name="action" value="register">Register</button>
                        </form>
                    </div>
                    <div class="box has-text-centered">
                        <p>Have an account? <a href="index.jsp">Log in</a></p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
