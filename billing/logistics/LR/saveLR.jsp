<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        out.print("{\"status\":\"ERROR\",\"message\":\"Session expired\"}");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    String idParam = request.getParameter("id");
    String customerIdParam = request.getParameter("customerId");
    String customerName = request.getParameter("customerName");
    String phoneNumber = request.getParameter("phoneNumber");
    String lrDate = request.getParameter("lrDate");
    String truckNo = request.getParameter("truckNo");
    String fromLocation = request.getParameter("fromLocation");
    String toLocation = request.getParameter("toLocation");
    String consigneeName = request.getParameter("consigneeName");

    String noOfArticles = request.getParameter("noOfArticles");
    String descriptionText = request.getParameter("descriptionText");
    String weightMt = request.getParameter("weightMt");

    String modePayment1 = "1".equals(request.getParameter("toBeBilledInChennai")) ? "To be billed in Chennai" : "";
    String freightAmount = request.getParameter("freightAmount");
    String toPayAmount = request.getParameter("toPayAmount");
    String paidAmount = request.getParameter("paidAmount");

    String amountInWords = request.getParameter("amountInWords");
    String dcNo = request.getParameter("dcNo");
    String invDate = request.getParameter("invDate");
    String invNo = request.getParameter("invNo");
    String invDate2 = request.getParameter("invDate2");
    String declaredValueRs = request.getParameter("declaredValueRs");
    String pnlSealNo = request.getParameter("pnlSealNo");
    String materialReceivedDate = request.getParameter("materialReceivedDate");
    String pnlNo = request.getParameter("pnlNo");
    String driverName = request.getParameter("driverName");
    String vehicleType = request.getParameter("vehicleType");
    String deliverIn = request.getParameter("deliverIn");

    try {
        int customerId = 0;
        if (customerIdParam != null && customerIdParam.trim().length() > 0) {
            customerId = Integer.parseInt(customerIdParam.trim());
        }

        if (idParam != null && idParam.trim().length() > 0) {
            int id = Integer.parseInt(idParam.trim());
            int updated = bill.updateLrCopy(
                id, customerId, customerName, phoneNumber,
                lrDate, truckNo, fromLocation, toLocation, consigneeName,
                noOfArticles, descriptionText, weightMt,
                modePayment1, freightAmount, toPayAmount, paidAmount,
                amountInWords,
                dcNo, invDate, invNo, invDate2, declaredValueRs, pnlSealNo,
                materialReceivedDate, pnlNo, driverName, vehicleType, deliverIn
            );

            if (updated > 0) {
                out.print("{\"status\":\"OK\",\"message\":\"LR updated\"}");
            } else {
                out.print("{\"status\":\"ERROR\",\"message\":\"Unable to update LR. Changes rolled back.\"}");
            }
        } else {
            int newId = bill.saveLrCopy(
                customerId, customerName, phoneNumber,
                lrDate, truckNo, fromLocation, toLocation, consigneeName,
                noOfArticles, descriptionText, weightMt,
                modePayment1, freightAmount, toPayAmount, paidAmount,
                amountInWords,
                dcNo, invDate, invNo, invDate2, declaredValueRs, pnlSealNo,
                materialReceivedDate, pnlNo, driverName, vehicleType, deliverIn,
                userId
            );
            String lrNo = "";
            Vector rowById = bill.getLrCopyById(newId);
            if (!rowById.isEmpty()) {
                lrNo = rowById.get(1).toString();
            }
            out.print("{\"status\":\"OK\",\"message\":\"LR saved\",\"id\":" + newId + ",\"lrNo\":\"" + lrNo + "\"}");
        }
    } catch (Exception e) {
        String msg = e.getMessage() == null ? "Error saving LR" : e.getMessage();
        msg = msg.replace("\\", "\\\\").replace("\"", "\\\"");
        out.print("{\"status\":\"ERROR\",\"message\":\"" + msg + "\"}");
    }
%>
