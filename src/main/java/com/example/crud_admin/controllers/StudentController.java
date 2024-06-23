package com.example.crud_admin.controllers;

import com.example.crud_admin.entity.Student;
import com.example.crud_admin.entity.ClassRoom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/student")
@MultipartConfig
public class StudentController extends HttpServlet {
    private EntityManagerFactory entityManagerFactory;
    private EntityManager entityManager;

    @Override
    public void init() {
        entityManagerFactory = Persistence.createEntityManagerFactory("default");
        entityManager = entityManagerFactory.createEntityManager();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("edit")) {
            String studentIdStr = request.getParameter("id");
            if (studentIdStr != null && !studentIdStr.isEmpty()) {
                int studentId = Integer.parseInt(studentIdStr);
                Student studentToEdit = entityManager.find(Student.class, studentId);
                if (studentToEdit != null) {
                    List<ClassRoom> classRooms = entityManager.createQuery("SELECT c FROM ClassRoom c", ClassRoom.class).getResultList();
                    request.setAttribute("student", studentToEdit);
                    request.setAttribute("classRooms", classRooms);
                    request.getRequestDispatcher("/jsp/Student/editStudent.jsp").forward(request, response);
                    return;
                }
            }
        }

        int page = 1;
        int pageSize = 5;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        List<Student> studentList = entityManager.createQuery("SELECT s FROM Student s", Student.class)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();

        long totalStudents = (long) entityManager.createQuery("SELECT COUNT(s) FROM Student s")
                .getSingleResult();
        int totalPages = (int) Math.ceil((double) totalStudents / pageSize);

        request.setAttribute("studentList", studentList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/jsp/Student/student.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("edit")) {
            String studentIdStr = request.getParameter("id");
            if (studentIdStr != null && !studentIdStr.isEmpty()) {
                int studentId = Integer.parseInt(studentIdStr);

                entityManager.getTransaction().begin();

                Student studentToEdit = entityManager.find(Student.class, studentId);
                if (studentToEdit != null) {
                    studentToEdit.setFirstName(request.getParameter("firstName"));
                    studentToEdit.setLastName(request.getParameter("lastName"));
                    studentToEdit.setEmail(request.getParameter("email"));

                    String classRoomIdStr = request.getParameter("classRoomId");
                    if (classRoomIdStr != null && !classRoomIdStr.isEmpty()) {
                        int classRoomId = Integer.parseInt(classRoomIdStr);
                        ClassRoom classRoom = entityManager.find(ClassRoom.class, classRoomId);
                        studentToEdit.setClassRoom(classRoom);
                    }

                    entityManager.merge(studentToEdit);
                }

                entityManager.getTransaction().commit();
            }

            response.sendRedirect(request.getContextPath() + "/student");
        } else if (action != null && action.equals("delete")) {
            String studentIdStr = request.getParameter("id");
            if (studentIdStr != null && !studentIdStr.isEmpty()) {
                int studentId = Integer.parseInt(studentIdStr);

                entityManager.getTransaction().begin();

                Student studentToDelete = entityManager.find(Student.class, studentId);
                if (studentToDelete != null) {
                    entityManager.remove(studentToDelete);
                }

                entityManager.getTransaction().commit();
            }

            response.sendRedirect(request.getContextPath() + "/student");
        }
    }

    @Override
    public void destroy() {
        entityManager.close();
        entityManagerFactory.close();
    }
}
