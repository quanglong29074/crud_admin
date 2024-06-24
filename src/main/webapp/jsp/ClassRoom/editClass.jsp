<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 19/06/2024
  Time: 9:01 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.crud_admin.entity.ClassRoom" %>
<html>
<head>
  <%@ include file="/include/head.jsp"%>
</head>
<body>
<%@ include file="/include/navbar.jsp"%>
<style>
  .row {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px;
  }

  .col-md-12 {
    -webkit-box-flex: 0;
    -ms-flex: 0 0 100%;
    flex: 0 0 100%;
    max-width: 100%;
  }

  .form-control {
    display: block;
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
    -webkit-transition: border-color 0.15s ease-in-out, -webkit-box-shadow 0.15s ease-in-out;
    transition: border-color 0.15s ease-in-out, -webkit-box-shadow 0.15s ease-in-out;
    -o-transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out, -webkit-box-shadow 0.15s ease-in-out;
  }

  .control-label {
    font-weight: 600;
    color: black;
  }

  .btn-save {
    background-color: rgb(166 236 171);
    color: rgb(1 123 10);
    /* width: 100px; */
    font-weight: 600;
    letter-spacing: 1px;
    border-radius: .357rem;
    border: none;
    padding: 5px 20px;
    margin-top: 10px;
  }

  .btn-cancel {
    background-color: rgb(255 197 197);
    color: rgb(190, 40, 40);
    /* width: 100px; */
    font-weight: 600;
    letter-spacing: 1px;
    border: none;
    border-radius: .357rem;
    border: none;
    padding: 8px 20px;
    margin-top: 10px;
  }

  .main-section {
    margin-left: 15px;
  }
</style>
<section class="is-title-bar">
  <div class="flex flex-col md:flex-row items-center justify-between space-y-6 md:space-y-0">
    <ul>
      <li>List of Class Room</li>
      <li>Edit Class Room</li>
    </ul>
  </div>
</section>
<section class="section main-section">
  <div class="row">
    <div class="col-md-12">
      <div class="tile">

        <div class="tile-body">
          <%
            ClassRoom classRoom = (ClassRoom) request.getAttribute("classRoom");
          %>
          <form class="edit-product-form" action="editClass"  method="post" >
            <!-- Trường ẩn để chứa FacilitiesId -->
            <input type="hidden" name="id" value="<%= classRoom.getIdClass() %>">

            <div class="form-group col-md-3">
              <label class="control-label">Class name </label>
              <input type="text" class="form-control" name="className" placeholder="Class name" value="<%= classRoom.getClassName() %>">
            </div>

            <div class="form-group col-md-3">
              <label class="control-label">Member number</label>
              <input type="number" class="form-control" name="numberMember" placeholder="Number of members" value="<%= classRoom.getNumberMember() %>">
            </div>


            <button class="btn btn-save" type="submit">Save</button>
            <a class="btn btn-cancel" href="class">Cancel</a>
          </form>

        </div>
      </div>
    </div>
  </div>
</section>

<%@ include file="/include/script.jsp"%>
</body>
</html>
