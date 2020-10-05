<%-- 
    Document   : detail
    Created on : Sep 21, 2020, 9:26:40 AM
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

            <!--Post section-->
            <c:if test="${requestScope.ARTICLE_DTO != null}" var="checkArticleStatus">
                <div class="columns is-centered">
                    <div class="column is-two-thirds">
                        <div class="card">
                            <c:if test="${requestScope.ARTICLE_DTO.image != null}">
                                <div class="card-image">
                                    <figure class="image">
                                        <img src="${pageContext.request.contextPath}/images/${requestScope.ARTICLE_DTO.image}">
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
                                        <p class="title is-size-4">${requestScope.ARTICLE_DTO.title}</p>
                                        <p class="subtitle is-size-6">${requestScope.ARTICLE_DTO.userEmail}</p>
                                    </div>
                                    <c:if test="${sessionScope.DTO.email eq requestScope.ARTICLE_DTO.userEmail || sessionScope.DTO.role eq 'admin'}">
                                        <div class="media-right">
                                            <div class="dropdown is-hoverable is-right">
                                                <div class="dropdown-trigger">
                                                    <span class="icon is-small">
                                                        <i class="fas fa-ellipsis-h"></i>
                                                    </span>
                                                </div>
                                                <div class="dropdown-menu">
                                                    <div class="dropdown-content">
                                                        <a href="#">
                                                            <div class="dropdown-item has-text-centered" id="delete-article">
                                                                <form action="MainController" method="POST" id="delete-article-form">
                                                                    <input type="hidden" name="txtArticleID" value="${requestScope.ARTICLE_DTO.id}">
                                                                    <input type="hidden" name="txtArticleUserEmail" value="${requestScope.ARTICLE_DTO.userEmail}">
                                                                    <input type="hidden" name="action" value="delete_article">
                                                                </form>
                                                                Delete post
                                                            </div>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="content is-size-5">
                                    ${requestScope.ARTICLE_DTO.content}<br/>
                                    <time class="is-size-7">                                
                                        <fmt:formatDate  pattern="dd-MM-yyyy HH:mm" value="${requestScope.ARTICLE_DTO.createdDate}"/>
                                    </time>
                                </div>
                                <c:if test="${sessionScope.DTO.role eq 'member'}" var="checkMember">
                                    <div class="field has-addons">
                                        <form action="MainController" method="POST">
                                            <p class="control">
                                                <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                                                <input type="hidden" name="txtArticleID" value="${requestScope.ARTICLE_DTO.id}"/>
                                                <input type="hidden" name="txtEmail" value="${requestScope.ARTICLE_DTO.userEmail}"/>
                                                <input type="hidden" name="txtType" value="Like"/>
                                                <button type="submit" 
                                                        <c:if test="${requestScope.USER_EMOTION eq 'Like'}" var="checkLike"> 
                                                            class="button is-info"
                                                        </c:if>
                                                        <c:if test="${!pageScope.checkLike}">
                                                            class="button"
                                                        </c:if> name="action" value="react_article">
                                                    <span class="icon is-small">
                                                        <i class="far fa-thumbs-up"></i>
                                                    </span>
                                                    <span><strong>${requestScope.LIKE_COUNT}</strong> Like</span>
                                                </button>
                                            </p>
                                        </form>
                                        <form action="MainController" method="POST">
                                            <p class="control">
                                                <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                                                <input type="hidden" name="txtArticleID" value="${requestScope.ARTICLE_DTO.id}"/>
                                                <input type="hidden" name="txtEmail" value="${requestScope.ARTICLE_DTO.userEmail}"/>
                                                <input type="hidden" name="txtType" value="Dislike"/>
                                                <button type="submit"
                                                        <c:if test="${requestScope.USER_EMOTION eq 'Dislike'}" var="checkDislike"> 
                                                            class="button is-danger"
                                                        </c:if>
                                                        <c:if test="${!pageScope.checkDislike}">
                                                            class="button"
                                                        </c:if> name="action" value="react_article">
                                                    <span class="icon is-small">
                                                        <i class="far fa-thumbs-down"></i>
                                                    </span>
                                                    <span><strong>${requestScope.DISLIKE_COUNT}</strong> Dislike</span>
                                                </button>
                                            </p>
                                        </form>
                                    </div>
                                </c:if>
                                <c:if test="${!pageScope.checkMember}">
                                    <button type="submit" class="button" name="action" value="react_article">
                                        <span class="icon is-small">
                                            <i class="far fa-thumbs-up"></i>
                                        </span>
                                        <span><strong>${requestScope.LIKE_COUNT}</strong> Like</span>
                                    </button>
                                    <button type="submit" class="button" name="action" value="react_article">
                                        <span class="icon is-small">
                                            <i class="far fa-thumbs-down"></i>
                                        </span>
                                        <span><strong>${requestScope.DISLIKE_COUNT}</strong> Dislike</span>
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <!---->

                <!-- Comment section -->
                <div class="columns is-centered">
                    <div class="column is-two-thirds my-3">
                        <div class="box">
                            <c:if test="${pageScope.checkMember}">
                                <article class="media">
                                    <figure class="media-left">
                                        <p class="image is-48x48">
                                            <img class="is-rounded" src="https://bulma.io/images/placeholders/128x128.png">
                                        </p>
                                    </figure>
                                    <div class="media-content">
                                        <div class="field">
                                            <p class="control">
                                            <form action="MainController" method="POST" id="comment-form">
                                                <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                                                <input type="hidden" name="txtArticleID" value="${requestScope.ARTICLE_DTO.id}"/>
                                                <input type="hidden" name="txtEmail" value="${requestScope.ARTICLE_DTO.userEmail}"/>
                                                <input type="text" class="input is-rounded" placeholder="Add a comment..." name="txtComment"/>
                                                <input type="submit" name="action" value="add_comment" style="display: none">
                                            </form>
                                            </p>
                                        </div>
                                    </div>
                                </article>
                            </c:if>
                            <c:if test="${requestScope.LIST_COMMENT != null}">
                                <c:if test="${not empty requestScope.LIST_COMMENT}" var="checkListComment">
                                    <c:forEach var="dto" items="${requestScope.LIST_COMMENT}">
                                        <article class="media">
                                            <figure class="media-left">
                                                <p class="image is-48x48">
                                                    <img class="is-rounded" src="https://bulma.io/images/placeholders/128x128.png">
                                                </p>
                                            </figure>
                                            <div class="media-content">
                                                <div class="content">
                                                    <p>
                                                        <strong>${dto.userEmail}</strong>
                                                        <br>
                                                        ${dto.content}
                                                        <br>
                                                    </p>
                                                </div>
                                            </div>
                                            <c:if test="${sessionScope.DTO.email eq dto.userEmail || sessionScope.DTO.role eq 'admin'}">
                                                <div class="media-right">
                                                    <div class="dropdown is-hoverable is-right">
                                                        <div class="dropdown-trigger">
                                                            <span class="icon is-small">
                                                                <i class="fas fa-ellipsis-h"></i>
                                                            </span>
                                                        </div>
                                                        <div class="dropdown-menu">
                                                            <div class="dropdown-content">
                                                                <a href="#">
                                                                    <div class="dropdown-item has-text-centered delete-comment">
                                                                        <form action="MainController" method="POST" class="delete-comment-form">
                                                                            <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                                                                            <input type="hidden" name="txtCommentID" value="${dto.commentID}">
                                                                            <input type="hidden" name="txtArticleID" value="${requestScope.ARTICLE_DTO.id}">
                                                                            <input type="hidden" name="txtEmail" value="${requestScope.ARTICLE_DTO.userEmail}"/>
                                                                            <input type="hidden" name="action" value="delete_comment">
                                                                        </form>
                                                                        Delete comment
                                                                    </div>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </article>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${!pageScope.checkListComment}">
                                    <div class="columns is-centered mt-3">
                                        <div class="notification column has-text-centered">
                                            No comment in this post. Be the first one to comment
                                        </div>
                                    </div>
                                </c:if>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${!pageScope.checkArticleStatus}">
                <div class="columns is-centered">
                    <div class="notification is-info column is-half has-text-centered">
                        <button class="delete"></button>
                        This article has been deleted
                    </div>
                </div>
            </c:if>
            <!---->

        </div>
    </body>
</html>
