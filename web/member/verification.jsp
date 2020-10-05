<%-- 
    Document   : verification
    Created on : Sep 27, 2020, 8:19:39 AM
    Author     : ngota
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bulma.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container"> 
            <div class="columns is-vcentered is-centered" style="height: 100vh">
                <div class="column is-half">
                    <div class="box">
                        <div class="level">
                            We have sent to your ${sessionScope.DTO.email} a verification code.
                        </div>
                        <form action="MainController" method="POST">
                            <div class="field">
                                <label class="label">Verification code </label>
                                <div class="field">
                                    <p class="control">
                                        <input class="input" type="text" name="txtCode" >
                                    </p>
                                </div>
                            </div>
                            <button class="button is-primary is-fullwidth" type="submit" name="action" value="verify_code">Submit</button>
                        </form>
                        <c:if test="${requestScope.INVALID != null}">
                            <div class="notification is-warning mt-3">
                                <button class="delete"></button>
                                ${requestScope.INVALID}
                            </div>
                        </c:if>
                    </div>
                    <div class="box has-text-centered">
                        <c:url value="MainController" var="sendVerificationLink">
                            <c:param name="action" value="send_verification"/>
                        </c:url>
                        <p>Didn't received any code.<a href="${pageScope.sendVerificationLink}"> Send verification code again </a></p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
