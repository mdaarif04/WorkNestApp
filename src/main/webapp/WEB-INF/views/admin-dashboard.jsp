<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="_header.jsp"/>

<link rel="stylesheet" href="<c:url value='/assets/css/common.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/css/admin.css'/>">

<button><a href="<c:url value='/admin/tasks/allocate'/>">Allocate Task</a></button>
<button><a href="<c:url value='/admin/users'/>">Users</a></button>



<h2>Admin Dashboard</h2>

<h3>Task Summary</h3>
<ul>
  <li>Pending: ${pendingCount}</li>
  <li>In Progress: ${inProgressCount}</li>
  <li>Completed: ${completedCount}</li>
  <li>Delayed: ${delayedCount}</li>
</ul>








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
