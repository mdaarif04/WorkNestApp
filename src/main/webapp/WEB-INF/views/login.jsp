<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">



<jsp:include page="_header.jsp"/>

<div class="container">
  <h2>Login</h2>
  <c:if test="${not empty error}"><div class="alert">${error}</div></c:if>
  <form method="post" action="login">
    <label>Email</label>
    <input type="email" name="email" required/>
    <label>Password</label>
    <input type="password" name="password" required/>
    <button class="btn" type="submit">Login</button>
  </form>
  <p>Don't have an account? <a href="<c:url value='/register'/>">Register</a></p>
</div>

<jsp:include page="_footer.jsp"/>
