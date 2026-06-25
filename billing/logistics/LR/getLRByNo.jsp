<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
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

        StringBuilder json = new StringBuilder();
        json.append("{\"status\":\"OK\",");
        json.append("\"id\":").append(row.get(0)).append(",");
        json.append("\"lrNo\":\"").append(row.get(1)).append("\",");
        json.append("\"customerId\":").append(row.get(2)).append(",");
        json.append("\"customerName\":\"").append(row.get(3).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"phoneNumber\":\"").append(row.get(4).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"lrDate\":\"").append(row.get(5)).append("\",");
        json.append("\"truckNo\":\"").append(row.get(6).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"fromLocation\":\"").append(row.get(7).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"toLocation\":\"").append(row.get(8).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"consigneeName\":\"").append(row.get(9).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"noOfArticles\":\"").append(row.get(10).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"descriptionText\":\"").append(row.get(11).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"weightMt\":\"").append(row.get(12).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"modePayment1\":\"").append(row.get(13).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"freightAmount\":\"").append(row.get(14).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"toPayAmount\":\"").append(row.get(15).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"paidAmount\":\"").append(row.get(16).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"amountInWords\":\"").append(row.get(17).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"dcNo\":\"").append(row.get(18).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"invDate\":\"").append(row.get(19)).append("\",");
        json.append("\"invNo\":\"").append(row.get(20).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"invDate2\":\"").append(row.get(21)).append("\",");
        json.append("\"declaredValueRs\":\"").append(row.get(22).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"pnlSealNo\":\"").append(row.get(23).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"materialReceivedDate\":\"").append(row.get(24)).append("\",");
        json.append("\"pnlNo\":\"").append(row.get(25).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"driverName\":\"").append(row.get(26).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"vehicleType\":\"").append(row.get(27).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"deliverIn\":\"").append(row.get(28).toString().replace("\\", "\\\\").replace("\"", "\\\"")).append("\",");
        json.append("\"entryUser\":").append(row.get(29)).append(",");
        json.append("\"entryDateTime\":\"").append(row.get(30)).append("\",");
        json.append("\"isCancelled\":").append(row.get(31)).append(",");
        json.append("\"cancelUid\":").append(row.get(32)).append(",");
        json.append("\"cancelDateTime\":\"").append(row.get(33)).append("\"}");
        out.print(json.toString());
    } catch (Exception e) {
        String msg = e.getMessage() == null ? "Error fetching LR" : e.getMessage();
        msg = msg.replace("\\", "\\\\").replace("\"", "\\\"");
        out.print("{\"status\":\"ERROR\",\"message\":\"" + msg + "\"}");
    }
%>
