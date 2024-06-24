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

@WebServlet("/class")
public class ClassController extends HttpServlet {
    EntityManagerFactory entityManagerFactory;
    EntityManager entityManager;

    @Override
    public void init() throws ServletException {
        entityManagerFactory = Persistence.createEntityManagerFactory("default");
        entityManager = entityManagerFactory.createEntityManager();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var classRooms = entityManager.createQuery("SELECT c FROM ClassRoom c", ClassRoom.class).getResultList();
        req.setAttribute("classRooms", classRooms);
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
