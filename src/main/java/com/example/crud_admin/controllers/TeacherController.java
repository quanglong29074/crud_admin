package com.example.crud_admin.controllers;

import com.example.crud_admin.entity.Teacher;
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
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/teacher")
@MultipartConfig
public class TeacherController extends HttpServlet {
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
            // Get the teacher ID from the request
            String teacherIdStr = request.getParameter("id");
            if (teacherIdStr != null && !teacherIdStr.isEmpty()) {
                int teacherId = Integer.parseInt(teacherIdStr);

                // Find the teacher in the database by ID
                Teacher teacherToEdit = entityManager.find(Teacher.class, teacherId);
                if (teacherToEdit != null) {
                    // Get the list of classrooms to display in the select box
                    List<ClassRoom> classRooms = entityManager.createQuery("SELECT c FROM ClassRoom c", ClassRoom.class).getResultList();

                    // Set attributes for the request
                    request.setAttribute("teacher", teacherToEdit);
                    request.setAttribute("classRooms", classRooms);

                    // Forward to the JSP for editing the teacher
                    request.getRequestDispatcher("/jsp/Teacher/editTeacher.jsp").forward(request, response);
                    return;
                }
            }
        }

        // Pagination parameters
        int page = 1;
        int pageSize = 5;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Fetch the paginated teachers from the database
        List<Teacher> teacherList = entityManager.createQuery("SELECT t FROM Teacher t", Teacher.class)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();

        // Get total number of teachers
        long totalTeachers = (long) entityManager.createQuery("SELECT COUNT(t) FROM Teacher t")
                .getSingleResult();
        int totalPages = (int) Math.ceil((double) totalTeachers / pageSize);

        // Set attributes for the request
        request.setAttribute("teacherList", teacherList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Forward to the JSP to display the teacher list
        request.getRequestDispatcher("/jsp/Teacher/teacher.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("edit")) {
            // Get the teacher ID from the request
            String teacherIdStr = request.getParameter("id");
            if (teacherIdStr != null && !teacherIdStr.isEmpty()) {
                int teacherId = Integer.parseInt(teacherIdStr);

                entityManager.getTransaction().begin();

                // Find the teacher in the database by ID
                Teacher teacherToEdit = entityManager.find(Teacher.class, teacherId);
                if (teacherToEdit != null) {
                    // Update the teacher's information
                    teacherToEdit.setTeacherName(request.getParameter("teacherName"));
                    teacherToEdit.setDescription(request.getParameter("description"));

                    String classRoomIdStr = request.getParameter("classRoomId");
                    if (classRoomIdStr != null && !classRoomIdStr.isEmpty()) {
                        int classRoomId = Integer.parseInt(classRoomIdStr);
                        ClassRoom classRoom = entityManager.find(ClassRoom.class, classRoomId);
                        teacherToEdit.setClassRoom(classRoom);
                    }

                    Part filePart = request.getPart("thumbnail");
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = filePart.getSubmittedFileName();
                        String uploadPath = request.getServletContext().getRealPath("/") + "img";

                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        String filePath = uploadPath + File.separator + fileName;
                        filePart.write(filePath);
                        teacherToEdit.setThumbnail("img/" + fileName);
                    }

                    entityManager.merge(teacherToEdit);
                }

                entityManager.getTransaction().commit();
            }

            // After editing, redirect to the teacher list page
            response.sendRedirect(request.getContextPath() + "/teacher");
        } else if (action != null && action.equals("delete")) {
            // Get the teacher ID from the request
            String teacherIdStr = request.getParameter("id");
            if (teacherIdStr != null && !teacherIdStr.isEmpty()) {
                int teacherId = Integer.parseInt(teacherIdStr);

                entityManager.getTransaction().begin();

                // Find the teacher in the database by ID and delete it
                Teacher teacherToDelete = entityManager.find(Teacher.class, teacherId);
                if (teacherToDelete != null) {
                    entityManager.remove(teacherToDelete);
                }

                entityManager.getTransaction().commit();
            }

            // After deletion, redirect to the teacher list page
            response.sendRedirect(request.getContextPath() + "/teacher");
        }
    }

    @Override
    public void destroy() {
        entityManager.close();
        entityManagerFactory.close();
    }
}
