<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.setStatus(401);
        out.print("[]");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    String term = request.getParameter("term");

    Vector rows = new Vector();
    try {
        rows = bill.getLrCopyCustomerAutocomplete(term);
    } catch (Exception e) {
        out.print("[]");
        return;
    }

    StringBuilder json = new StringBuilder("[");
    for (int i = 0; i < rows.size(); i++) {
        Vector r = (Vector) rows.get(i);
        String id = r.get(0).toString();
        String name = r.get(1).toString();
        String phone = r.get(2).toString();

        name = name.replace("\\", "\\\\").replace("\"", "\\\"");
        phone = phone.replace("\\", "\\\\").replace("\"", "\\\"");

        if (i > 0) json.append(",");
        json.append("{\"id\":").append(id)
            .append(",\"label\":\"").append(name).append("\"")
            .append(",\"phone\":\"").append(phone).append("\"}");
    }
    json.append("]");
    out.print(json.toString());
%>
