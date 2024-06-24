<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 19/06/2024
  Time: 8:50 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.crud_admin.entity.ClassRoom" %>
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
      <li>Tables</li>
    </ul>

  </div>
</section>

<section class="is-hero-bar">
  <div class="flex flex-col md:flex-row items-center justify-start">
    <!-- Phần này để chứa nút "Add Blog" -->
    <div class="col-sm-2" style="margin-right: 5px;">
      <a class="btn btn-add"  href="addClass" title="Thêm">
        <i class="fas fa-plus"></i>
        Add Category
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
        Clients
      </p>
      <a href="#" class="card-header-icon">
        <span class="icon"><i class="mdi mdi-reload"></i></span>
      </a>
    </header>
    <div class="card-content">
      <table>
        <thead>
        <tr>
          <th scope="col">Class Id</th>
          <th scope="col">Class name</th>
          <th scope="col">Number member</th>
          <th scope="col">Actions</th>
        </tr>
        </thead>
        <tbody>
        <%-- Lấy danh sách ClassRoom từ request attribute --%>
        <% List<ClassRoom> classRooms = (List<ClassRoom>) request.getAttribute("classRooms"); %>
        <%-- Kiểm tra nếu danh sách không rỗng --%>
        <% if (classRooms != null && !classRooms.isEmpty()) { %>
        <%-- Sử dụng vòng lặp để duyệt qua từng ClassRoom và hiển thị thông tin --%>
        <% for (ClassRoom classRoom : classRooms) { %>
        <tr>
          <td><%= classRoom.getIdClass() %></td>
          <td><%= classRoom.getClassName() %></td>
          <td><%= classRoom.getNumberMember() %></td>
          <td>
            <a class="btn btn-primary" href="editClass?id=<%= classRoom.getIdClass() %>">Edit</a>
            <form action="class?id=<%= classRoom.getIdClass() %>" method="post" style="display:inline;">
              <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this class?');">Delete</button>
            </form>

          </td>
        </tr>
        <% } %>
        <% } else { %>
        <%-- Hiển thị thông báo nếu danh sách trống --%>
        <tr>
          <td colspan="4">No data available</td>
        </tr>
        <% } %>

        </tbody>
      </table>
      <div class="table-pagination">
        <div class="flex items-center justify-between">
          <div class="buttons">
            <button type="button" class="button active">1</button>
            <button type="button" class="button">2</button>
            <button type="button" class="button">3</button>
          </div>
          <small>Page 1 of 3</small>
        </div>
      </div>
    </div>
  </div>
</section>
<%@ include file="/include/script.jsp"%>
<style>

  .btn-primary {
    color: rgb(245 157 57);
    background-color: rgb(251 226 197);
    border: none;
    /* border-top-left-radius: 10px !important; */
    /* border-bottom-right-radius: 10px !important; */
    border-radius: .357rem;
    border: none;
    font-weight: 600;
    padding: 5px 20px; /* Điều chỉnh kích thước theo ý muốn */
  }

  .edit-button {
    margin-top: 10px; /* Điều chỉnh giá trị margin-top theo ý muốn */
  }

  .btn-add {
    color: white;
    background-color: black;
    border: none;
    /* border-top-left-radius: 10px !important; */
    /* border-bottom-right-radius: 10px !important; */
    border-radius: .357rem;
    border: none;
    font-weight: 600;
    padding: 10px 20px; /* Điều chỉnh kích thước theo ý muốn */
  }

  .btn-danger {
    color: #FFF;
    background-color: #dc3545;
    border-color: #dc3545;
    border: none;
    /* border-top-left-radius: 10px !important; */
    /* border-bottom-right-radius: 10px !important; */
    border-radius: .357rem;
    border: none;
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
    margin-right: 10px; /* Khoảng cách giữa các nút */
  }
</style>
</body>
</html>
