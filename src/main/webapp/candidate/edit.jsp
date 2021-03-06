<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="ru.job4j.dream.store.PsqlStore" %>
<%@ page import="ru.job4j.dream.model.Candidate" %>
<%@ page import="ru.job4j.dream.model.User" %>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        $(document).ready(
            function() {
                $.ajax({
                    type: 'GET',
                    url: 'http://localhost:8080/dreamjob/city',
                    contentType: 'application/json',
                    dataType: 'json'
                })
                    .done(function(response) {
                        let options = "";
                        let items = response.items;
                        for (let i = 0; i < items.length; i++) {
                            options += "<option value=\"" + items[i].city + "\">" + items[i].city + "</option>"
                        }
                        $('#city').html(options);
                    })
                    .fail(function(err) {
                        alert(err);
                    });
            })
    </script>
    <script>
        function validate() {
            let result = true;
            let fields = [];
            if($('#name').val() == '') {
                fields.push('??????');
                result = false
            }
            if($('#city').val() == 'Empty') {
                fields.push('??????????');
                result = false
            }
            if (fields.length > 0) {
                let msg = fields[0];
                for (let i = 1; i < fields.length; ++i) {
                    msg += ', ' + fields[i];
                }
                msg += ' ???? ??????????????????';
                alert(msg);
            }
            return result;
        }
    </script>

    <title>???????????? ??????????</title>
</head>
<body>
<%
    String id = request.getParameter("id");
    Candidate candidate = new Candidate(0, "", 0);
    if (id != null) {
        candidate = PsqlStore.instOf().findCandidateById(Integer.valueOf(id));
    }
    User user = (User) request.getSession().getAttribute("user");
%>
<div class="container pt-3">
    <div class="row">
        <div class="card" style="width: 100%">
            <div class="row">
                <ul class="nav">
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/posts.do">????????????????</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/candidates.do">??????????????????</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/post/edit.jsp">???????????????? ????????????????</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/candidate/edit.jsp">????????????????
                            ??????????????????</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/login.jsp"><%=user.getName()%> |
                            ??????????</a>
                    </li>
                </ul>
            </div>
            <div class="card-header">
                <% if (id == null) { %>
                ?????????? ????????????????
                <% } else { %>
                ???????????????????????????? ??????????????????
                <% } %>
            </div>
            <div class="card-body fw-light">
                <form action="<%=request.getContextPath()%>/candidates.do?id=<%=candidate.getId()%>" method="post">
                    <div class="form-group">
                        <label for="name">??????</label>
                        <input type="text" class="form-control" name="name" value="<%=candidate.getName()%>" id="name">
                    </div>
                    <div class="form-group">
                        <label for="city">??????????</label>
                        <select class="form-control" name="city" id="city">
                            <option selected value="empty">Empty</option>
                        </select>
                    </div>
                    <button type="submit" onclick="return validate()" class="btn btn-primary">??????????????????</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>