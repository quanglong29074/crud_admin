package com.example.crud_admin.controllers;

import com.example.crud_admin.entity.ClassRoom;
import com.example.crud_admin.entity.Student;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/addStudent")
public class AddStudentController extends HttpServlet {
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
        req.getRequestDispatcher("/jsp/Student/addStudent.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        int classRoomId = Integer.parseInt(request.getParameter("classRoomId"));

        ClassRoom classRoom = entityManager.find(ClassRoom.class, classRoomId);

        // Tạo đối tượng Student mới
        Student student = new Student();
        student.setEmail(email);
        student.setFirstName(firstName);
        student.setLastName(lastName);
        student.setClassRoom(classRoom);

        // Lưu vào cơ sở dữ liệu
        entityManager.getTransaction().begin();
        entityManager.persist(student);
        entityManager.getTransaction().commit();

        // Chuyển hướng về danh sách sinh viên
        response.sendRedirect("student");
    }

    @Override
    public void destroy() {
        entityManager.close();
        entityManagerFactory.close();
    }
}
