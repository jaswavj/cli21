<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    response.setHeader("Cache-Control","no-cache");
    response.setContentType("text/plain");
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) { response.setStatus(401); out.print("Session expired."); return; }
    try {
        int    billId  = Integer.parseInt(request.getParameter("billId"));
        double payNow  = Double.parseDouble(request.getParameter("payNow"));
        int    payType = Integer.parseInt(request.getParameter("payType"));
        int    payMode = Integer.parseInt(request.getParameter("payMode"));
        String result  = bill.saveTransportBalancePayment(billId, payNow, payType, payMode, userId);
        out.print(result);
    } catch (Exception e) {
        out.print(e.getMessage() != null ? e.getMessage() : "Error saving payment.");
    }
%>
