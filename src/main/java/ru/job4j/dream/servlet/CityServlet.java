package ru.job4j.dream.servlet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import ru.job4j.dream.store.MemCityStore;
import ru.job4j.dream.store.PsqlCityStore;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class CityServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        PrintWriter writer = resp.getWriter();
        JSONObject obj = new JSONObject();
        JSONArray arr = new JSONArray();
        for (String city : PsqlCityStore.instOf().getAll()) {
            JSONObject cityJSON = new JSONObject();
            cityJSON.put("city", city);
            arr.add(cityJSON);
        }
        obj.put("items", arr);
        writer.print(obj.toJSONString());
        writer.flush();
    }
}
