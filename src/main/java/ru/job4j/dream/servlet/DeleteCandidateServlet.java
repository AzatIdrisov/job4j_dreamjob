package ru.job4j.dream.servlet;

import ru.job4j.dream.model.Candidate;
import ru.job4j.dream.store.MemCityStore;
import ru.job4j.dream.store.PsqlCityStore;
import ru.job4j.dream.store.PsqlStore;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

public class DeleteCandidateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        int cityId = PsqlCityStore.instOf().getIdByName(req.getParameter("city"));
        PsqlStore.instOf().deleteCandidate(
                new Candidate(
                        Integer.valueOf(req.getParameter("id")),
                        "name",
                        cityId
                )
        );
        for (File name : new File("C:\\images\\").listFiles()) {
            String fileName = name.getName();
            if (Integer.valueOf(fileName.substring(0, fileName.indexOf('.'))).equals(Integer.valueOf(req.getParameter("id")))) {
                name.delete();
                break;
            }
        }
        resp.sendRedirect(req.getContextPath() + "/candidates.do");
    }
}
