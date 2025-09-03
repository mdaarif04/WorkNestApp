<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="_header.jsp"/>

<link rel="stylesheet" href="<c:url value='/assets/css/common.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/css/tasks.css'/>">



<html>
<head>
    <title>User Tasks</title>
</head>
<body>
<h2>My Tasks</h2>

<c:if test="${not empty msg}">
    <p style="color:green">${msg}</p>
</c:if>

<table border="1">
    <thead>
    <tr>
        <th>Task Code</th>
        <th>Title</th>
        <th>Status</th>
        <th>Due Date</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="t" items="${tasks}">
        <tr>
            <td>${t.taskCode}</td>
            <td>${t.title}</td>
            <td>${t.status}</td>
            <td>${t.dueDate}</td>
            <td>
                <c:choose>
                    <%-- If locked for current user: show static label only --%>
                    <c:when test="${fn:contains(t.lockedUserIds, currentUser.id)}">
    <span><strong>Marked as Completed</strong> (You can’t act on this task)</span>
</c:when>

                    <c:otherwise>
                        <%-- Status Update form --%>
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

                        <%-- Add Comment form --%>
                        <form style="display:inline" method="post" action="<c:url value='/user/tasks/comment'/>">
                            <input type="hidden" name="taskId" value="${t.id}"/>
                            <input name="content" placeholder="Add comment"/>
                            <button type="submit">Comment</button>
                        </form>

                        <%-- Forward to another user form --%>
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
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
