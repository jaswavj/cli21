<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    response.setHeader("Cache-Control", "no-cache");
    try {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            out.print("Session expired");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id").trim());
        int updated = bill.cancelLrCopy(id, userId);
        if (updated > 0) {
            out.print("OK");
        } else {
            out.print("Unable to cancel LR");
        }
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
