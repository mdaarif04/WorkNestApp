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

<c:if test="${not empty msg}">
  <div style="color: green; font-weight: bold;">
    ${msg}
  </div>
</c:if>

<h3>Notification</h3>

<c:if test="${not empty reassignLogs}">
  <table border="1" cellpadding="8" cellspacing="0" style="border-collapse: collapse; width: 100%;">
    <thead>
      <tr>
        <th>From User</th>
        <th>To User</th>
        <th>Task Code</th>
        <th>Reassigned At</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="rl" items="${reassignLogs}">
        <tr>
          <td><strong>${rl.fromUser.name}</strong></td>
          <td><strong>${rl.toUser.name}</strong></td>
          <td><strong>${rl.task.taskCode}</strong></td>
          <td><fmt:formatDate value="${rl.at}" pattern="yyyy-MM-dd HH:mm"/></td>
          <td>
            <!-- ✅ Resume button -->
            <form method="post" action="<c:url value='/admin/tasks/resume'/>" style="display:inline;">
              <input type="hidden" name="taskId" value="${rl.task.id}"/>
              <button type="submit">Resume (Unlock)</button>
            </form>

            <!-- ✅ Permanent Finish button -->
            <form method="post" action="<c:url value='/admin/tasks/permanent-finish'/>" style="display:inline;">
              <input type="hidden" name="taskId" value="${rl.task.id}"/>
              <button type="submit">Permanent Finish</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</c:if>


</body>
</html>