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

String fromDate  = request.getParameter("fromDate");
String toDate    = request.getParameter("toDate");
String viewMode  = request.getParameter("viewMode");   // "range" | "bill" | "customer"
String billNoQ   = request.getParameter("billNo");
String custIdQ   = request.getParameter("custId");
String custNameQ = request.getParameter("custName");
if (fromDate  == null || fromDate.trim().isEmpty())  fromDate  = firstOfMonth;
if (toDate    == null || toDate.trim().isEmpty())    toDate    = today;
if (viewMode  == null || viewMode.trim().isEmpty())  viewMode  = "range";
if (billNoQ   == null) billNoQ   = "";
if (custIdQ   == null) custIdQ   = "";
if (custNameQ == null) custNameQ = "";

// Data holders
Vector reportRows     = new Vector(); // for "range" mode
Vector billHistory    = new Vector(); // result[0]=hdr, result[1]=payments  — for "bill" mode
Vector custBills      = new Vector(); // for "customer" mode
String billLookupErr  = "";

java.text.SimpleDateFormat inFmt  = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.text.SimpleDateFormat outFmt = new java.text.SimpleDateFormat("dd-MM-yyyy");

if ("range".equals(viewMode)) {
    try { reportRows = bill.getTransportBalanceCollectionReport(fromDate, toDate); } catch (Exception ex) { ex.printStackTrace(); }
} else if ("bill".equals(viewMode) && !billNoQ.trim().isEmpty()) {
    // Find bill id by invoice_no
    try {
        int bid = bill.getTransportBillIdByInvoiceNo(billNoQ.trim());
        if (bid > 0) {
            billHistory = bill.getTransportBillPaymentHistory(bid);
        } else {
            billLookupErr = "Bill \"" + billNoQ + "\" not found.";
        }
    } catch (Exception ex) { billLookupErr = ex.getMessage() != null ? ex.getMessage() : "Error"; }
} else if ("customer".equals(viewMode) && !custIdQ.trim().isEmpty()) {
    try {
        int cid = Integer.parseInt(custIdQ.trim());
        custBills = bill.getTransportBillsByCustomer(cid);
    } catch (Exception ex) { ex.printStackTrace(); }
}

