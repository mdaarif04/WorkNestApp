<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="_header.jsp"/>

<link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">

<h2>Admin Dashboard</h2>

<h3>Users</h3>
<table border="1" cellpadding="5" cellspacing="0">
  <thead>
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Email</th>
      <th>Role</th>
      <th>Actions</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="u" items="${users}">
      <tr>
        <td>${u.id}</td>
        <td>${u.name}</td>
        <td>${u.email}</td>
        <td>${u.role}</td>
        <td>
          
          <!-- Delete User -->
          <form method="post" action="<c:url value='/admin/users/delete'/>" style="display:inline;">
            <input type="hidden" name="userId" value="${u.id}"/>
            <button type="submit" onclick="return confirm('Delete this user?')">Delete</button>
          </form>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>




<h3>Allocate Task</h3>
<form method="post" action="<c:url value='/admin/tasks/allocate'/>">
  <label>Title</label>
  <input name="title" required/>
  <label>Description</label>
  <textarea name="description"></textarea>
  <div class="row">
    <div>
      <label>Start Date</label>
      <input type="date" name="startDate"/>
    </div>
    <div>
      <label>Due Date</label>
      <input type="date" name="dueDate"/>
    </div>
  </div>
  <label>Assign To (User ID)</label>
  <input type="number" name="userId" required/>
  <button class="btn" type="submit">Allocate</button>
</form>


<h3>All Tasks</h3>
<table>
  <thead>
    <tr><th>ID</th><th>Title</th><th>Assignee</th><th>Status</th><th>Due</th><th>Comments</th></tr>
  </thead>
  <tbody>
    <c:forEach var="t" items="${tasks}">
      <tr>
        <td>${t.id}</td>
        <td>${t.title}</td>
        <td><c:out value='${t.user != null ? t.user.name : "Unassigned"}'/></td>
        <td>${t.status}</td>
        <td>${t.dueDate}</td>
        <td>
        <a href="<c:url value='/admin/tasks/edit?taskId=${t.id}'/>">Edit</a>
         <!-- Delete Task -->
      <form method="post" action="<c:url value='/admin/tasks/delete'/>" style="display:inline;">
        <input type="hidden" name="taskId" value="${t.id}"/>
        <button type="submit" onclick="return confirm('Delete this task?')">Delete</button>
      </form>
          <c:forEach var="c" items="${taskComments[t.id]}">
            <div>
              <strong>${c.user.name}:</strong> ${c.content}
              <br/><small>${c.createdAt}</small>
            </div>
          </c:forEach>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>





 <div>




</div>
<jsp:include page="_footer.jsp"/>
