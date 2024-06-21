<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 19/06/2024
  Time: 8:50 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
          <th class="checkbox-cell">
            <label class="checkbox">
              <input type="checkbox">
              <span class="check"></span>
            </label>
          </th>
          <th class="image-cell"></th>
          <th>Name</th>
          <th>Company</th>
          <th>City</th>
          <th>Progress</th>
          <th>Created</th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td class="checkbox-cell">
            <label class="checkbox">
              <input type="checkbox">
              <span class="check"></span>
            </label>
          </td>
          <td class="image-cell">
            <div class="image">
              <img src="https://avatars.dicebear.com/v2/initials/rebecca-bauch.svg" class="rounded-full">
            </div>
          </td>
          <td data-label="Name">Rebecca Bauch</td>
          <td data-label="Company">Daugherty-Daniel</td>
          <td data-label="City">South Cory</td>
          <td data-label="Progress" class="progress-cell">
            <progress max="100" value="79">79</progress>
          </td>
          <td data-label="Created">
            <small class="text-gray-500" title="Oct 25, 2021">Oct 25, 2021</small>
          </td>
          <td class="actions-cell">
            <div class="buttons right nowrap">
              <button class="button small blue --jb-modal"  data-target="sample-modal-2" type="button">
                <span class="icon"><i class="mdi mdi-eye"></i></span>
              </button>
              <button class="button small red --jb-modal" data-target="sample-modal" type="button">
                <span class="icon"><i class="mdi mdi-trash-can"></i></span>
              </button>
            </div>
          </td>
        </tr>

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
