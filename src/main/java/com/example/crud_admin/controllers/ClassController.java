package com.example.crud_admin.controllers;

import com.example.crud_admin.entity.ClassRoom;
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

@WebServlet("/class")
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idClassStr = req.getParameter("id");

        if (idClassStr == null || idClassStr.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Class ID is missing or invalid.");
            return;
        }

        try {
            int idClass = Integer.parseInt(idClassStr.trim());

            entityManager.getTransaction().begin();
            ClassRoom classRoom = entityManager.find(ClassRoom.class, idClass);
            if (classRoom != null) {
                entityManager.remove(classRoom);
            }
            entityManager.getTransaction().commit();

            resp.sendRedirect(req.getContextPath() + "/class");
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Class ID is not a valid number.");
        }
    }

    @Override
    public void destroy() {
        entityManager.close();
        entityManagerFactory.close();
    }
}
