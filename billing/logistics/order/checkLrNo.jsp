<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    response.setHeader("Cache-Control", "no-cache");
    String lrNo = request.getParameter("lrNo");
    if (lrNo != null && !lrNo.trim().isEmpty()) {
        boolean exists = bill.checkLrNoExists(lrNo.trim());
        out.print(exists ? "EXISTS" : "OK");
    } else {
        out.print("OK");
    }
%>
