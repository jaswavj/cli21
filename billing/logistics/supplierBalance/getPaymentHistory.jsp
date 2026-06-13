<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    response.setHeader("Cache-Control","no-cache");
    response.setContentType("application/json");
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) { response.setStatus(401); out.print("{\"error\":\"Session expired.\"}"); return; }
    try {
        int lrId = Integer.parseInt(request.getParameter("lrId"));
        java.util.Vector result = bill.getSupplierPaymentHistory(lrId);
        if (result.isEmpty()) { out.print("{\"error\":\"LR order not found.\"}"); return; }

        java.util.Vector hdr  = (java.util.Vector) result.get(0);
        java.util.Vector pays = (java.util.Vector) result.get(1);

        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"lrId\":\"").append(hdr.get(0)).append("\",");
        sb.append("\"lrNo\":\"").append(esc(hdr.get(1).toString())).append("\",");
        sb.append("\"lrDate\":\"").append(esc(hdr.get(2).toString())).append("\",");
        sb.append("\"supplierName\":\"").append(esc(hdr.get(3).toString())).append("\",");
        sb.append("\"lh\":\"").append(hdr.get(4)).append("\",");
        sb.append("\"lhPaid\":\"").append(hdr.get(5)).append("\",");
        sb.append("\"lhBalance\":\"").append(hdr.get(6)).append("\",");
        sb.append("\"vehicleNo\":\"").append(esc(hdr.get(7).toString())).append("\",");
        sb.append("\"payments\":[");
        for (int i = 0; i < pays.size(); i++) {
            java.util.Vector p = (java.util.Vector) pays.get(i);
            if (i > 0) sb.append(",");
            sb.append("{");
            sb.append("\"id\":\"").append(p.get(0)).append("\",");
            sb.append("\"paymentType\":\"").append(p.get(1)).append("\",");
            sb.append("\"paymentMode\":\"").append(esc(p.get(2).toString())).append("\",");
            sb.append("\"paidAmount\":\"").append(p.get(3)).append("\",");
            sb.append("\"paidBy\":\"").append(esc(p.get(4).toString())).append("\",");
            sb.append("\"paidOn\":\"").append(esc(p.get(5).toString())).append("\"");
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
