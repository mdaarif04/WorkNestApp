<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="_header.jsp"/>

<h2>Edit Task</h2>
<form method="post" action="<c:url value='/admin/tasks/edit'/>">
  <input type="hidden" name="id" value="${task.id}"/>
  <label>Title</label>
  <input name="title" value="${task.title}" required/>
  
  <label>Description</label>
  <textarea name="description">${task.description}</textarea>
  
  <label>Status</label>
  <select name="status">
    <option ${task.status=='PENDING'?'selected':''}>PENDING</option>
    <option ${task.status=='IN_PROGRESS'?'selected':''}>IN_PROGRESS</option>
    <option ${task.status=='COMPLETED'?'selected':''}>COMPLETED</option>
  </select>
  
  <label>Start Date</label>
  <input type="date" name="startDate" value="${task.startDate}"/>
  
  <label>Due Date</label>
  <input type="date" name="dueDate" value="${task.dueDate}"/>
  
  <label>Assign To</label>
  <select name="userId">
    <c:forEach var="u" items="${users}">
      <option value="${u.id}" ${task.user != null && task.user.id == u.id ? 'selected':''}>${u.name}</option>
    </c:forEach>
  </select>
  
  <button type="submit">Save Changes</button>
</form>

<jsp:include page="_footer.jsp"/>
