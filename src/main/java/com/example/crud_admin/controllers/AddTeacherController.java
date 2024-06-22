package com.example.crud_admin.controllers;

import com.example.crud_admin.entity.ClassRoom;
import com.example.crud_admin.entity.Teacher;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.List;
import java.io.File;
import java.io.IOException;

@WebServlet("/addTeacher")
@MultipartConfig // Đảm bảo servlet có thể xử lý tệp tải lên
public class AddTeacherController extends HttpServlet {
    private EntityManagerFactory entityManagerFactory;
    private EntityManager entityManager;

    @Override
    public void init() {
        entityManagerFactory = Persistence.createEntityManagerFactory("default");
        entityManager = entityManagerFactory.createEntityManager();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve EntityManager and fetch ClassRoom list
        List<ClassRoom> classRooms = entityManager.createQuery("SELECT c FROM ClassRoom c", ClassRoom.class).getResultList();

        // Set the list as an attribute in request scope
        req.setAttribute("classRooms", classRooms);

        // Forward to the JSP form
        req.getRequestDispatcher("/jsp/Teacher/addTeacher.jsp").forward(req, resp);
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String teacherName = request.getParameter("teacherName");
        String description = request.getParameter("description");
        Part filePart = request.getPart("thumbnail");

        if (filePart != null) {
            String fileName = filePart.getSubmittedFileName();

            // Lấy đường dẫn tương đối tới thư mục webapp/img
            String uploadPath = request.getServletContext().getRealPath("/") + "img";

            File uploadDir = new File(uploadPath);

            // Tạo thư mục nếu chưa tồn tại
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Lưu file vào thư mục webapp/img
            filePart.write(uploadPath + File.separator + fileName);

            // Log đường dẫn lưu file
            System.out.println("File Path: " + uploadPath + File.separator + fileName);

            // Lấy classRoom từ request (giả sử bạn có ID của classRoom)
            int classRoomId = Integer.parseInt(request.getParameter("classRoomId"));
            ClassRoom classRoom = entityManager.find(ClassRoom.class, classRoomId);

            // Tạo đối tượng Teacher mới
            Teacher teacher = new Teacher();
            teacher.setTeacherName(teacherName);
            teacher.setDescription(description);
            teacher.setThumbnail("img/" + fileName);
            teacher.setClassRoom(classRoom);

            // Lưu vào cơ sở dữ liệu
            entityManager.getTransaction().begin();
            entityManager.persist(teacher);
            entityManager.getTransaction().commit();

            // Chuyển hướng về danh sách giáo viên
            response.sendRedirect("teacher");
        } else {
            // Xử lý trường hợp filePart null
            response.getWriter().println("File upload failed, please try again.");
        }
    }


    @Override
    public void destroy() {
        entityManager.close();
        entityManagerFactory.close();
    }
}