double reportTotal = 0;
double reportTaxTotal = 0;
for (int i = 0; i < reportRows.size(); i++) {
    try { reportTotal    += Double.parseDouble(((Vector)reportRows.get(i)).get(4).toString()); } catch (Exception _e) {}
    try { reportTaxTotal += Double.parseDouble(((Vector)reportRows.get(i)).get(9).toString()); } catch (Exception _e) {}
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Balance Collection Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        .tbl-amt { text-align:right; min-width:90px; }
        .tab-btn.active { background:#0d6efd; color:#fff; border-color:#0d6efd; }
        .ui-autocomplete { z-index: 99999 !important; }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>
<%
    request.setAttribute("pageTitle",    "Balance Collection Report");
    request.setAttribute("pageSubtitle", "Logistics — Payment History");
    request.setAttribute("pageIcon",     "fa-solid fa-file-invoice-dollar");
%>
<jsp:include page="/assets/common/pageHeader.jsp" />

<div class="container-fluid mt-3 mst-page">

    <!-- View mode tabs -->
    <div class="card mst-card mb-3">
        <div class="card-body py-2 px-3">
            <div class="btn-group me-3 mb-2" role="group">
                <button type="button" class="btn btn-outline-primary tab-btn <%="range".equals(viewMode)?"active":""%>"
                    onclick="switchTab('range')"><i class="fas fa-calendar me-1"></i>Date Range</button>
                <button type="button" class="btn btn-outline-primary tab-btn <%="bill".equals(viewMode)?"active":""%>"
                    onclick="switchTab('bill')"><i class="fas fa-file-invoice me-1"></i>By Bill No</button>
                <button type="button" class="btn btn-outline-primary tab-btn <%="customer".equals(viewMode)?"active":""%>"
                    onclick="switchTab('customer')"><i class="fas fa-user me-1"></i>By Customer</button>
            </div>

            <!-- Date Range filter -->
            <form id="frmRange" method="get" action="<%=contextPath%>/logistics/balanceCollection/report.jsp"
                  class="row g-2 align-items-end" style="display:<%="range".equals(viewMode)?"flex":"none"%>!important;">
                <input type="hidden" name="viewMode" value="range">
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
            </form>

            <!-- Bill No filter -->
            <form id="frmBill" method="get" action="<%=contextPath%>/logistics/balanceCollection/report.jsp"
                  class="row g-2 align-items-end" style="display:<%="bill".equals(viewMode)?"flex":"none"%>!important;">
                <input type="hidden" name="viewMode" value="bill">
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">Bill / Invoice No</label>
                    <input type="text" name="billNo" class="form-control fg-inp" placeholder="e.g. 26-1"
                           value="<%=billNoQ%>" style="min-width:160px;">
                </div>
                <div class="col-auto">
                    <button type="submit" class="bb bb-primary"><i class="fas fa-search me-1"></i>Search</button>
                </div>
            </form>

            <!-- Customer filter -->
            <form id="frmCustomer" method="get" action="<%=contextPath%>/logistics/balanceCollection/report.jsp"
                  class="row g-2 align-items-end" style="display:<%="customer".equals(viewMode)?"flex":"none"%>!important;">
                <input type="hidden" name="viewMode" value="customer">
                <input type="hidden" id="r_custId" name="custId" value="<%=custIdQ%>">
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">Customer Name</label>
                    <input type="text" id="r_custName" name="custName" class="form-control fg-inp"
                           placeholder="Type customer name..." autocomplete="off"
                           value="<%=custNameQ.replace("\"","&quot;")%>" style="min-width:220px;">
                    <div id="r_custError" class="text-danger small mt-1" style="display:none;">Please select a valid customer.</div>
                </div>
                <div class="col-auto">
                    <button type="submit" class="bb bb-primary" onclick="return validateCust()">
                        <i class="fas fa-search me-1"></i>Search
                    </button>
                </div>
            </form>
        </div>
    </div>

<%-- ── DATE RANGE RESULTS ────────────────────────────────────── --%>
<% if ("range".equals(viewMode)) { %>
    <div class="card mst-card mb-2">
        <div class="card-body py-2 px-3 d-flex align-items-center justify-content-between flex-wrap gap-2">
            <div class="d-flex align-items-center gap-4">
                <span class="fw-semibold">Collections: <span class="badge bg-secondary"><%=reportRows.size()%></span></span>
                <span class="fw-semibold text-success">Total Collected: <strong>&#8377;<%=String.format("%,.2f",reportTotal)%></strong></span>
                <span class="fw-semibold text-info">Total Tax: <strong>&#8377;<%=String.format("%,.2f",reportTaxTotal)%></strong></span>
            </div>
            <button class="btn btn-sm btn-success" onclick="exportToCsv()">
                <i class="fas fa-download me-1"></i>Download CSV
            </button>
        </div>
    </div>
    <div class="card mst-card">
        <div class="card-body p-0">
            <div class="table-responsive">
            <table class="table table-bordered table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Invoice No</th>
                        <th>Bill Date</th>
                        <th>Customer</th>
                        <th class="tbl-amt">Amount Collected (&#8377;)</th>
                        <th class="tbl-amt">Tax (&#8377;)</th>
                        <th>Payment Mode</th>
                        <th>Collected By</th>
                        <th>Collected On</th>
                    </tr>
                </thead>
                <tbody>
<% if (reportRows.isEmpty()) { %>
                    <tr><td colspan="9" class="text-center text-muted py-4">No collections found for the selected date range.</td></tr>
<% } else {
    for (int i = 0; i < reportRows.size(); i++) {
        Vector r = (Vector) reportRows.get(i);
        double amt = 0; try { amt = Double.parseDouble(r.get(4).toString()); } catch (Exception _e) {}
        double tax = 0; try { tax = Double.parseDouble(r.get(9).toString()); } catch (Exception _e) {}
        int payTypeIdx = 1; try { payTypeIdx = Integer.parseInt(r.get(5).toString()); } catch (Exception _e) {}
        int payModeIdx = 0; try { payModeIdx = Integer.parseInt(r.get(6).toString()); } catch (Exception _e) {}
        String[] typeNames = {"","Cash","Bank","Mixed"};
        String[] modeNames = {"","UPI","Cheque","Credit Card","Debit Card","NEFT","IMPS"};
        String typeName = (payTypeIdx>=1&&payTypeIdx<typeNames.length) ? typeNames[payTypeIdx] : "";
        String modeName = (payModeIdx>=1&&payModeIdx<modeNames.length) ? modeNames[payModeIdx] : "";
        String payLabel = payTypeIdx==1 ? "Cash" : (modeName.isEmpty() ? typeName : typeName + " / " + modeName);
        String billDateDisp = r.get(2).toString();
        try { billDateDisp = outFmt.format(inFmt.parse(billDateDisp)); } catch (Exception _e) {}
%>
                    <tr>
                        <td><%=i+1%></td>
                        <td><strong><%=r.get(1)%></strong></td>
                        <td><%=billDateDisp%></td>
                        <td><%=r.get(3)%></td>
                        <td class="tbl-amt fw-bold text-success"><%=String.format("%,.2f",amt)%></td>
                        <td class="tbl-amt text-info"><%=tax>0?String.format("%,.2f",tax):"-"%></td>
                        <td><%=payLabel%></td>
                        <td><%=r.get(7)%></td>
                        <td><%=r.get(8)%></td>
                    </tr>
<% }} %>
                </tbody>
            </table>
            </div>
        </div>
    </div>
<% } %>

<%-- ── BILL NO RESULTS ──────────────────────────────────────── --%>
<% if ("bill".equals(viewMode)) { %>
<% if (!billLookupErr.isEmpty()) { %>
    <div class="alert alert-danger"><i class="fas fa-exclamation-circle me-2"></i><%=billLookupErr%></div>
<% } else if (!billHistory.isEmpty()) {
    Vector hdr = (Vector) billHistory.get(0);
    Vector pays = (Vector) billHistory.get(1);
    double grandTotal = 0, paidAmt = 0, balAmt = 0;
    try { grandTotal = Double.parseDouble(hdr.get(4).toString()); } catch (Exception _e) {}
    try { paidAmt    = Double.parseDouble(hdr.get(5).toString()); } catch (Exception _e) {}
    try { balAmt     = Double.parseDouble(hdr.get(6).toString()); } catch (Exception _e) {}
    String billDateDisp = hdr.get(2).toString();
    try { billDateDisp = outFmt.format(inFmt.parse(billDateDisp)); } catch (Exception _e) {}
%>
    <!-- Bill summary card -->
    <div class="card mst-card mb-3">
        <div class="mst-card-header">
            <h5 class="mb-0"><i class="fas fa-file-invoice me-2"></i>Bill: <%=hdr.get(1)%>
                <span class="text-muted fs-6 ms-2">| <%=hdr.get(3)%> | <%=billDateDisp%></span>
            </h5>
        </div>
        <div class="card-body">
            <div class="row g-3">
                <div class="col-4">
                    <div class="border rounded p-3 text-center">
                        <div class="small text-muted mb-1">Total Bill Amount</div>
                        <div class="fw-bold fs-5">&#8377;<%=String.format("%,.2f",grandTotal)%></div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="border rounded p-3 text-center bg-light">
                        <div class="small text-muted mb-1">Total Collected</div>
                        <div class="fw-bold fs-5 text-success">&#8377;<%=String.format("%,.2f",paidAmt)%></div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="border rounded p-3 text-center">
                        <div class="small text-muted mb-1">Current Balance</div>
                        <div class="fw-bold fs-5 <%=balAmt>0?"text-danger":"text-success"%>">&#8377;<%=String.format("%,.2f",balAmt)%></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Payment breakdown -->
    <div class="card mst-card">
        <div class="mst-card-header"><h5 class="mb-0"><i class="fas fa-list me-2"></i>Payment Breakdown</h5></div>
        <div class="card-body p-0">
            <div class="table-responsive">
            <table class="table table-bordered mb-0">
                <thead class="table-dark">
                    <tr><th>#</th><th>Type</th><th>Mode</th><th class="tbl-amt">Amount (&#8377;)</th><th class="tbl-amt">Tax (&#8377;)</th><th>Collected By</th><th>Date &amp; Time</th><th class="tbl-amt">Running Balance (&#8377;)</th></tr>
                </thead>
                <tbody>
<%  if (pays.isEmpty()) { %><tr><td colspan="8" class="text-center text-muted py-3">No payment records.</td></tr>
<%  } else {
        double runBal = grandTotal;
        String[] typeNames = {"","Cash","Bank","Mixed"};
        String[] modeNames = {"","UPI","Cheque","Credit Card","Debit Card","NEFT","IMPS"};
        for (int i = 0; i < pays.size(); i++) {
            Vector p = (Vector) pays.get(i);
            double amt = 0; try { amt = Double.parseDouble(p.get(3).toString()); } catch (Exception _e) {}
            double tax = 0; try { tax = Double.parseDouble(p.get(6).toString()); } catch (Exception _e) {}
            runBal -= (amt + tax);
            if (runBal < 0) runBal = 0;
            String typeLbl = i == 0 ? "Initial Payment" : "Balance Collection";
            String typeBadge = i == 0 ? "bg-primary" : "bg-success";
            int ptIdx = 1; try { ptIdx = Integer.parseInt(p.get(1).toString()); } catch (Exception _e) {}
            int pmIdx = 0; try { pmIdx = Integer.parseInt(p.get(2).toString()); } catch (Exception _e) {}
            String tName = (ptIdx>=1&&ptIdx<typeNames.length) ? typeNames[ptIdx] : "";
            String mName = (pmIdx>=1&&pmIdx<modeNames.length) ? modeNames[pmIdx] : "";
            String payLabel = ptIdx==1 ? "Cash" : (mName.isEmpty() ? tName : tName + " / " + mName);
%>
                    <tr>
                        <td><%=i+1%></td>
                        <td><span class="badge <%=typeBadge%>"><%=typeLbl%></span></td>
                        <td><%=payLabel%></td>
                        <td class="tbl-amt fw-bold text-success"><%=String.format("%,.2f",amt)%></td>
                        <td class="tbl-amt text-info"><%=tax>0?String.format("%,.2f",tax):"-"%></td>
                        <td><%=p.get(4)%></td>
                        <td><%=p.get(5)%></td>
                        <td class="tbl-amt <%=runBal>0?"text-danger fw-bold":"text-success fw-bold"%>"><%=String.format("%,.2f",runBal)%></td>
                    </tr>
<%      }
    }
%>
                </tbody>
            </table>
            </div>
        </div>
    </div>
<% } else if (!billNoQ.trim().isEmpty()) { %>
    <div class="alert alert-info"><i class="fas fa-info-circle me-2"></i>Enter a bill number and click Search.</div>
<% } %>
<% } %>

<%-- ── CUSTOMER RESULTS ─────────────────────────────────────── --%>
<% if ("customer".equals(viewMode) && !custIdQ.trim().isEmpty()) {
    double custTotal = 0, custPaid = 0, custBal = 0;
    for (int i = 0; i < custBills.size(); i++) {
        Vector r = (Vector) custBills.get(i);
        try { custTotal += Double.parseDouble(r.get(3).toString()); } catch (Exception _e) {}
        try { custPaid  += Double.parseDouble(r.get(4).toString()); } catch (Exception _e) {}
        try { custBal   += Double.parseDouble(r.get(5).toString()); } catch (Exception _e) {}
    }
%>
    <div class="card mst-card mb-2">
        <div class="card-body py-2 px-3 d-flex align-items-center flex-wrap gap-4">
            <span class="fw-semibold">Customer: <strong><%=custNameQ%></strong></span>
            <span class="text-muted">Bills: <strong><%=custBills.size()%></strong></span>
            <span class="text-success">Total Collected: <strong>&#8377;<%=String.format("%,.2f",custPaid)%></strong></span>
            <span class="text-danger">Balance Due: <strong>&#8377;<%=String.format("%,.2f",custBal)%></strong></span>
        </div>
    </div>
    <div class="card mst-card">
        <div class="card-body p-0">
            <div class="table-responsive">
            <table class="table table-bordered table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Invoice No</th>
                        <th>Bill Date</th>
                        <th class="tbl-amt">Total (&#8377;)</th>
                        <th class="tbl-amt">Paid (&#8377;)</th>
                        <th class="tbl-amt">Balance (&#8377;)</th>
                        <th>Detail</th>
                    </tr>
                </thead>
                <tbody>
<% if (custBills.isEmpty()) { %>
                    <tr><td colspan="7" class="text-center text-muted py-4">No bills found for this customer.</td></tr>
<% } else {
    for (int i = 0; i < custBills.size(); i++) {
        Vector r = (Vector) custBills.get(i);
        String cbId = r.get(0).toString(), cbInvoice = r.get(1).toString(), cbDate = r.get(2).toString();
        double cbTotal = 0, cbPaid = 0, cbBal = 0;
        try { cbTotal = Double.parseDouble(r.get(3).toString()); } catch (Exception _e) {}
        try { cbPaid  = Double.parseDouble(r.get(4).toString()); } catch (Exception _e) {}
        try { cbBal   = Double.parseDouble(r.get(5).toString()); } catch (Exception _e) {}
        String cbDateDisp = cbDate;
        try { cbDateDisp = outFmt.format(inFmt.parse(cbDate)); } catch (Exception _e) {}
%>
                    <tr>
                        <td><%=i+1%></td>
                        <td><strong><%=cbInvoice%></strong></td>
                        <td><%=cbDateDisp%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",cbTotal)%></td>
                        <td class="tbl-amt text-success"><%=String.format("%,.2f",cbPaid)%></td>
                        <td class="tbl-amt <%=cbBal>0?"text-danger fw-bold":"text-success"%>"><%=String.format("%,.2f",cbBal)%></td>
                        <td>
                            <a href="<%=contextPath%>/logistics/balanceCollection/report.jsp?viewMode=bill&billNo=<%=java.net.URLEncoder.encode(cbInvoice,"UTF-8")%>"
                               class="btn btn-sm btn-outline-primary">
                                <i class="fas fa-eye me-1"></i>View
                            </a>
                        </td>
                    </tr>
<% }} %>
                </tbody>
            </table>
            </div>
        </div>
    </div>
<% } %>

</div><!-- /container -->

<script>
var contextPath = '<%=contextPath%>';

$(function() {
    // Customer autocomplete for report page
    $('#r_custName').autocomplete({
        source: function(request, response) {
            $.getJSON(contextPath + '/logistics/order/getCustomers.jsp', { term: request.term }, response);
        },
        minLength: 1,
        select: function(event, ui) {
            $('#r_custId').val(ui.item.id);
            $(this).val(ui.item.label);
            $('#r_custError').hide();
            return false;
        }
    }).on('input', function() { $('#r_custId').val(''); });
});

function switchTab(mode) {
    document.getElementById('frmRange').style.display    = mode === 'range'    ? 'flex' : 'none';
    document.getElementById('frmBill').style.display     = mode === 'bill'     ? 'flex' : 'none';
    document.getElementById('frmCustomer').style.display = mode === 'customer' ? 'flex' : 'none';
    document.querySelectorAll('.tab-btn').forEach(function(btn) { btn.classList.remove('active'); });
    var idx = ['range','bill','customer'].indexOf(mode);
    document.querySelectorAll('.tab-btn')[idx].classList.add('active');
}

function validateCust() {
    if (!$('#r_custId').val()) {
        $('#r_custError').show();
        return false;
    }
    return true;
}

function exportToCsv() {
    var table = document.querySelector('table.table');
    if (!table) return;

    var excludeIndexes = [];
    var headCells = table.querySelectorAll('thead th');
    headCells.forEach(function(th, idx) {
        var txt = (th.textContent || '').trim().toLowerCase();
        if (txt === 'detail' || txt === 'action') excludeIndexes.push(idx);
    });

    var lines = [];

    // Header row
    var headerRow = [];
    headCells.forEach(function(th, idx) {
        if (excludeIndexes.indexOf(idx) !== -1) return;
        headerRow.push(csvCell(th.textContent));
    });
    lines.push(headerRow.join(','));

    // Data rows
    var dataRows = table.querySelectorAll('tbody tr');
    dataRows.forEach(function(row) {
        var rowCells = row.querySelectorAll('td');
        var values = [];
        rowCells.forEach(function(td, idx) {
            if (excludeIndexes.indexOf(idx) !== -1) return;
            values.push(csvCell(td.innerText));
        });
        if (values.length) lines.push(values.join(','));
    });

    var csv = '\uFEFF' + lines.join('\r\n');
    var blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    var url = URL.createObjectURL(blob);
    var a = document.createElement('a');
    var fromDate = '<%=fromDate%>';
    var toDate = '<%=toDate%>';
    a.href = url;
    a.download = 'collection-report-' + fromDate + '-to-' + toDate + '.csv';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
}

function csvCell(value) {
    var text = (value || '').toString().replace(/\r?\n|\r/g, ' ').trim();
    return '"' + text.replace(/"/g, '""') + '"';
}
</script>
</body>
</html>
