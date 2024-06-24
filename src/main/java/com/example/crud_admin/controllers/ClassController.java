package com.example.crud_admin.controllers;

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

@WebServlet("/class")

@MultipartConfig
public class ClassController extends HttpServlet {
    private EntityManagerFactory entityManagerFactory;
    private EntityManager entityManager;

    @Override
    public void init() throws ServletException {
        entityManagerFactory = Persistence.createEntityManagerFactory("default");
        entityManager = entityManagerFactory.createEntityManager();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action != null && action.equals("edit")) {
            String classRoomIdStr = req.getParameter("id");
            if (classRoomIdStr != null && !classRoomIdStr.isEmpty()) {
                int classRoomId = Integer.parseInt(classRoomIdStr);
                ClassRoom classRoomToEdit = entityManager.find(ClassRoom.class, classRoomId);
                if (classRoomToEdit != null) {
                    req.setAttribute("classRoom", classRoomToEdit);
                    req.getRequestDispatcher("/jsp/ClassRoom/editClass.jsp").forward(req, resp);
                    return;
                }
            }
        }
        int page = 1;
        int pageSize = 5;
        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }

        // Fetch the paginated class rooms from the database
        List<ClassRoom> classRooms = entityManager.createQuery("SELECT c FROM ClassRoom c", ClassRoom.class)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();

        // Get the total number of class rooms
        long totalClassRooms = (long) entityManager.createQuery("SELECT COUNT(c) FROM ClassRoom c")
                .getSingleResult();
        int totalPages = (int) Math.ceil((double) totalClassRooms / pageSize);

        // Set attributes for the request
        req.setAttribute("classRooms", classRooms);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        // Forward to the JSP to display the class room list
        req.getRequestDispatcher("/jsp/ClassRoom/class.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("edit")) {
            String classRoomIdStr = request.getParameter("id");
            if (classRoomIdStr != null && !classRoomIdStr.isEmpty()) {
                int classRoomId = Integer.parseInt(classRoomIdStr);

                entityManager.getTransaction().begin();

                ClassRoom classRoomToEdit = entityManager.find(ClassRoom.class, classRoomId);
                if (classRoomToEdit != null) {
                    classRoomToEdit.setClassName(request.getParameter("className"));
                    classRoomToEdit.setNumberMember(Integer.parseInt(request.getParameter("numberMember")));
                    entityManager.merge(classRoomToEdit);
                }

                entityManager.getTransaction().commit();
            }

            response.sendRedirect(request.getContextPath() + "/class");
        } else if (action != null && action.equals("delete")) {
            String classRoomIdStr = request.getParameter("id");
            if (classRoomIdStr != null && !classRoomIdStr.isEmpty()) {
                int classRoomId = Integer.parseInt(classRoomIdStr);

                entityManager.getTransaction().begin();

                ClassRoom classRoomToDelete = entityManager.find(ClassRoom.class, classRoomId);
                if (classRoomToDelete != null) {
                    entityManager.remove(classRoomToDelete);
                }

                entityManager.getTransaction().commit();
            }

            response.sendRedirect(request.getContextPath() + "/class");
        }
    }

    @Override
    public void destroy() {
        entityManager.close();
        entityManagerFactory.close();
    }
}
