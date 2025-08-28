<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value='/assets/css/common.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/css/register.css'/>">


<jsp:include page="_header.jsp"/>
<h2>Register</h2>
<form method="post" action="register">
  <div class="row">
    <div>
      <label>Name</label>
      <input type="text" name="name" required/>
    </div>
    <div>
      <label>Email</label>
      <input type="email" name="email" required/>
    </div>
  </div>
  <div class="row">
    <div>
      <label>Password</label>
      <input type="password" name="password" required/>
    </div>
    <div>
      <label>Role</label>
      <select name="role">
        <option value="USER">USER</option>
        <option value="ADMIN">ADMIN</option>
      </select>
    </div>
  </div>
  <button class="btn" type="submit">Create Account</button>
</form>
<jsp:include page="_footer.jsp"/>
