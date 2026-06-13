<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    response.setHeader("Cache-Control", "no-cache");
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) { out.print("Session expired"); return; }
    try {
        int billId = Integer.parseInt(request.getParameter("billId").trim());
        int rows = bill.cancelTransportBill(billId, userId);
        out.print(rows > 0 ? "OK" : "Bill not found or already cancelled.");
    } catch (NumberFormatException e) {
        out.print("Invalid input.");
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
