<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%!
String jsonEsc(String s) {
    if (s == null) return "";
    return s.replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\r", "\\r")
            .replace("\n", "\\n")
            .replace("\t", "\\t");
}

String jsonStr(Object o) {
    return jsonEsc(o == null ? "" : o.toString());
}
%>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        out.print("{\"status\":\"ERROR\",\"message\":\"Session expired\"}");
        return;
    }

    String lrNo = request.getParameter("lrNo");
    if (lrNo == null || lrNo.trim().isEmpty()) {
        out.print("{\"status\":\"ERROR\",\"message\":\"LR no required\"}");
        return;
    }

    try {
        Vector row = bill.getLrCopyByLrNo(lrNo.trim());
        if (row.isEmpty()) {
            out.print("{\"status\":\"ERROR\",\"message\":\"LR not found\"}");
            return;
        }

        String modePayment1 = row.get(13).toString();
        boolean toBeBilledInChennai = modePayment1.toLowerCase().contains("billed in chennai");

        StringBuilder json = new StringBuilder();
        json.append("{\"status\":\"OK\",");
        json.append("\"id\":").append(row.get(0)).append(",");
        json.append("\"lrNo\":\"").append(jsonStr(row.get(1))).append("\",");
        json.append("\"customerId\":").append(row.get(2)).append(",");
        json.append("\"customerName\":\"").append(jsonStr(row.get(3))).append("\",");
        json.append("\"phoneNumber\":\"").append(jsonStr(row.get(4))).append("\",");
        json.append("\"lrDate\":\"").append(jsonStr(row.get(5))).append("\",");
        json.append("\"truckNo\":\"").append(jsonStr(row.get(6))).append("\",");
        json.append("\"fromLocation\":\"").append(jsonStr(row.get(7))).append("\",");
        json.append("\"toLocation\":\"").append(jsonStr(row.get(8))).append("\",");
        json.append("\"consigneeName\":\"").append(jsonStr(row.get(9))).append("\",");
        json.append("\"noOfArticles\":\"").append(jsonStr(row.get(10))).append("\",");
        json.append("\"descriptionText\":\"").append(jsonStr(row.get(11))).append("\",");
        json.append("\"weightMt\":\"").append(jsonStr(row.get(12))).append("\",");
        json.append("\"modePayment1\":\"").append(jsonStr(row.get(13))).append("\",");
        json.append("\"toBeBilledInChennai\":").append(toBeBilledInChennai ? "true" : "false").append(",");
        json.append("\"freightAmount\":\"").append(jsonStr(row.get(14))).append("\",");
        json.append("\"toPayAmount\":\"").append(jsonStr(row.get(15))).append("\",");
        json.append("\"paidAmount\":\"").append(jsonStr(row.get(16))).append("\",");
        json.append("\"amountInWords\":\"").append(jsonStr(row.get(17))).append("\",");
        json.append("\"dcNo\":\"").append(jsonStr(row.get(18))).append("\",");
        json.append("\"invDate\":\"").append(jsonStr(row.get(19))).append("\",");
        json.append("\"invNo\":\"").append(jsonStr(row.get(20))).append("\",");
        json.append("\"invDate2\":\"").append(jsonStr(row.get(21))).append("\",");
        json.append("\"declaredValueRs\":\"").append(jsonStr(row.get(22))).append("\",");
        json.append("\"pnlSealNo\":\"").append(jsonStr(row.get(23))).append("\",");
        json.append("\"materialReceivedDate\":\"").append(jsonStr(row.get(24))).append("\",");
        json.append("\"pnlNo\":\"").append(jsonStr(row.get(25))).append("\",");
        json.append("\"driverName\":\"").append(jsonStr(row.get(26))).append("\",");
        json.append("\"vehicleType\":\"").append(jsonStr(row.get(27))).append("\",");
        json.append("\"deliverIn\":\"").append(jsonStr(row.get(28))).append("\",");
        json.append("\"entryUser\":").append(row.get(29)).append(",");
        json.append("\"entryDateTime\":\"").append(jsonStr(row.get(30))).append("\",");
        json.append("\"isCancelled\":").append(row.get(31)).append(",");
        json.append("\"cancelUid\":").append(row.get(32)).append(",");
        json.append("\"cancelDateTime\":\"").append(jsonStr(row.get(33))).append("\"}");
        out.print(json.toString());
    } catch (Exception e) {
        String msg = e.getMessage() == null ? "Error fetching LR" : e.getMessage();
        out.print("{\"status\":\"ERROR\",\"message\":\"" + jsonEsc(msg) + "\"}");
    }
%>
