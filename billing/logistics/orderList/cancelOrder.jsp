<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    response.setHeader("Cache-Control", "no-cache");
    try {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) { out.print("Session expired"); return; }

        int id = Integer.parseInt(request.getParameter("id").trim());

        int updated = bill.cancelLogisticsOrder(id, userId);
        if (updated > 0) {
            out.print("OK");
        } else {
            out.print("Order not found or already billed.");
        }
    } catch (NumberFormatException e) {
        out.print("Invalid input: " + e.getMessage());
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
