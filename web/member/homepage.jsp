<%-- 
    Document   : homepage
    Created on : Sep 19, 2020, 5:16:27 PM
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
        <%@include file="header.jsp"%>
        <div class="container mt-6">
            <c:if test="${sessionScope.DTO.status eq 'New'}">
                <div class="columns is-centered mt-2">
                    <div class="notification is-info column is-half my-2">
                        <button class="delete"></button>
                        <c:url var="verificationLink" value="MainController">
                            <c:param name="action" value="send_verification"/>
                        </c:url>
                        <a href="${pageScope.verificationLink}">
                            Verify your account here!
                        </a>
                    </div>
                </div>
            </c:if>

            <!--Post article form-->
            <c:if test="${sessionScope.DTO.role ne 'admin'}">
                <div class="columns is-centered">
                    <div class="column box is-half" id="text-field-box">
                        <article class="media">
                            <div class="media-left">
                                <figure class="image is-64x64"> 
                                    <img class="is-rounded" src="https://bulma.io/images/placeholders/64x64.png">
                                </figure>
                            </div>
                            <div class="media-content">
                                <form action="MainController" id="post-article-form" enctype="multipart/form-data" method="POST">
                                    <div class="field">
                                        <p class="control">
                                            <input type="text" class="input" type="text" name="txtTitle" value="" placeholder="Your post title here">
                                        </p>
                                    </div>
                                    <div class="field">
                                        <p class="control">
                                            <textarea class="textarea" name="txtContent" placeholder="Post something here"></textarea>
                                        </p>
                                    </div>
                                    <nav class="level">
                                        <div class="level-left">
                                            <div class="file has-name">
                                                <input type="file" accept="image/*" name="txtImage" value="">
                                            </div>
                                        </div>
                                        <div class="level-right">
                                            <div class="level-item">
                                                <input type="hidden" name="txtEmail" value="${sessionScope.DTO.email}"/>
                                                <button type="submit" class="button is-info is-rounded" name="action" value="post_article">Post article</button>
                                            </div>
                                        </div>
                                    </nav>
                                </form>
                            </div>
                        </article>
                    </div>
                </div>
            </c:if>
            <!---->

            <c:if test="${requestScope.SUCCESS != null}">
                <div class="columns is-centered mt-2">
                    <div class="notification is-success column is-half">
                        <button class="delete"></button>
                        ${requestScope.SUCCESS}
                    </div>
                </div>
            </c:if>

            <c:if test="${requestScope.LIST_ARTICLE != null}">
                <c:if test="${not empty requestScope.LIST_ARTICLE}" var="checkList">
                    <c:forEach var="dto" items="${requestScope.LIST_ARTICLE}">
                        <div class="columns is-centered">
                            <div class="column is-half">
                                <c:url var="detailArticlePage" value="MainController">
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                    <c:param name="action" value="search_detail_article"/>
                                    <c:param name="txtArticleID" value="${dto.id}"/>
                                </c:url>
                                <a href="${pageScope.detailArticlePage}">
                                    <div class="card my-1">
                                        <c:if test="${dto.image != null}">
                                            <div class="card-image">
                                                <figure class="image">
                                                    <img src="${pageContext.request.contextPath}/images/${dto.image}">
                                                </figure>
                                            </div>
                                        </c:if>
                                        <div class="card-content">
                                            <div class="media">
                                                <div class="media-left">
                                                    <figure class="image is-48x48">
                                                        <img class="is-rounded" src="https://bulma.io/images/placeholders/96x96.png" alt="Placeholder image">
                                                    </figure>
                                                </div>
                                                <div class="media-content">
                                                    <p class="title is-size-4">${dto.title}</p>
                                                    <p class="subtitle is-size-6">${dto.userEmail}</p>
                                                </div>
                                            </div>
                                            <div class="content is-size-5">
                                                ${dto.content}<br/>
                                                <time class="is-size-7">
                                                    <fmt:formatDate  pattern="dd-MM-yyyy HH:mm" value="${dto.createdDate}"/>
                                                </time>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${!pageScope.checkList}">
                    No record found
                </c:if>
            </c:if>
        </div>
    </body>
</html>
