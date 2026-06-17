<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
    response.setHeader("Cache-Control", "no-cache");
    try {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) { out.print("Session expired"); return; }

        int    id          = Integer.parseInt(request.getParameter("id").trim());
        int    supplierId  = Integer.parseInt(request.getParameter("supplierId").trim());
        String lrDate      = request.getParameter("lrDate").trim();
        String lrNo        = request.getParameter("lrNo").trim();
        int    customerId  = Integer.parseInt(request.getParameter("customerId").trim());
        String destination = request.getParameter("destination").trim();
        double dpfFreight  = Double.parseDouble(request.getParameter("dpfFreight").trim());
        double dpfLrCharge = Double.parseDouble(request.getParameter("dpfLrCharge").trim());
        double dpfLoad     = Double.parseDouble(request.getParameter("dpfLoad").trim());
        double dpfUl       = Double.parseDouble(request.getParameter("dpfUl").trim());
        double dpfHalting  = Double.parseDouble(request.getParameter("dpfHalting").trim());
        double lh          = Double.parseDouble(request.getParameter("lh").trim());
        double loadAmt     = Double.parseDouble(request.getParameter("loadAmt").trim());
        double ul          = Double.parseDouble(request.getParameter("ul").trim());
        double hoting      = Double.parseDouble(request.getParameter("hoting").trim());
        double lc          = Double.parseDouble(request.getParameter("lc").trim());

        int updated = bill.updateLogisticsOrder(id, supplierId, lrDate, lrNo,
                                                customerId, destination,
                            dpfFreight, dpfLrCharge, dpfLoad, dpfUl, dpfHalting,
                            lh, loadAmt, ul, hoting, lc);
        if (updated > 0) {
            out.print("OK");
        } else {
            out.print("Order not found or already billed.");
        }
    } catch (NumberFormatException e) {
        out.print("Invalid input: " + e.getMessage());
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
