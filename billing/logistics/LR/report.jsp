<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page errorPage="" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}

String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String firstOfMonth = today.substring(0, 8) + "01";

String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");
if (fromDate == null || fromDate.trim().isEmpty()) fromDate = firstOfMonth;
if (toDate == null || toDate.trim().isEmpty()) toDate = today;

Vector rows = new Vector();
try {
    rows = bill.getLrCopyReport(fromDate, toDate);
} catch (Exception ex) {
    ex.printStackTrace();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LR Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        .tbl-amt { text-align:right; min-width:90px; }
        .status-active { color:#198754; font-weight:700; }
        .status-cancel { color:#dc3545; font-weight:700; }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>
<%
    request.setAttribute("pageTitle", "LR Report");
    request.setAttribute("pageSubtitle", "Date-wise LR list with print action");
    request.setAttribute("pageIcon", "fa-solid fa-file-lines");
%>
<jsp:include page="/assets/common/pageHeader.jsp" />

<div class="container-fluid mt-3 mst-page">
    <div class="card mst-card mb-3">
        <div class="card-body py-2 px-3">
            <form method="get" action="<%=contextPath%>/logistics/LR/report.jsp" class="row g-2 align-items-end">
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">From Date</label>
                    <input type="date" name="fromDate" class="form-control fg-inp" value="<%=fromDate%>">
                </div>
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">To Date</label>
                    <input type="date" name="toDate" class="form-control fg-inp" value="<%=toDate%>">
                </div>
                <div class="col-auto">
                    <button type="submit" class="bb bb-primary"><i class="fas fa-search me-1"></i>Search</button>
                </div>
                <div class="col-auto ms-auto">
                    <span class="badge bg-secondary">Total: <%=rows.size()%></span>
                </div>
            </form>
        </div>
    </div>

    <div class="card mst-card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-bordered table-hover mb-0" id="lrReportTable">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>LR No</th>
                            <th>Date</th>
                            <th>Customer</th>
                            <th>Phone</th>
                            <th>From</th>
                            <th>To</th>
                            <th>Truck</th>
                            <th>Consignee</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
<%
if (rows.isEmpty()) {
%>
                        <tr><td colspan="11" class="text-center text-muted py-4">No LR found for selected date range.</td></tr>
<%
} else {
    java.text.SimpleDateFormat inFmt = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.text.SimpleDateFormat outFmt = new java.text.SimpleDateFormat("dd-MM-yyyy");
    for (int i = 0; i < rows.size(); i++) {
        Vector r = (Vector) rows.get(i);
        String id = r.get(0).toString();
        String lrNo = r.get(1).toString();
        String lrDate = r.get(2).toString();
        String customerName = r.get(3).toString();
        String phone = r.get(4).toString();
        String fromLoc = r.get(5).toString();
        String toLoc = r.get(6).toString();
        String truckNo = r.get(7).toString();
        String consignee = r.get(8).toString();
        int isCancelled = 0;
        try { isCancelled = Integer.parseInt(r.get(11).toString()); } catch (Exception ignore) {}

        String lrDateDisp = lrDate;
        try { lrDateDisp = outFmt.format(inFmt.parse(lrDate)); } catch (Exception ignore) {}
%>
                        <tr>
                            <td><%=i + 1%></td>
                            <td><strong><%=lrNo%></strong></td>
                            <td><%=lrDateDisp%></td>
                            <td><%=customerName%></td>
                            <td><%=phone%></td>
                            <td><%=fromLoc%></td>
                            <td><%=toLoc%></td>
                            <td><%=truckNo%></td>
                            <td><%=consignee%></td>
                            <td>
                                <% if (isCancelled == 1) { %>
                                <span class="status-cancel">Cancelled</span>
                                <% } else { %>
                                <span class="status-active">Active</span>
                                <% } %>
                            </td>
                            <td>
                                <div class="d-flex flex-wrap gap-1">
                                    <a class="btn btn-sm btn-info text-white"
                                       href="<%=request.getContextPath()%>/logistics/LR/print.jsp?id=<%=id%>&copyType=consignee"
                                       target="_blank">
                                        <i class="fa-solid fa-print"></i> Consignee
                                    </a>
                                    <a class="btn btn-sm btn-primary text-white"
                                       href="<%=request.getContextPath()%>/logistics/LR/print.jsp?id=<%=id%>&copyType=consignor"
                                       target="_blank">
                                        <i class="fa-solid fa-print"></i> Consignor
                                    </a>
                                    <a class="btn btn-sm btn-secondary text-white"
                                       href="<%=request.getContextPath()%>/logistics/LR/print.jsp?id=<%=id%>&copyType=driver"
                                       target="_blank">
                                        <i class="fa-solid fa-print"></i> Driver
                                    </a>
                                </div>
                            </td>
                        </tr>
<%
    }
}
%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
