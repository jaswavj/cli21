<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    response.setHeader("Cache-Control","no-cache");
    response.setContentType("application/json");
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) { response.setStatus(401); out.print("{\"error\":\"Session expired.\"}"); return; }
    try {
        int billId = Integer.parseInt(request.getParameter("billId"));
        java.util.Vector result = bill.getTransportBillPaymentHistory(billId);
        if (result.isEmpty()) { out.print("{\"error\":\"Bill not found.\"}"); return; }

        java.util.Vector hdr      = (java.util.Vector) result.get(0);
        java.util.Vector payments = (java.util.Vector) result.get(1);

        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"billId\":\"").append(hdr.get(0)).append("\",");
        sb.append("\"invoiceNo\":\"").append(esc(hdr.get(1).toString())).append("\",");
        sb.append("\"billDate\":\"").append(esc(hdr.get(2).toString())).append("\",");
        sb.append("\"customerName\":\"").append(esc(hdr.get(3).toString())).append("\",");
        sb.append("\"grandTotal\":\"").append(hdr.get(4)).append("\",");
        sb.append("\"paidAmount\":\"").append(hdr.get(5)).append("\",");
        sb.append("\"balance\":\"").append(hdr.get(6)).append("\",");
        sb.append("\"payments\":[");
        for (int i = 0; i < payments.size(); i++) {
            java.util.Vector p = (java.util.Vector) payments.get(i);
            if (i > 0) sb.append(",");
            sb.append("{");
            sb.append("\"id\":\"").append(p.get(0)).append("\",");
            sb.append("\"paymentType\":\"").append(p.get(1)).append("\",");
            sb.append("\"paymentMode\":\"").append(esc(p.get(2).toString())).append("\",");
            sb.append("\"paidAmount\":\"").append(p.get(3)).append("\",");
            sb.append("\"collectedBy\":\"").append(esc(p.get(4).toString())).append("\",");
            sb.append("\"collectedOn\":\"").append(esc(p.get(5).toString())).append("\"");
            sb.append("}");
        }
        sb.append("]}");
        out.print(sb.toString());
    } catch (Exception e) {
        out.print("{\"error\":\"" + (e.getMessage()!=null?e.getMessage().replace("\"","'"):"Error") + "\"}");
    }
%>
<%!
private String esc(String s) {
    if (s == null) return "";
    return s.replace("\\","\\\\").replace("\"","\\\"").replace("\n","\\n").replace("\r","");
}
%>
