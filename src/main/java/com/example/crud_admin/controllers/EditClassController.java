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

@WebServlet("/editClass")
public class EditClassController extends HttpServlet {
    EntityManagerFactory entityManagerFactory;
    EntityManager entityManager;

    @Override
    public void init() throws ServletException {
        entityManagerFactory = Persistence.createEntityManagerFactory("default");
        entityManager = entityManagerFactory.createEntityManager();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idClass = Integer.parseInt(req.getParameter("id"));
        ClassRoom classRoom = entityManager.find(ClassRoom.class, idClass);
        req.setAttribute("classRoom", classRoom);
        req.getRequestDispatcher("/jsp/ClassRoom/editClass.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idClass = Integer.parseInt(req.getParameter("id"));
        String className = req.getParameter("className");
        int numberMember = Integer.parseInt(req.getParameter("numberMember"));

        entityManager.getTransaction().begin();
        ClassRoom classRoom = entityManager.find(ClassRoom.class, idClass);
        if (classRoom != null) {
            classRoom.setClassName(className);
            classRoom.setNumberMember(numberMember);
            entityManager.merge(classRoom);
        }
        entityManager.getTransaction().commit();

        resp.sendRedirect(req.getContextPath() + "/class");
    }
}
