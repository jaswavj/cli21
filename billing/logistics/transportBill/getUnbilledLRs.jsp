<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

if (session.getAttribute("userId") == null) {
    response.setStatus(401);
    out.print("[]");
    return;
}

try {
    Vector rows = bill.getUnbilledLRList();

    // Escape values for safe JSON output, including multiline text.
    java.util.function.Function<String, String> escJson = (val) -> {
        if (val == null) return "";
        return val.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\r", "\\r")
                  .replace("\n", "\\n")
                  .replace("\t", "\\t");
    };

    StringBuilder sb = new StringBuilder("[");
    for (int i = 0; i < rows.size(); i++) {
        Vector row = (Vector) rows.get(i);
        // LR No can be multiline (TEXT); keep line breaks escaped for valid JSON.
        String lrNo      = escJson.apply(row.get(1).toString());
        String lrDate    = row.get(2).toString();
        String custName  = escJson.apply(row.get(3).toString());
        String dest      = escJson.apply(row.get(4).toString());
        double dpf       = Double.parseDouble(row.get(5).toString());

        // Format lr_date from yyyy-MM-dd to dd-MM-yyyy for display
        String lrDateDisplay = lrDate;
        try {
            java.text.SimpleDateFormat inFmt  = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.text.SimpleDateFormat outFmt = new java.text.SimpleDateFormat("dd-MM-yyyy");
            lrDateDisplay = outFmt.format(inFmt.parse(lrDate));
        } catch (Exception _e) {}

        if (i > 0) sb.append(",");
        sb.append("{") 
          .append("\"id\":").append(row.get(0).toString()).append(",")
          .append("\"lrNo\":\"").append(lrNo).append("\",")
          .append("\"lrDate\":\"").append(lrDateDisplay).append("\",")
          .append("\"customerName\":\"").append(custName).append("\",")
          .append("\"destination\":\"").append(dest).append("\",")
          .append("\"dpf\":").append(dpf).append(",")
          .append("\"customerId\":").append(row.get(6).toString())
          .append("}");
    }
    sb.append("]");
    out.print(sb.toString());
} catch (Exception e) {
    response.setStatus(500);
    out.print("[]");
}
%>
