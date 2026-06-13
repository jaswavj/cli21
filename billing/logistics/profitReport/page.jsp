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
String viewMode = request.getParameter("viewMode"); // "date" | "bill"
if (fromDate == null || fromDate.trim().isEmpty()) fromDate = firstOfMonth;
if (toDate   == null || toDate.trim().isEmpty())   toDate   = today;
if (viewMode == null || viewMode.trim().isEmpty())  viewMode = "date";

java.text.SimpleDateFormat inFmt  = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.text.SimpleDateFormat outFmt = new java.text.SimpleDateFormat("dd-MM-yyyy");

Vector dateRows = new Vector();
Vector billRows = new Vector();

if ("date".equals(viewMode)) {
    try { dateRows = bill.getLogisticsProfitByDate(fromDate, toDate); } catch (Exception ex) { ex.printStackTrace(); }
} else {
    try { billRows = bill.getLogisticsProfitByBill(fromDate, toDate); } catch (Exception ex) { ex.printStackTrace(); }
}

// Totals
double sumDpf=0, sumCosting=0, sumProfit=0, sumLh=0, sumLoad=0, sumUl=0, sumLc=0, sumHoting=0, sumTax=0;
if ("date".equals(viewMode)) {
    for (int i = 0; i < dateRows.size(); i++) {
        Vector r = (Vector) dateRows.get(i);
        try { sumDpf     += Double.parseDouble(r.get(2).toString()); } catch (Exception _e) {}
        try { sumLh      += Double.parseDouble(r.get(3).toString()); } catch (Exception _e) {}
        try { sumLoad    += Double.parseDouble(r.get(4).toString()); } catch (Exception _e) {}
        try { sumUl      += Double.parseDouble(r.get(5).toString()); } catch (Exception _e) {}
        try { sumLc      += Double.parseDouble(r.get(6).toString()); } catch (Exception _e) {}
        try { sumHoting  += Double.parseDouble(r.get(7).toString()); } catch (Exception _e) {}
        try { sumCosting += Double.parseDouble(r.get(8).toString()); } catch (Exception _e) {}
        try { sumProfit  += Double.parseDouble(r.get(9).toString()); } catch (Exception _e) {}
        try { sumTax     += Double.parseDouble(r.get(10).toString()); } catch (Exception _e) {}
    }
} else {
    for (int i = 0; i < billRows.size(); i++) {
        Vector r = (Vector) billRows.get(i);
        try { sumDpf     += Double.parseDouble(r.get(5).toString()); } catch (Exception _e) {}
        try { sumLh      += Double.parseDouble(r.get(6).toString()); } catch (Exception _e) {}
        try { sumLoad    += Double.parseDouble(r.get(7).toString()); } catch (Exception _e) {}
        try { sumUl      += Double.parseDouble(r.get(8).toString()); } catch (Exception _e) {}
        try { sumLc      += Double.parseDouble(r.get(9).toString()); } catch (Exception _e) {}
        try { sumHoting  += Double.parseDouble(r.get(10).toString()); } catch (Exception _e) {}
        try { sumCosting += Double.parseDouble(r.get(11).toString()); } catch (Exception _e) {}
        try { sumProfit  += Double.parseDouble(r.get(12).toString()); } catch (Exception _e) {}
        try { sumTax     += Double.parseDouble(r.get(13).toString()); } catch (Exception _e) {}
    }
}
String profitClass = sumProfit >= 0 ? "text-success" : "text-danger";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Logistics Profit Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        .tbl-amt  { text-align: right; min-width: 90px; }
        .p-pos    { color: #198754; font-weight: 600; }
        .p-neg    { color: #dc3545; font-weight: 600; }
        .sum-row td { font-weight: 700; background: #f0f4ff; border-top: 2px solid #adb5bd; }
        .tab-btn.active { background:#0d6efd; color:#fff; border-color:#0d6efd; }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>
<%
    request.setAttribute("pageTitle",    "Profit Report");
    request.setAttribute("pageSubtitle", "Logistics — Billed Order Profit Analysis");
    request.setAttribute("pageIcon",     "fa-solid fa-chart-line");
%>
<jsp:include page="/assets/common/pageHeader.jsp" />

<div class="container-fluid mt-3 mst-page">

    <!-- Summary cards -->
    <div class="row mb-3 g-3">
        <div class="col-6 col-md-3">
            <div class="card mst-card h-100">
                <div class="card-body py-3 text-center">
                    <div class="small text-muted fw-semibold text-uppercase mb-1">Total DPF (Revenue)</div>
                    <div class="fs-5 fw-bold text-primary">&#8377;<%=String.format("%,.2f", sumDpf)%></div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card mst-card h-100">
                <div class="card-body py-3 text-center">
                    <div class="small text-muted fw-semibold text-uppercase mb-1">Total Costing</div>
                    <div class="fs-5 fw-bold text-warning">&#8377;<%=String.format("%,.2f", sumCosting)%></div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card mst-card h-100">
                <div class="card-body py-3 text-center">
                    <div class="small text-muted fw-semibold text-uppercase mb-1">Net Profit</div>
                    <div class="fs-5 fw-bold <%=profitClass%>">&#8377;<%=String.format("%,.2f", sumProfit)%></div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card mst-card h-100">
                <div class="card-body py-3 text-center">
                    <div class="small text-muted fw-semibold text-uppercase mb-1">Margin %</div>
                    <div class="fs-5 fw-bold <%=profitClass%>">
                        <%=sumDpf > 0 ? String.format("%.1f%%", (sumProfit/sumDpf)*100) : "0.0%"%>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter card -->
    <div class="card mst-card mb-3">
        <div class="card-body py-2 px-3">
            <div class="btn-group me-3 mb-2" role="group">
                <button type="button" class="btn btn-outline-primary tab-btn <%="date".equals(viewMode)?"active":""%>"
                    onclick="switchTab('date')">
                    <i class="fas fa-calendar-day me-1"></i>Date Wise
                </button>
                <button type="button" class="btn btn-outline-primary tab-btn <%="bill".equals(viewMode)?"active":""%>"
                    onclick="switchTab('bill')">
                    <i class="fas fa-file-invoice me-1"></i>Bill Wise
                </button>
            </div>
            <form id="searchForm" method="get" action="<%=contextPath%>/logistics/profitReport/page.jsp"
                  class="row g-2 align-items-end d-inline-flex">
                <input type="hidden" id="frmViewMode" name="viewMode" value="<%=viewMode%>">
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
                        <i class="fas fa-search me-1"></i>Search
                    </button>
                </div>
            </form>
        </div>
    </div>

<%-- ══════════════ DATE-WISE TABLE ══════════════ --%>
<% if ("date".equals(viewMode)) { %>
    <div class="card mst-card">
        <div class="mst-card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fas fa-calendar-day me-2"></i>Date-wise Profit
                <span class="badge bg-secondary ms-2"><%=dateRows.size()%> days</span>
            </h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
            <table class="table table-bordered table-hover mb-0" id="dateTable">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Date</th>
                        <th class="tbl-amt">LR Count</th>
                        <th class="tbl-amt">DPF (&#8377;)</th>
                        <th class="tbl-amt">LH (&#8377;)</th>
                        <th class="tbl-amt">LOAD (&#8377;)</th>
                        <th class="tbl-amt">U/L (&#8377;)</th>
                        <th class="tbl-amt">LC (&#8377;)</th>
                        <th class="tbl-amt">HOTING (&#8377;)</th>
                        <th class="tbl-amt">Costing (&#8377;)</th>
                        <th class="tbl-amt">Profit (&#8377;)</th>
                        <th class="tbl-amt">Tax Collected (&#8377;)</th>
                    </tr>
                </thead>
                <tbody>
<%
if (dateRows.isEmpty()) {
%>
                    <tr><td colspan="11" class="text-center text-muted py-4">No billed orders found for the selected date range.</td></tr>
<%
} else {
    for (int i = 0; i < dateRows.size(); i++) {
        Vector r = (Vector) dateRows.get(i);
        String dateDisp = r.get(0).toString();
        try { dateDisp = outFmt.format(inFmt.parse(dateDisp)); } catch (Exception _e) {}
        int    lrCount  = 0;   try { lrCount  = Integer.parseInt(r.get(1).toString()); } catch (Exception _e) {}
        double dpf      = 0;   try { dpf      = Double.parseDouble(r.get(2).toString()); } catch (Exception _e) {}
        double lh       = 0;   try { lh       = Double.parseDouble(r.get(3).toString()); } catch (Exception _e) {}
        double load     = 0;   try { load     = Double.parseDouble(r.get(4).toString()); } catch (Exception _e) {}
        double ul       = 0;   try { ul       = Double.parseDouble(r.get(5).toString()); } catch (Exception _e) {}
        double lc       = 0;   try { lc       = Double.parseDouble(r.get(6).toString()); } catch (Exception _e) {}
        double hoting   = 0;   try { hoting   = Double.parseDouble(r.get(7).toString()); } catch (Exception _e) {}
        double costing  = 0;   try { costing  = Double.parseDouble(r.get(8).toString()); } catch (Exception _e) {}
        double profit   = 0;   try { profit   = Double.parseDouble(r.get(9).toString()); } catch (Exception _e) {}
        String pCls = profit >= 0 ? "p-pos" : "p-neg";
%>
                    <tr>
                        <td><%=i+1%></td>
                        <td><%=dateDisp%></td>
                        <td class="tbl-amt"><%=lrCount%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",dpf)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",lh)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",load)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",ul)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",lc)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",hoting)%></td>
                        <td class="tbl-amt text-warning fw-semibold"><%=String.format("%,.2f",costing)%></td>
                        <td class="tbl-amt <%=pCls%>"><%=String.format("%,.2f",profit)%></td>
                    </tr>
<%  } %>
                    <!-- Summary row -->
                    <tr class="sum-row">
                        <td colspan="3" class="text-end">TOTAL</td>
                        <td class="tbl-amt text-primary"><%=String.format("%,.2f",sumDpf)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",sumLh)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",sumLoad)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",sumUl)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",sumLc)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",sumHoting)%></td>
                        <td class="tbl-amt text-warning"><%=String.format("%,.2f",sumCosting)%></td>
                        <td class="tbl-amt <%=profitClass%>"><%=String.format("%,.2f",sumProfit)%></td>
                    </tr>
<% } %>
                </tbody>
            </table>
            </div>
        </div>
    </div>
<% } %>

<%-- ══════════════ BILL-WISE TABLE ══════════════ --%>
<% if ("bill".equals(viewMode)) { %>
    <div class="card mst-card">
        <div class="mst-card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fas fa-file-invoice me-2"></i>Bill-wise Profit
                <span class="badge bg-secondary ms-2"><%=billRows.size()%> bills</span>
            </h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
            <table class="table table-bordered table-hover mb-0" id="billTable">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Invoice No</th>
                        <th>Bill Date</th>
                        <th>Customer</th>
                        <th class="tbl-amt">LRs</th>
                        <th class="tbl-amt">DPF (&#8377;)</th>
                        <th class="tbl-amt">LH (&#8377;)</th>
                        <th class="tbl-amt">LOAD (&#8377;)</th>
                        <th class="tbl-amt">U/L (&#8377;)</th>
                        <th class="tbl-amt">LC (&#8377;)</th>
                        <th class="tbl-amt">HOTING (&#8377;)</th>
                        <th class="tbl-amt">Costing (&#8377;)</th>
                        <th class="tbl-amt">Profit (&#8377;)</th>
                        <th class="tbl-amt">Tax Collected (&#8377;)</th>
                        <th class="tbl-amt">Margin %</th>
                    </tr>
                </thead>
                <tbody>
<%
if (billRows.isEmpty()) {
%>
                    <tr><td colspan="15" class="text-center text-muted py-4">No billed orders found for the selected date range.</td></tr>
<%
} else {
    for (int i = 0; i < billRows.size(); i++) {
        Vector r = (Vector) billRows.get(i);
        String invoiceNo  = r.get(1).toString();
        String billDate   = r.get(2).toString();
        String custName   = r.get(3).toString();
        String billDateDisp = billDate;
        try { billDateDisp = outFmt.format(inFmt.parse(billDate)); } catch (Exception _e) {}
        int    lrCount  = 0;  try { lrCount  = Integer.parseInt(r.get(4).toString()); } catch (Exception _e) {}
        double dpf      = 0;  try { dpf      = Double.parseDouble(r.get(5).toString()); } catch (Exception _e) {}
        double lh       = 0;  try { lh       = Double.parseDouble(r.get(6).toString()); } catch (Exception _e) {}
        double load     = 0;  try { load     = Double.parseDouble(r.get(7).toString()); } catch (Exception _e) {}
        double ul       = 0;  try { ul       = Double.parseDouble(r.get(8).toString()); } catch (Exception _e) {}
        double lc       = 0;  try { lc       = Double.parseDouble(r.get(9).toString()); } catch (Exception _e) {}
        double hoting   = 0;  try { hoting   = Double.parseDouble(r.get(10).toString()); } catch (Exception _e) {}
        double costing  = 0;  try { costing  = Double.parseDouble(r.get(11).toString()); } catch (Exception _e) {}
        double profit   = 0;  try { profit   = Double.parseDouble(r.get(12).toString()); } catch (Exception _e) {}
        double taxColl  = 0;  try { taxColl  = Double.parseDouble(r.get(13).toString()); } catch (Exception _e) {}
        double margin   = dpf > 0 ? (profit / dpf) * 100 : 0;
        String pCls = profit >= 0 ? "p-pos" : "p-neg";
        String mCls = margin >= 0 ? "p-pos" : "p-neg";
%>
                    <tr>
                        <td><%=i+1%></td>
                        <td><strong><%=invoiceNo%></strong></td>
                        <td><%=billDateDisp%></td>
                        <td><%=custName%></td>
                        <td class="tbl-amt"><%=lrCount%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",dpf)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",lh)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",load)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",ul)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",lc)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",hoting)%></td>
                        <td class="tbl-amt text-warning fw-semibold"><%=String.format("%,.2f",costing)%></td>
                        <td class="tbl-amt <%=pCls%>"><%=String.format("%,.2f",profit)%></td>
                        <td class="tbl-amt text-info"><%=taxColl>0?String.format("%,.2f",taxColl):"-"%></td>
                        <td class="tbl-amt <%=mCls%>"><%=String.format("%.1f%%",margin)%></td>
                    </tr>
<%  } %>
                    <!-- Summary row -->
                    <tr class="sum-row">
                        <td colspan="5" class="text-end">TOTAL</td>
                        <td class="tbl-amt text-primary"><%=String.format("%,.2f",sumDpf)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",sumLh)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",sumLoad)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",sumUl)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",sumLc)%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",sumHoting)%></td>
                        <td class="tbl-amt text-warning"><%=String.format("%,.2f",sumCosting)%></td>
                        <td class="tbl-amt <%=profitClass%>"><%=String.format("%,.2f",sumProfit)%></td>
                        <td class="tbl-amt text-info"><%=String.format("%,.2f",sumTax)%></td>
                        <td class="tbl-amt <%=profitClass%>"><%=sumDpf>0?String.format("%.1f%%",(sumProfit/sumDpf)*100):"0.0%"%></td>
                    </tr>
<% } %>
                </tbody>
            </table>
            </div>
        </div>
    </div>
<% } %>

</div><!-- /container -->

<script>
var contextPath = '<%=contextPath%>';

function switchTab(mode) {
    document.getElementById('frmViewMode').value = mode;
    document.querySelectorAll('.tab-btn').forEach(function(b) { b.classList.remove('active'); });
    var idx = ['date','bill'].indexOf(mode);
    document.querySelectorAll('.tab-btn')[idx].classList.add('active');
    document.getElementById('searchForm').submit();
}
</script>
</body>
</html>
