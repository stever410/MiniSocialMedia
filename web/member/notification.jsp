<%-- 
    Document   : notification
    Created on : Sep 26, 2020, 7:13:48 PM
    Author     : ngota
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container mt-6">
            <c:if test="${requestScope.LIST_NOTIFICATION != null}">
                <c:if test="${not empty requestScope.LIST_NOTIFICATION}" var="checkList">
                    <div class="columns is-centered">
                        <div class="column">
                            <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
                                <thead>
                                    <tr>
                                        <c:if test="${sessionScope.DTO.role eq 'admin'}" var="checkRole">
                                            <th>Article's user</th>
                                            </c:if>
                                        <th>Interactor</th>
                                        <th>Date</th>
                                        <th>Description</th>
                                        <th class="has-text-centered">Show detail</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="dto" items="${requestScope.LIST_NOTIFICATION}">
                                        <tr>
                                            <c:if test="${pageScope.checkRole}">
                                                <td>${dto.userEmail}</td>
                                            </c:if>
                                            <td>${dto.interactorEmail}</td>
                                            <td><fmt:formatDate  pattern="dd-MM-yyyy HH:mm" value="${dto.createdDate}"/></td>
                                            <td>${dto.description}</td>
                                            <td class="has-text-centered">
                                                <c:url var="detailArticlePage" value="MainController">
                                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                                    <c:param name="action" value="search_detail_article"/>
                                                    <c:param name="txtArticleID" value="${dto.articleID}"/>
                                                </c:url>
                                                <a href="${pageScope.detailArticlePage}">Detail</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
                <c:if test="${!pageScope.checkList}">
                    <div class="columns is-centered">
                        <div class="notification is-info column is-half has-text-centered">
                            <button class="delete"></button>
                            No notification found!
                        </div>
                    </div>
                </c:if>
            </c:if>
        </div>
    </body>
</html>
