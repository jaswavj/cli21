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

    String today        = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
    String firstOfMonth = today.substring(0, 8) + "01";

    String fromDate = request.getParameter("fromDate");
    String toDate   = request.getParameter("toDate");
    if (fromDate == null || fromDate.trim().isEmpty()) fromDate = firstOfMonth;
    if (toDate   == null || toDate.trim().isEmpty())   toDate   = today;

    Vector rows = new Vector();
    try {
        rows = bill.getCancelledBillReport(fromDate, toDate);
    } catch (Exception ex) { ex.printStackTrace(); }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cancelled Transport Bill Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        .tbl-amt { text-align: right; }
        @media print { .no-print { display: none !important; } body { font-size: 11px; } }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>
<%
    request.setAttribute("pageTitle",    "Cancelled Bill Report");
    request.setAttribute("pageSubtitle", "Transport bills cancelled by users");
    request.setAttribute("pageIcon",     "fa-solid fa-ban");
%>
<jsp:include page="/assets/common/pageHeader.jsp" />

<div class="container-fluid mt-3 mst-page" style="max-width:1000px;">

    <div class="card mst-card mb-3 no-print">
        <div class="card-body py-2 px-3">
            <form method="get" action="" class="row g-2 align-items-end">
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">From Date</label>
                    <input type="date" name="fromDate" class="form-control fg-inp" value="<%=fromDate%>">
                </div>
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">To Date</label>
                    <input type="date" name="toDate" class="form-control fg-inp" value="<%=toDate%>">
                </div>
                <div class="col-auto">
                    <button type="submit" class="bb bb-primary">
                        <i class="fa-solid fa-magnifying-glass me-1"></i>Search
                    </button>
                    <button type="button" class="bb bb-secondary ms-1" onclick="window.print()">
                        <i class="fa-solid fa-print me-1"></i>Print
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="card mst-card">
        <div class="mst-card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">
                <i class="fa-solid fa-ban me-2"></i>Cancelled Transport Bills
                <span class="badge bg-secondary ms-2"><%=rows.size()%></span>
            </h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
            <table class="table table-bordered table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Invoice No</th>
                        <th>Bill Date</th>
                        <th>Customer</th>
                        <th class="tbl-amt">Grand Total (&#8377;)</th>
                        <th>Cancelled By</th>
                        <th>Cancelled On</th>
                    </tr>
                </thead>
                <tbody>
<%
if (rows.isEmpty()) {
%>
                    <tr><td colspan="7" class="text-center text-muted py-4">No cancelled bills found for the selected date range.</td></tr>
<%
} else {
    int sno = 1;
    for (int i = 0; i < rows.size(); i++) {
        Vector row = (Vector) rows.get(i);
        double grandTotal = 0;
        try { grandTotal = Double.parseDouble(row.get(4).toString()); } catch (Exception _e) {}
%>
                    <tr>
                        <td><%=sno%></td>
                        <td><%=row.get(1)%></td>
                        <td><%=row.get(2)%></td>
                        <td><%=row.get(3)%></td>
                        <td class="tbl-amt"><%=String.format("%.2f", grandTotal)%></td>
                        <td><%=row.get(5)%></td>
                        <td><%=row.get(6)%></td>
                    </tr>
<%
        sno++;
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
