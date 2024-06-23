<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.crud_admin.entity.Student" %>
<html>
<head>
  <%@ include file="/include/head.jsp"%>
</head>
<body>
<%@ include file="/include/navbar.jsp"%>

<section class="is-title-bar">
  <div class="flex flex-col md:flex-row items-center justify-between space-y-6 md:space-y-0">
    <ul>
      <li>Admin</li>
      <li>Student</li>
    </ul>
  </div>
</section>

<section class="is-hero-bar">
  <div class="flex flex-col md:flex-row items-center justify-start">
    <!-- Phần này để chứa nút "Add Student" -->
    <div class="col-sm-2" style="margin-right: 5px;">
      <a class="btn btn-add" href="addStudent" title="Thêm">
        <i class="fas fa-plus"></i>
        Add Student
      </a>
    </div>
  </div>
</section>

<section class="section main-section">
  <div class="notification blue">
    <div class="flex flex-col md:flex-row items-center justify-between space-y-3 md:space-y-0">
      <div>
        <span class="icon"><i class="mdi mdi-buffer"></i></span>
        <b>Responsive table</b>
      </div>
      <button type="button" class="button small textual --jb-notification-dismiss">Dismiss</button>
    </div>
  </div>
  <div class="card has-table">
    <header class="card-header">
      <p class="card-header-title">
        <span class="icon"><i class="mdi mdi-account-multiple"></i></span>
        Students
      </p>
      <a href="#" class="card-header-icon">
        <span class="icon"><i class="mdi mdi-reload"></i></span>
      </a>
    </header>
    <div class="card-content">
      <table>
        <thead>
        <tr>
          <th>ID</th>
          <th>Email</th>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Class Room</th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <%
          List<Student> studentList = (List<Student>) request.getAttribute("studentList");
          if (studentList != null) {
            for (Student student : studentList) {
        %>
        <tr>
          <td><%= student.getId() %></td>
          <td><%= student.getEmail() %></td>
          <td><%= student.getFirstName() %></td>
          <td><%= student.getLastName() %></td>
          <td><%= student.getClassRoom().getClassName() %></td>
          <td>
            <a href="<%= request.getContextPath() %>/student?action=edit&id=<%= student.getId() %>" class="btn btn-primary">Edit</a>
            <form action="student" method="post" style="display:inline;" onsubmit="return confirmDelete()">
              <input type="hidden" name="id" value="<%= student.getId() %>">
              <input type="hidden" name="action" value="delete">
              <button type="submit" class="btn btn-danger">Delete</button>
            </form>
          </td>
        </tr>
        <%
            }
          }
        %>
        </tbody>
      </table>
      <div class="table-pagination">
        <div class="flex items-center justify-between">
          <div class="buttons">
            <%
              int currentPage = (int) request.getAttribute("currentPage");
              int totalPages = (int) request.getAttribute("totalPages");
              for (int i = 1; i <= totalPages; i++) {
            %>
            <a href="<%= request.getContextPath() %>/student?page=<%= i %>" class="button <%= (i == currentPage) ? "active" : "" %>"><%= i %></a>
            <%
              }
            %>
          </div>
          <small>Page <%= currentPage %> of <%= totalPages %></small>
        </div>
      </div>
    </div>
  </div>
</section>
<%@ include file="/include/script.jsp"%>
<script>
  function confirmDelete() {
    return confirm("Are you sure you want to delete this student?");
  }
</script>

<style>
  .btn-primary {
    color: rgb(245 157 57);
    background-color: rgb(251 226 197);
    border: none;
    border-radius: .357rem;
    font-weight: 600;
    padding: 5px 20px;
  }

  .btn-add {
    color: white;
    background-color: black;
    border: none;
    border-radius: .357rem;
    font-weight: 600;
    padding: 10px 20px;
  }

  .btn-danger {
    color: #FFF;
    background-color: #dc3545;
    border-color: #dc3545;
    border-radius: .357rem;
    font-weight: 600;
    padding: 5px 20px;
  }

  .btn-danger:hover {
    color: #FFF;
    background-color: #c82333;
    border-color: #bd2130;
  }

  .btn-danger:focus, .btn-danger.focus {
    -webkit-box-shadow: 0 0 0 0 rgba(220, 53, 69, 0.5);
    box-shadow: 0 0 0 0 rgba(220, 53, 69, 0.5);
  }

  .btn-danger.disabled, .btn-danger:disabled {
    color: #FFF;
    background-color: #dc3545;
    border-color: #dc3545;
  }

  .button-group {
    display: flex;
  }

  .button-group > * {
    margin-right: 10px;
  }
</style>

</body>
</html>
