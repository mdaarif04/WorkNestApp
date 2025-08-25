<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
<div class="container">
  <nav>
  
  <!-- 
    <a href="<c:url value='/'/>">Home</a>
    
     -->
    <c:choose>
      <c:when test="${not empty sessionScope.user}">
        <span>Hello, ${sessionScope.user.name} (${sessionScope.user.role})</span>
        <c:if test="${sessionScope.user.role == 'ADMIN'}">
          | <a href="<c:url value='/admin/dashboard'/>">Admin Dashboard</a>
        </c:if>
        | <a href="<c:url value='/user/tasks'/>">My Tasks</a>
        | <a href="<c:url value='/logout'/>">Logout</a>
      </c:when>
      <c:otherwise>
        <a href="<c:url value='/login'/>">Login</a> | <a href="<c:url value='/register'/>">Register</a>
      </c:otherwise>
    </c:choose>
  </nav>
  <hr/>
