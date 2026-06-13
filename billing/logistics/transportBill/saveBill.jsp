<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.google.gson.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.setStatus(401);
    out.print("{\"success\":false,\"error\":\"Session expired\"}");
    return;
}

try {
    // ── Read JSON body ────────────────────────────────────────
    StringBuilder sb = new StringBuilder();
    java.io.BufferedReader reader = request.getReader();
    String line;
    while ((line = reader.readLine()) != null) sb.append(line);
    String json = sb.toString();

    // ── Parse with Gson ───────────────────────────────────────
    JsonParser parser  = new JsonParser();
    JsonObject obj     = parser.parse(json).getAsJsonObject();

    int    customerId  = obj.get("customerId").getAsInt();
    String poNo        = obj.has("poNo")      ? obj.get("poNo").getAsString()      : "";
    String sacCode     = obj.has("sacCode")   ? obj.get("sacCode").getAsString()   : "";
    double grandTotal  = obj.get("grandTotal").getAsDouble();
    double paidAmount  = obj.get("paidAmount").getAsDouble();
    double balance     = obj.get("balance").getAsDouble();
    int    paymentType    = obj.has("paymentType")    ? obj.get("paymentType").getAsInt()    : 1;
    int    paymentModeInt = obj.has("paymentModeInt") ? obj.get("paymentModeInt").getAsInt() : 0;
    int    creditDays     = obj.has("creditDays")     ? obj.get("creditDays").getAsInt()     : 0;

    JsonArray lrsArr   = obj.getAsJsonArray("lrs");
    int nLRs           = lrsArr.size();

    int[]    lrIds       = new int[nLRs];
    double[] lrTotals    = new double[nLRs];
    String[] lrNotes     = new String[nLRs];
    int[]    lrPartCounts = new int[nLRs];

    // Count total particulars across all LRs
    int totalParts = 0;
    for (int i = 0; i < nLRs; i++) {
        totalParts += lrsArr.get(i).getAsJsonObject().getAsJsonArray("particulars").size();
    }

    String[] particulars = new String[totalParts];
    String[] quantities  = new String[totalParts];
    String[] rateWts     = new String[totalParts];
    double[] amounts     = new double[totalParts];

    int partIdx = 0;
    for (int i = 0; i < nLRs; i++) {
        JsonObject lr    = lrsArr.get(i).getAsJsonObject();
        lrIds[i]         = lr.get("lrId").getAsInt();
        lrTotals[i]      = lr.get("lrTotal").getAsDouble();
        lrNotes[i]       = lr.has("notes") ? lr.get("notes").getAsString() : "";
        JsonArray parts  = lr.getAsJsonArray("particulars");
        lrPartCounts[i]  = parts.size();
        for (int j = 0; j < parts.size(); j++) {
            JsonObject p      = parts.get(j).getAsJsonObject();
            particulars[partIdx] = p.has("particular") ? p.get("particular").getAsString() : "";
            quantities[partIdx]  = p.has("qty")        ? p.get("qty").getAsString()        : "";
            rateWts[partIdx]     = p.has("rateWt")     ? p.get("rateWt").getAsString()     : "";
            amounts[partIdx]     = p.has("amount")     ? p.get("amount").getAsDouble()     : 0;
            partIdx++;
        }
    }

    // ── Save ──────────────────────────────────────────────────
    String invoiceNo = bill.saveTransportBill(
        customerId, poNo, sacCode,
        grandTotal, paidAmount, balance,
        paymentType, paymentModeInt, creditDays,
        lrIds, lrTotals, lrNotes, lrPartCounts,
        particulars, quantities, rateWts, amounts,
        userId
    );

    // Get the new bill ID to pass to print page
    // (saveTransportBill returns invoiceNo; we fetch billId by invoiceNo)
    int newBillId = 0;
    try {
        java.sql.Connection con = util.DBConnectionManager.getConnectionFromPool();
        java.sql.PreparedStatement ps = con.prepareStatement(
            "SELECT id FROM transport_bill WHERE invoice_no=? ORDER BY id DESC LIMIT 1");
        ps.setString(1, invoiceNo);
        java.sql.ResultSet rs = ps.executeQuery();
        if (rs.next()) newBillId = rs.getInt(1);
        rs.close(); ps.close(); con.close();
    } catch (Exception ignored) {}

    out.print("{\"success\":true,\"invoiceNo\":\"" + invoiceNo + "\",\"billId\":" + newBillId + "}");

} catch (Exception e) {
    e.printStackTrace();
    String errMsg = e.getMessage() != null ? e.getMessage().replace("\"","'").replace("\n"," ") : "Unknown error";
    out.print("{\"success\":false,\"error\":\"" + errMsg + "\"}");
}
%>
