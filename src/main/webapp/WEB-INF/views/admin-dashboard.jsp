<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="_header.jsp"/>

<link rel="stylesheet" href="<c:url value='/assets/css/common.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/css/admin.css'/>">

<h2>Admin Dashboard</h2>

<h3>Task Summary</h3>
<ul>
  <li>Pending: ${pendingCount}</li>
  <li>In Progress: ${inProgressCount}</li>
  <li>Completed: ${completedCount}</li>
  <li>Delayed: ${delayedCount}</li>
</ul>

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

<h3>Allocate Task (Multiple Users)</h3>
<form method="post" action="<c:url value='/admin/tasks/allocate'/>">
  <label>Task Code </label>
  <input name="taskCode" required/>

  <label>Title</label><input name="title" required/>
  <label>Description</label><textarea name="description"></textarea>
  <label>Start Date</label><input type="date" name="startDate"/>
  <label>Due Date</label><input type="date" name="dueDate"/>
  
<label>Assign To:</label><br>
<c:forEach var="user" items="${users}">
    <input type="checkbox" name="userIds" value="${user.id}">
    ${user.name}<br>
</c:forEach>
  
  <button type="submit">Allocate</button>
</form>

<h3>All Tasks</h3>
<table border="1">
  <thead>
    <tr><th>Task Code</th><th>Title</th><th>Assignees</th><th>Status</th><th>Due</th><th>Actions</th><th>Comments</th></tr>
  </thead>
  <tbody>
    <c:forEach var="t" items="${tasks}">
      <tr>
        <!-- Show manual Task Code instead of DB ID -->
        <td>${t.taskCode}</td>
        <td>${t.title}</td>
        <td>
          <c:forEach var="u" items="${t.users}">
            ${u.name}<br/>
          </c:forEach>
        </td>
        <td>${t.status}</td>
        <td>${t.dueDate}</td>
        <td>
          <!-- Still use DB ID internally for edit/delete -->
          <a href="<c:url value='/admin/tasks/edit?taskId=${t.id}'/>">Edit</a>
          <form method="post" action="<c:url value='/admin/tasks/delete'/>" style="display:inline;">
            <input type="hidden" name="taskId" value="${t.id}"/>
            <button type="submit">Delete</button>
          </form>
        </td>
        <td>
          <c:forEach var="c" items="${taskComments[t.id]}">
            <strong>${c.user.name}:</strong> ${c.content}<br/>
          </c:forEach>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

<jsp:include page="_footer.jsp"/>
