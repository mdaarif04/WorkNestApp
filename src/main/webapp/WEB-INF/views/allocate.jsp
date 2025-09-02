<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/assets/css/common.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/css/admin.css'/>">
</head>
<body>
<jsp:include page="_header.jsp"/>

<h3>Allocate Task (Multiple Users)</h3>
<form method="post" action="<c:url value='/admin/tasks/allocate'/>">
  <label>Task Code </label>
  <input name="taskCode" required/>

  <label>Title</label><input name="title" required/>
  <label>Description</label><textarea name="description"></textarea>
  <label>Start Date</label><input type="date" name="startDate"/>
  <label>Due Date</label><input type="date" name="dueDate"/>
  
  <label>Assign To:</label><br>
  <select name="userIds" multiple="multiple" class="form-control user-select" style="width: 100%">
      <c:forEach var="user" items="${users}">
          <option value="${user.id}">${user.name}</option>
      </c:forEach>
  </select>
  
  <button type="submit">Allocate</button>
</form>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
  $(document).ready(function() {
    $('.user-select').select2({
      placeholder: "Select users",
      allowClear: true
    });
  });
</script>

</body>
</html>