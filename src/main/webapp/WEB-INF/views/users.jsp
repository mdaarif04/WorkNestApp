<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/assets/css/common.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/css/admin.css'/>">
</head>
<body>
<jsp:include page="_header.jsp"/>
<h3>Users</h3>
<table border="1">
  <thead>
    <tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Actions</th></tr>
  </thead>
  <tbody>
    <c:forEach var="u" items="${users}">
      <c:if test="${u.role ne 'ADMIN'}"> <!-- hide admin -->
        <tr>
          <td>${u.id}</td>
          <td>${u.name}</td>
          <td>${u.email}</td>
          <td>${u.role}</td>
          <td>
            <form method="post" action="<c:url value='/admin/users/delete'/>" style="display:inline;">
              <input type="hidden" name="userId" value="${u.id}"/>
              <button type="submit">Delete</button>
            </form>
          </td>
        </tr>
      </c:if>
    </c:forEach>
  </tbody>
</table>

</body>
</html>