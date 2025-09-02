<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value='/assets/css/common.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/css/tasks.css'/>">

<jsp:include page="_header.jsp"/>
<h2>My Tasks</h2>
<table>
  <thead><tr><th>Task ID</th><th>Title</th><th>Status</th><th>Due</th><th>Action</th></tr></thead>
  <tbody>
    <c:forEach var="t" items="${tasks}">
      <tr>
        <td>${t.taskCode}</td>
        <td>${t.title}</td>
        <td>${t.status}</td>
        <td>${t.dueDate}</td>
        <td>
          <!-- Status Update -->
          <form style="display:inline" method="post" action="<c:url value='/user/tasks/status'/>">
            <input type="hidden" name="taskId" value="${t.id}"/>
            <select name="status">
              <option value="PENDING" ${t.status=='PENDING'?'selected':''}>Pending</option>
              <option value="IN_PROGRESS" ${t.status=='IN_PROGRESS'?'selected':''}>In Progress</option>
              <option value="COMPLETED" ${t.status=='COMPLETED'?'selected':''}>Completed</option>
              <option value="DELAYED" ${t.status=='DELAYED'?'selected':''}>Delayed</option>
            </select>
            <button type="submit">Update</button>
          </form>

          <!-- Add Comment -->
          <form style="display:inline" method="post" action="<c:url value='/user/tasks/comment'/>">
            <input type="hidden" name="taskId" value="${t.id}"/>
            <input name="content" placeholder="Add comment"/>
            <button type="submit">Comment</button>
          </form>

 <!-- Forward to another user -->
<form style="display:inline" method="post" action="<c:url value='/user/tasks/forward'/>">
    <input type="hidden" name="taskId" value="${t.id}"/>
    <select name="newUserId">
        <c:forEach var="u" items="${users}">
            <c:if test="${u.role ne 'ADMIN'}">
                <option value="${u.id}">${u.name}</option>
            </c:if>
        </c:forEach>
    </select>
    <button type="submit">Forward</button>
</form>


        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

<jsp:include page="_footer.jsp"/>
