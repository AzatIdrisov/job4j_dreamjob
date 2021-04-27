<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="ru.job4j.dream.store.Store" %>
<%@ page import="ru.job4j.dream.model.Candidate" %>
<%@ page import="java.util.Collection" %>
<%@ page import="ru.job4j.dream.store.PsqlStore" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    <title>Работа мечты</title>
</head>
<body>
<%
    HashMap<String, String> images = new HashMap<>();
    for (File name : new File("C:\\images\\").listFiles()) {
        images.put(name.getName().substring(0, name.getName().indexOf('.')),name.getName());
    }
%>
<div class="container pt-3">

    <div class="row">
        <div class="card" style="width: 100%">
            <div class="row">
                <ul class="nav">
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/posts.do">Вакансии</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/candidates.do">Кандидаты</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/post/edit.jsp">Добавить вакансию</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/candidate/edit.jsp">Добавить кандидата</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/login.jsp"> <c:out value="${user.name}"/> | Выйти</a>
                    </li>
                </ul>
            </div>
            <div class="card-header">
                Кандидаты
            </div>
            <div class="card-body">
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">Названия</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for(Candidate candidate: PsqlStore.instOf().findAllCandidates()) { %>
                        <tr>
                            <td>
                                <a href="<%=request.getContextPath()%>/candidate/edit.jsp?id=<%=candidate.getId()%>">
                                    <i class="fa fa-edit mr-3"></i>
                                </a>
                                <%=candidate.getName()%>
                            </td>
                            <td>
                                <%
                                    if (!images.containsKey(String.valueOf(candidate.getId()))){
                                %>
                                <div class="card-body">
                                    <form action="<%=request.getContextPath()%>/upload.jsp?id=<%=candidate.getId()%>" method="post">
                                        <button type="submit" class="btn btn-primary">Добавить фото</button>
                                    </form>
                                </div>
                                <% } else { %>
                                        <img src="<%=request.getContextPath()%>/download?name=<%=images.get(String.valueOf(candidate.getId()))%>" width="100px" height="100px"/>
                                <% } %>
                            </td>
                            <td>
                                <div class="card-body">
                                    <form action="<%=request.getContextPath()%>/delete?id=<%=candidate.getId()%>" method="post">
                                        <button type="submit" class="btn btn-primary">Удалить</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>