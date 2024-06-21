<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 19/06/2024
  Time: 9:01 CH
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
            <li>List of Events</li>
            <li>Add Event</li>
        </ul>
    </div>
</section>
<section class="section main-section">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h3 class="tile-title">Add Event</h3>
                <div class="tile-body">
                    <form asp-controller="Events" asp-action="AddEvent" class="edit-event-form" method="post" enctype="multipart/form-data">


                        <div class="form-group col-md-3">
                            <label class="control-label">Title</label>
                            <input asp-for="EventTitle" class="form-control" name="EventTitle" placeholder="Title" />
                        </div>




                        <div class="form-group col-md-12">
                            <label class="control-label">Event Image</label>
                            <input type="file" name="EventImageUrl" class="form-control" asp-for="EventImageUrl" onchange="displayThumbnail(this);" />
                            <img id="thumbnailImage" style="display: none; max-width: 50%;" alt="Thumbnail image" />

                        </div>

                        <div class="form-group col-md-12">
                            <label class="control-label">Event Description</label>
                            <textarea class="form-control" name="EventDescription" asp-for="EventDescription"></textarea>
                        </div>

                        <button style="margin-top:20px;"class="btn btn-save" type="submit">Save</button>
                        <a class="btn btn-cancel" href="/Events/Event">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<script src="https://cdn.tiny.cloud/1/6a4ufu188x8itoqtz2agsuahgg475yn7bxva9xzabribtvjm/tinymce/5/tinymce.min.js"></script>
<script>
    tinymce.init({
        selector: 'textarea[name="EventDescription"]'
    });</script>
<script>
    function displayThumbnail(input) {
        var thumbnailImage = document.getElementById('thumbnailImage');
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                thumbnailImage.src = e.target.result;
                thumbnailImage.style.display = 'block';
            };
            reader.readAsDataURL(input.files[0]);
        }
    }</script>
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
        border: none;
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
    .error-message {
        color: red;
        font-size: 15px;
    }
</style>

<%@ include file="/include/script.jsp"%>
</body>
</html>
