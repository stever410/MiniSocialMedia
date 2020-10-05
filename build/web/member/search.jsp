<%-- 
    Document   : search
    Created on : Sep 20, 2020, 7:10:53 PM
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
            <c:if test="${requestScope.SEARCH_RESULT != null}">
                <c:if test="${not empty requestScope.SEARCH_RESULT}" var="checkList">
                    <c:forEach var="dto" items="${requestScope.SEARCH_RESULT}">
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
                    <nav class="columns is-centered">
                        <nav class="column is-half pagination is-centered">
                            <ul class="pagination-list" id="pagination"></ul>
                            <form action="MainController" method="GET" id="formSubmit">
                                <input type="hidden" name="txtSearch" value="${param.txtSearch}">
                                <input type="hidden" name="action" value="search_article">
                                <input type="hidden" value="" id="currentPage" name="txtCurrentPage"/>
                            </form>
                        </nav>
                    </nav>
                </c:if>
                <c:if test="${!pageScope.checkList}">
                    <div class="columns is-centered">
                        <div class="notification is-info column is-half has-text-centered">
                            <button class="delete"></button>
                            No records found!
                        </div>
                    </div>
                </c:if>
            </c:if>
        </div>
        <script type="text/javascript">
            let totalPages = ${requestScope.TOTAL_PAGE};
            let currentPage = ${requestScope.CURRENT_PAGE};
            $(function () {
                window.pagObj = $('#pagination').twbsPagination({
                    totalPages: totalPages,
                    visiblePages: 5,
                    startPage: currentPage,
                    pageClass: "",
                    activeClass: "bg-active",
                    anchorClass: "pagination-link",
//                    first: "",
//                    prev: "",
//                    next: "",
//                    last: "",
//                    firstClass: "",
//                    lastClass: "",
//                    nextClass: "",
//                    prevClass: "",
                    onPageClick: function (event, page) {
                        if (currentPage !== page) {
                            $('#currentPage').val(page);
                            $('#formSubmit').submit();
                        }
                    }
                });
            });
        </script>
    </body>
</html>
