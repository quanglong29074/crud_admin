<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.crud_admin.entity.Teacher" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.crud_admin.entity.ClassRoom" %>
<%
    Teacher teacher = (Teacher) request.getAttribute("teacher");
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
            <li>List of Events</li>
            <li>Edit Event</li>
        </ul>
    </div>
</section>

<section class="section main-section">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h3 class="tile-title">Edit Event</h3>
                <div class="tile-body">
                    <form action="<%= request.getContextPath() %>/teacher" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="edit"/>
                        <input type="hidden" name="id" value="<%= teacher.getIdTeacher() %>"/>

                        <div class="form-group col-md-3">
                            <label for="teacherName" class="control-label">Name</label>
                            <input id="teacherName" name="teacherName" class="form-control" value="<%= teacher.getTeacherName() %>" required />
                        </div>
                        <div class="form-group col-md-3">
                            <label for="description" class="control-label">Description</label>
                            <input type="text" id="description" name="description" class="form-control" value="<%= teacher.getDescription() %>" required />
                        </div>

                        <div class="form-group col-md-12">
                            <label for="thumbnail" class="control-label">Image</label>
                            <input type="file" id="thumbnail" name="thumbnail" class="form-control" onchange="displayThumbnail(this);" />
                            <img id="thumbnailImage" src="<%= request.getContextPath() %>/<%= teacher.getThumbnail() %>" style="max-width: 50%;" alt="Thumbnail image" />
                        </div>

                        <div class="form-group col-md-12">
                            <label for="classRoomId" class="control-label">Class Room ID</label>
                            <select class="form-control" id="classRoomId" name="classRoomId" required>
                                <option value="">Select Class Room</option>
                                <% for (ClassRoom classRoom : classRooms) { %>
                                <option value="<%= classRoom.getIdClass() %>" <%= (teacher.getClassRoom().getIdClass() == classRoom.getIdClass()) ? "selected" : "" %>><%= classRoom.getClassName() %></option>
                                <% } %>
                            </select>
                        </div>

                        <button style="margin-top:20px;" class="btn btn-save" type="submit">Save</button>
                        <a href="<%= request.getContextPath() %>/teacher" style="margin-top:20px;" class="btn btn-cancel">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    function displayThumbnail(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('thumbnailImage').src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
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
