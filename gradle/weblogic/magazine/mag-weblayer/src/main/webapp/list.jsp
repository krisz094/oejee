<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Set" %>  
<%@ page import="java.util.List" %>
<%@ page import="hu.qwaevisz.magazine.weblayer.common.ListAttribute" %>
<%@ page import="hu.qwaevisz.magazine.weblayer.common.FormValue" %>
<%@ page import="hu.qwaevisz.magazine.ejbservice.domain.MagazineStub" %>
<%@ page import="hu.qwaevisz.magazine.ejbservice.domain.MagazineCategoryStub" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://qwaevisz.hu/jsp/tlds/booktag" prefix="bt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="style/page.css" />
<title>:: Magazines ::</title>
</head>
<body>
    <bt:header>List of Magazines</bt:header>
    <div>
    	<% String userName = (String) request.getUserPrincipal().getName(); %>
	    Welcome <strong><%= userName %></strong>! <a href="Logout">Logout</a>
	</div>
	<br/><br/>
	<form method="post" action="MagazineList">
		<div>
			<label for="category">Category: </label>
			<select name="category" id="category">
			    <% String categoryName = (String) request.getAttribute(ListAttribute.ATTR_CATEGORY); %>
				<option value="-1" <% out.print( FormValue.FILTER_ALL_CATEGORY.equals(categoryName) ? "selected=\"selected\"" : "" ); %>>-</option>
			    <c:set var="categoryValues" value="<%= MagazineCategoryStub.values() %>"/>
				<c:forEach items="${categoryValues}" var="category">
					<option value="${category.name}" ${category.name eq requestScope.category ? "selected=\"selected\"" : ""}>${category.label}</option>
				</c:forEach>
			</select>
			<input type="submit" value="Filter" />
		</div>
	</form>
	<br/><br/>
	<c:choose>
	    <c:when test="${requestScope.magazines.isEmpty()}">
            <span>Magazine list is <strong>empty</strong>.</span>
        </c:when>
        <c:otherwise>
            <table class="bookstable">
                <thead>
                    <tr>
                        <th>Publisher</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Number of pages</th>
                        <% if (request.isUserInRole("mag-admin")) { %>
                        	<th>&nbsp;</th>
                        <% } %>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.magazines}" var="magazine">
                        <tr>
                            <td><c:out value="${magazine.publisher}" /></td>
                            <td><a href="Magazine?reference=<c:out value="${magazine.reference}" />"><c:out value="${magazine.title}" /></a></td>
                            <td><c:out value="${magazine.category.label}" /></td>
                            <td><bt:formatPrice value="${magazine.price}"/></td>
                            <td><c:out value="${magazine.numberOfPages}" /></td>
                            <% if (request.isUserInRole("mag-admin")) { %>
                            	<td><a href="MagazineDelete?reference=<c:out value="${magazine.reference}" />">delete</a></td>
                            <% } %>
                            <td><a href="MagazineDelete?reference=<c:out value="${magazine.reference}" />">delete (unsafe)</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <br/>
        </c:otherwise>
	</c:choose>
	<br/><br/>
	<% if (request.isUserInRole("mag-admin")) { %>
		<div>
		    <a href="Magazine?reference=-1&edit=1">Create</a> a brand new magazine.
		</div>
	<% } %>
</body>
</html>