<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.google.gson.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setContentType("application/json");
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) { response.setStatus(401); out.print("{\"ok\":false,\"msg\":\"Session expired\"}"); return; }

    try {
        StringBuilder sb = new StringBuilder();
        java.io.BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) sb.append(line);
        JsonObject obj = new JsonParser().parse(sb.toString()).getAsJsonObject();

        int    billId   = obj.get("billId").getAsInt();
        int    lrId     = obj.get("lrId").getAsInt();
        String poNo     = obj.has("poNo")     ? obj.get("poNo").getAsString()     : "";
        String sacCode  = obj.has("sacCode")  ? obj.get("sacCode").getAsString()  : "";
        String notes    = obj.has("notes")    ? obj.get("notes").getAsString()    : "";
        String lrDate   = obj.has("lrDate")   ? obj.get("lrDate").getAsString()   : "";
        double lrTotal  = obj.get("lrTotal").getAsDouble();
        JsonArray partsArr = obj.getAsJsonArray("particulars");

        int n = partsArr.size();
        String[] detailLrNos = new String[n];
        String[] parts   = new String[n];
        String[] qtys    = new String[n];
        String[] rates   = new String[n];
        double[] amounts = new double[n];
        for (int i = 0; i < n; i++) {
            JsonObject p = partsArr.get(i).getAsJsonObject();
            detailLrNos[i] = p.has("lrNo")      ? p.get("lrNo").getAsString()      : "";
            parts[i]   = p.has("particular") ? p.get("particular").getAsString() : "";
            qtys[i]    = p.has("qty")        ? p.get("qty").getAsString()        : "";
            rates[i]   = p.has("rateWt")     ? p.get("rateWt").getAsString()     : "";
            amounts[i] = p.has("amount")     ? p.get("amount").getAsDouble()     : 0;
        }

        int updated = bill.updateTransportBillLR(billId, lrId, poNo, sacCode, lrDate, lrTotal, notes, detailLrNos, parts, qtys, rates, amounts);
        if (updated > 0) {
            out.print("{\"ok\":true}");
        } else {
            out.print("{\"ok\":false,\"msg\":\"Bill not found or already cancelled.\"}");
        }
    } catch (Exception e) {
        out.print("{\"ok\":false,\"msg\":\"" + e.getMessage().replace("\"","'") + "\"}");
    }
%>
