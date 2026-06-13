<%@page language="java" import="java.util.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />

<%
// Session check
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}

String supplierIdParam  = request.getParameter("supplierId");
String lrDate           = request.getParameter("lrDate");
String lrNo             = request.getParameter("lrNo");
String customerIdParam  = request.getParameter("customerId");
String destination      = request.getParameter("destination");
String vehicleNo        = request.getParameter("vehicleNo");
String driverPhone      = request.getParameter("driverPhone");
String dpfParam         = request.getParameter("dpf");
String lhParam          = request.getParameter("lh");
String loadAmtParam     = request.getParameter("loadAmt");
String ulParam          = request.getParameter("ul");
String hotingParam      = request.getParameter("hoting");
String lcParam          = request.getParameter("lc");
String supPayTypeParam  = request.getParameter("supPayType");
String supPayModeParam  = request.getParameter("supPayMode");
String supPaidParam     = request.getParameter("supPaid");

try {
    int    supplierId = Integer.parseInt(supplierIdParam);
    int    customerId = Integer.parseInt(customerIdParam);
    double dpf        = (dpfParam     != null && !dpfParam.trim().isEmpty())     ? Double.parseDouble(dpfParam)     : 0;
    double lh         = (lhParam      != null && !lhParam.trim().isEmpty())      ? Double.parseDouble(lhParam)      : 0;
    double loadAmt    = (loadAmtParam != null && !loadAmtParam.trim().isEmpty()) ? Double.parseDouble(loadAmtParam) : 0;
    double ul         = (ulParam      != null && !ulParam.trim().isEmpty())      ? Double.parseDouble(ulParam)      : 0;
    double hoting     = (hotingParam  != null && !hotingParam.trim().isEmpty())  ? Double.parseDouble(hotingParam)  : 0;
    double lc         = (lcParam      != null && !lcParam.trim().isEmpty())      ? Double.parseDouble(lcParam)      : 0;
    int    supPayType = (supPayTypeParam != null && !supPayTypeParam.trim().isEmpty()) ? Integer.parseInt(supPayTypeParam) : 1;
    int    supPayMode = (supPayModeParam != null && !supPayModeParam.trim().isEmpty()) ? Integer.parseInt(supPayModeParam) : 0;
    double supPaid    = (supPaidParam    != null && !supPaidParam.trim().isEmpty())    ? Double.parseDouble(supPaidParam)   : 0;

    bill.saveLogisticsOrder(supplierId, lrDate, lrNo, customerId, destination,
                            vehicleNo, driverPhone,
                            dpf, lh, loadAmt, ul, hoting, lc,
                            supPayType, supPayMode, supPaid, userId);

    response.sendRedirect(request.getContextPath()
        + "/logistics/order/page.jsp?msg=LR+Order+saved+successfully!&type=success");
} catch (Exception e) {
    response.sendRedirect(request.getContextPath()
        + "/logistics/order/page.jsp?msg=Error:+"
        + java.net.URLEncoder.encode(e.getMessage() != null ? e.getMessage() : "Unknown error", "UTF-8")
        + "&type=danger");
}
%>
