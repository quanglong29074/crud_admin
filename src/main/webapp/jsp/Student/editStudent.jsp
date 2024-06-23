<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.crud_admin.entity.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.crud_admin.entity.ClassRoom" %>
<%
  Student student = (Student) request.getAttribute("student");
  List<ClassRoom> classRooms = (List<ClassRoom>) request.getAttribute("classRooms");
%>
<html>
<head>
  <%@ include file="/include/head.jsp"%>
</head>
<body>
<%@ include file="/include/navbar.jsp"%>

<section class="is-title-bar">
  <div class="flex flex-col md:flex-row items-center justify-between space-y-6 md:space-y-0">
    <ul>
      <li>List of Student</li>
      <li>Edit Student</li>
    </ul>
  </div>
</section>

<section class="section main-section">
  <div class="row">
    <div class="col-md-12">
      <div class="tile">
        <h3 class="tile-title">Edit Student</h3>
        <div class="tile-body">
          <form action="<%= request.getContextPath() %>/student" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="edit"/>
            <input type="hidden" name="id" value="<%= student.getId() %>"/>
            <div class="form-group col-md-3">
              <label for="firstName" class="control-label">First Name</label>
              <input id="firstName" name="firstName" class="form-control" value="<%= student.getFirstName() %>" required />
            </div>
            <div class="form-group col-md-3">
              <label for="lastName" class="control-label">Last Name</label>
              <input id="lastName" name="lastName" class="form-control" value="<%= student.getLastName() %>" required />
            </div>
            <div class="form-group col-md-3">
              <label for="email" class="control-label">Email</label>
              <input type="email" id="email" name="email" class="form-control" value="<%= student.getEmail() %>" required />
            </div>
            <div class="form-group col-md-12">
              <label for="classRoomId" class="control-label">Class Room</label>
              <select class="form-control" id="classRoomId" name="classRoomId" required>
                <option value="">Select Class Room</option>
                <% for (ClassRoom classRoom : classRooms) { %>
                <option value="<%= classRoom.getIdClass() %>" <%= (student.getClassRoom() != null && student.getClassRoom().getIdClass() == classRoom.getIdClass()) ? "selected" : "" %>><%= classRoom.getClassName() %></option>
                <% } %>
              </select>
            </div>
            <button style="margin-top:20px;" class="btn btn-save" type="submit">Save</button>
            <a href="<%= request.getContextPath() %>/student" style="margin-top:20px;" class="btn btn-cancel">Cancel</a>
          </form>
        </div>
      </div>
    </div>
  </div>
</section>

<style>
  .row {
    display: flex;
    flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px;
  }

  .col-md-12 {
    flex: 0 0 100%;
    max-width: 100%;
  }

  .form-control {
    width: 100%;
    padding: 0.375rem 0.75rem;
    font-size: 15px;
    line-height: 1.5;
    color: black;
    background-color: #f1f1f1;
    background-clip: padding-box;
    height: 45px;
    border: 1px solid #dadada;
    border-radius: .357rem;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
  }

  .control-label {
    font-weight: 600;
    color: black;
  }

  .btn-save {
    background-color: rgb(166 236 171);
    color: rgb(1 123 10);
    font-weight: 600;
    letter-spacing: 1px;
    border: none;
    border-radius: .357rem;
    padding: 5px 20px;
    margin-top: 10px;
  }

  .btn-cancel {
    background-color: rgb(255 197 197);
    color: rgb(190, 40, 40);
    font-weight: 600;
    letter-spacing: 1px;
    border: none;
    border-radius: .357rem;
    padding: 8px 20px;
    margin-top: 10px;
  }

  .main-section {
    margin-left: 15px;
  }
</style>

<%@ include file="/include/script.jsp"%>
</body>
</html>
