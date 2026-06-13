<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    response.setHeader("Cache-Control", "no-cache");
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) { response.setStatus(401); out.print("{}"); return; }

    try {
        int lrId = Integer.parseInt(request.getParameter("lrId").trim());
        Vector result = bill.getTransportBillEditData(lrId);
        if (result.isEmpty()) { out.print("{\"error\":\"Not found\"}"); return; }

        Vector hdr     = (Vector) result.get(0);
        Vector details = (Vector) result.get(1);

        // hdr: [0]=billId [1]=invoiceNo [2]=poNo [3]=sacCode [4]=lrNo [5]=lrDate [6]=lrTotal [7]=dpf [8]=notes
        StringBuilder json = new StringBuilder("{");
        json.append("\"billId\":").append(hdr.get(0));
        json.append(",\"invoiceNo\":\"").append(esc(hdr.get(1).toString())).append("\"");
        json.append(",\"poNo\":\"").append(esc(hdr.get(2).toString())).append("\"");
        json.append(",\"sacCode\":\"").append(esc(hdr.get(3).toString())).append("\"");
        json.append(",\"lrNo\":\"").append(esc(hdr.get(4).toString())).append("\"");
        json.append(",\"lrDate\":\"").append(esc(hdr.get(5).toString())).append("\"");
        json.append(",\"lrTotal\":").append(hdr.get(6));
        json.append(",\"dpf\":").append(hdr.get(7));
        json.append(",\"notes\":\"").append(esc(hdr.get(8).toString())).append("\"");
        json.append(",\"details\":[");
        for (int i = 0; i < details.size(); i++) {
            Vector d = (Vector) details.get(i);
            if (i > 0) json.append(",");
            json.append("{\"id\":").append(d.get(0));
            json.append(",\"particular\":\"").append(esc(d.get(1).toString())).append("\"");
            json.append(",\"qty\":\"").append(esc(d.get(2).toString())).append("\"");
            json.append(",\"rateWt\":\"").append(esc(d.get(3).toString())).append("\"");
            json.append(",\"amount\":").append(d.get(4)).append("}");
        }
        json.append("]}");
        out.print(json.toString());
    } catch (Exception e) {
        out.print("{\"error\":\"" + esc(e.getMessage()) + "\"}");
    }
%>
<%!
private String esc(String s) {
    if (s == null) return "";
    return s.replace("\\","\\\\").replace("\"","\\\"").replace("\n","\\n").replace("\r","");
}
%>
