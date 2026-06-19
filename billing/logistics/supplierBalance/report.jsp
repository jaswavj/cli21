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
String viewMode  = request.getParameter("viewMode");   // "range" | "lr" | "supplier"
String lrNoQ     = request.getParameter("lrNo");
String supIdQ    = request.getParameter("supId");
String supNameQ  = request.getParameter("supName");
if (fromDate == null || fromDate.trim().isEmpty())  fromDate  = firstOfMonth;
if (toDate   == null || toDate.trim().isEmpty())    toDate    = today;
if (viewMode == null || viewMode.trim().isEmpty())  viewMode  = "range";
if (lrNoQ    == null) lrNoQ    = "";
if (supIdQ   == null) supIdQ   = "";
if (supNameQ == null) supNameQ = "";

Vector reportRows  = new Vector();
Vector lrHistory   = new Vector();
Vector supLrs      = new Vector();
String lrLookupErr = "";

java.text.SimpleDateFormat inFmt  = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.text.SimpleDateFormat outFmt = new java.text.SimpleDateFormat("dd-MM-yyyy");

if ("range".equals(viewMode)) {
    try { reportRows = bill.getSupplierBalanceCollectionReport(fromDate, toDate); } catch (Exception ex) { ex.printStackTrace(); }
} else if ("lr".equals(viewMode) && !lrNoQ.trim().isEmpty()) {
    try {
        int lid = bill.getLrIdByLrNo(lrNoQ.trim());
        if (lid > 0) {
            lrHistory = bill.getSupplierPaymentHistory(lid);
        } else {
            lrLookupErr = "LR \"" + lrNoQ + "\" not found.";
        }
    } catch (Exception ex) { lrLookupErr = ex.getMessage() != null ? ex.getMessage() : "Error"; }
} else if ("supplier".equals(viewMode) && !supIdQ.trim().isEmpty()) {
    try {
        int sid = Integer.parseInt(supIdQ.trim());
        supLrs = bill.getSupplierLrsBySupplier(sid);
    } catch (Exception ex) { ex.printStackTrace(); }
}

double reportTotal = 0;
for (int i = 0; i < reportRows.size(); i++) {
    try { reportTotal += Double.parseDouble(((Vector)reportRows.get(i)).get(4).toString()); } catch (Exception _e) {}
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Supplier Payment Report</title>
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
    request.setAttribute("pageTitle",    "Supplier Payment Report");
    request.setAttribute("pageSubtitle", "Logistics — Supplier LH Payment History");
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
                <button type="button" class="btn btn-outline-primary tab-btn <%="lr".equals(viewMode)?"active":""%>"
                    onclick="switchTab('lr')"><i class="fas fa-file-alt me-1"></i>By LR No</button>
                <button type="button" class="btn btn-outline-primary tab-btn <%="supplier".equals(viewMode)?"active":""%>"
                    onclick="switchTab('supplier')"><i class="fas fa-truck me-1"></i>By Supplier</button>
            </div>

            <!-- Date Range filter -->
            <form id="frmRange" method="get" action="<%=contextPath%>/logistics/supplierBalance/report.jsp"
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

            <!-- LR No filter -->
            <form id="frmLr" method="get" action="<%=contextPath%>/logistics/supplierBalance/report.jsp"
                  class="row g-2 align-items-end" style="display:<%="lr".equals(viewMode)?"flex":"none"%>!important;">
                <input type="hidden" name="viewMode" value="lr">
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">LR No</label>
                    <input type="text" name="lrNo" class="form-control fg-inp" placeholder="e.g. 111"
                           value="<%=lrNoQ%>" style="min-width:160px;">
                </div>
                <div class="col-auto">
                    <button type="submit" class="bb bb-primary"><i class="fas fa-search me-1"></i>Search</button>
                </div>
            </form>

            <!-- Supplier filter -->
            <form id="frmSupplier" method="get" action="<%=contextPath%>/logistics/supplierBalance/report.jsp"
                  class="row g-2 align-items-end" style="display:<%="supplier".equals(viewMode)?"flex":"none"%>!important;">
                <input type="hidden" name="viewMode" value="supplier">
                <input type="hidden" id="r_supId" name="supId" value="<%=supIdQ%>">
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">Supplier Name</label>
                    <input type="text" id="r_supName" name="supName" class="form-control fg-inp"
                           placeholder="Type supplier name..." autocomplete="off"
                           value="<%=supNameQ.replace("\"","&quot;")%>" style="min-width:220px;">
                    <div id="r_supError" class="text-danger small mt-1" style="display:none;">Please select a valid supplier.</div>
                </div>
                <div class="col-auto">
                    <button type="submit" class="bb bb-primary" onclick="return validateSup()">
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
                <span class="fw-semibold">Payments: <span class="badge bg-secondary"><%=reportRows.size()%></span></span>
                <span class="fw-semibold text-success">Total Paid: <strong>&#8377;<%=String.format("%,.2f",reportTotal)%></strong></span>
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
                        <th>LR No</th>
                        <th>LR Date</th>
                        <th>Supplier</th>
                        <th class="tbl-amt">Amount Paid (&#8377;)</th>
                        <th>Payment Mode</th>
                        <th>Paid By</th>
                        <th>Paid On</th>
                    </tr>
                </thead>
                <tbody>
<% if (reportRows.isEmpty()) { %>
                    <tr><td colspan="8" class="text-center text-muted py-4">No payments found for the selected date range.</td></tr>
<% } else {
    for (int i = 0; i < reportRows.size(); i++) {
        Vector r = (Vector) reportRows.get(i);
        double amt = 0; try { amt = Double.parseDouble(r.get(4).toString()); } catch (Exception _e) {}
        int payTypeIdx = 1; try { payTypeIdx = Integer.parseInt(r.get(5).toString()); } catch (Exception _e) {}
        int payModeIdx = 0; try { payModeIdx = Integer.parseInt(r.get(6).toString()); } catch (Exception _e) {}
        String[] typeNames = {"","Cash","Bank"};
        String[] modeNames = {"","UPI","Cheque","Credit Card","Debit Card","NEFT","IMPS"};
        String typeName = (payTypeIdx>=1&&payTypeIdx<typeNames.length) ? typeNames[payTypeIdx] : "";
        String modeName = (payModeIdx>=1&&payModeIdx<modeNames.length) ? modeNames[payModeIdx] : "";
        String payLabel = payTypeIdx==1 ? "Cash" : (modeName.isEmpty() ? typeName : typeName + " / " + modeName);
        String lrDateDisp = r.get(2).toString();
        try { lrDateDisp = outFmt.format(inFmt.parse(lrDateDisp)); } catch (Exception _e) {}
%>
                    <tr>
                        <td><%=i+1%></td>
                        <td><strong><%=r.get(1)%></strong></td>
                        <td><%=lrDateDisp%></td>
                        <td><%=r.get(3)%></td>
                        <td class="tbl-amt fw-bold text-success"><%=String.format("%,.2f",amt)%></td>
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

<%-- ── LR NO RESULTS ────────────────────────────────────────── --%>
<% if ("lr".equals(viewMode)) { %>
<% if (!lrLookupErr.isEmpty()) { %>
    <div class="alert alert-danger"><i class="fas fa-exclamation-circle me-2"></i><%=lrLookupErr%></div>
<% } else if (!lrHistory.isEmpty()) {
    Vector hdr  = (Vector) lrHistory.get(0);
    Vector pays = (Vector) lrHistory.get(1);
    double lhAmt  = 0, lhPaid = 0, lhBal = 0;
    try { lhAmt  = Double.parseDouble(hdr.get(4).toString()); } catch (Exception _e) {}
    try { lhPaid = Double.parseDouble(hdr.get(5).toString()); } catch (Exception _e) {}
    try { lhBal  = Double.parseDouble(hdr.get(6).toString()); } catch (Exception _e) {}
    String lrDateDisp = hdr.get(2).toString();
    try { lrDateDisp = outFmt.format(inFmt.parse(lrDateDisp)); } catch (Exception _e) {}
%>
    <!-- LR summary card -->
    <div class="card mst-card mb-3">
        <div class="mst-card-header">
            <h5 class="mb-0"><i class="fas fa-file-alt me-2"></i>LR: <%=hdr.get(1)%>
                <span class="text-muted fs-6 ms-2">| <%=hdr.get(3)%> | <%=lrDateDisp%></span>
            </h5>
        </div>
        <div class="card-body">
            <div class="row g-3">
                <div class="col-4">
                    <div class="border rounded p-3 text-center">
                        <div class="small text-muted mb-1">LH (Supplier Amount)</div>
                        <div class="fw-bold fs-5">&#8377;<%=String.format("%,.2f",lhAmt)%></div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="border rounded p-3 text-center bg-light">
                        <div class="small text-muted mb-1">Total Paid</div>
                        <div class="fw-bold fs-5 text-success">&#8377;<%=String.format("%,.2f",lhPaid)%></div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="border rounded p-3 text-center">
                        <div class="small text-muted mb-1">Balance</div>
                        <div class="fw-bold fs-5 <%=lhBal>0?"text-danger":"text-success"%>">&#8377;<%=String.format("%,.2f",lhBal)%></div>
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
                    <tr><th>#</th><th>Type</th><th>Mode</th><th class="tbl-amt">Amount (&#8377;)</th><th>Paid By</th><th>Date &amp; Time</th><th class="tbl-amt">Running Balance (&#8377;)</th></tr>
                </thead>
                <tbody>
<%  if (pays.isEmpty()) { %><tr><td colspan="7" class="text-center text-muted py-3">No payment records.</td></tr>
<%  } else {
        double runBal = lhAmt;
        String[] typeNames = {"","Cash","Bank"};
        String[] modeNames = {"","UPI","Cheque","Credit Card","Debit Card","NEFT","IMPS"};
        for (int i = 0; i < pays.size(); i++) {
            Vector p = (Vector) pays.get(i);
            double amt = 0; try { amt = Double.parseDouble(p.get(3).toString()); } catch (Exception _e) {}
            runBal -= amt;
            if (runBal < 0) runBal = 0;
            String typeLbl   = i == 0 ? "Initial Payment" : "Balance Payment";
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
<% } else if (!lrNoQ.trim().isEmpty()) { %>
    <div class="alert alert-info"><i class="fas fa-info-circle me-2"></i>Enter a LR number and click Search.</div>
<% } %>
<% } %>

<%-- ── SUPPLIER RESULTS ─────────────────────────────────────── --%>
<% if ("supplier".equals(viewMode) && !supIdQ.trim().isEmpty()) {
    double supTotalLh = 0, supTotalPaid = 0, supTotalBal = 0;
    for (int i = 0; i < supLrs.size(); i++) {
        Vector r = (Vector) supLrs.get(i);
        try { supTotalLh   += Double.parseDouble(r.get(3).toString()); } catch (Exception _e) {}
        try { supTotalPaid += Double.parseDouble(r.get(4).toString()); } catch (Exception _e) {}
        try { supTotalBal  += Double.parseDouble(r.get(5).toString()); } catch (Exception _e) {}
    }
%>
    <div class="card mst-card mb-2">
        <div class="card-body py-2 px-3 d-flex align-items-center flex-wrap gap-4">
            <span class="fw-semibold">Supplier: <strong><%=supNameQ%></strong></span>
            <span class="text-muted">LRs: <strong><%=supLrs.size()%></strong></span>
            <span class="text-success">Total Paid: <strong>&#8377;<%=String.format("%,.2f",supTotalPaid)%></strong></span>
            <span class="text-danger">Balance Due: <strong>&#8377;<%=String.format("%,.2f",supTotalBal)%></strong></span>
        </div>
    </div>
    <div class="card mst-card">
        <div class="card-body p-0">
            <div class="table-responsive">
            <table class="table table-bordered table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>LR No</th>
                        <th>LR Date</th>
                        <th>Vehicle No</th>
                        <th class="tbl-amt">LH (&#8377;)</th>
                        <th class="tbl-amt">Paid (&#8377;)</th>
                        <th class="tbl-amt">Balance (&#8377;)</th>
                        <th>Detail</th>
                    </tr>
                </thead>
                <tbody>
<% if (supLrs.isEmpty()) { %>
                    <tr><td colspan="8" class="text-center text-muted py-4">No LR orders found for this supplier.</td></tr>
<% } else {
    for (int i = 0; i < supLrs.size(); i++) {
        Vector r = (Vector) supLrs.get(i);
        String sLrId = r.get(0).toString(), sLrNo = r.get(1).toString(), sLrDate = r.get(2).toString();
        double sLh = 0, sPaid = 0, sBal = 0;
        try { sLh   = Double.parseDouble(r.get(3).toString()); } catch (Exception _e) {}
        try { sPaid = Double.parseDouble(r.get(4).toString()); } catch (Exception _e) {}
        try { sBal  = Double.parseDouble(r.get(5).toString()); } catch (Exception _e) {}
        String sVehicle = r.get(6).toString();
        String sLrDateDisp = sLrDate;
        try { sLrDateDisp = outFmt.format(inFmt.parse(sLrDate)); } catch (Exception _e) {}
%>
                    <tr>
                        <td><%=i+1%></td>
                        <td><strong><%=sLrNo%></strong></td>
                        <td><%=sLrDateDisp%></td>
                        <td><%=sVehicle.isEmpty()?"-":sVehicle%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f",sLh)%></td>
                        <td class="tbl-amt text-success"><%=String.format("%,.2f",sPaid)%></td>
                        <td class="tbl-amt <%=sBal>0?"text-danger fw-bold":"text-success"%>"><%=String.format("%,.2f",sBal)%></td>
                        <td>
                            <a href="<%=contextPath%>/logistics/supplierBalance/report.jsp?viewMode=lr&lrNo=<%=java.net.URLEncoder.encode(sLrNo,"UTF-8")%>"
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
    $('#r_supName').autocomplete({
        source: function(request, response) {
            $.getJSON(contextPath + '/logistics/order/getSuppliers.jsp', { term: request.term }, response);
        },
        minLength: 1,
        select: function(event, ui) {
            $('#r_supId').val(ui.item.id);
            $(this).val(ui.item.label);
            $('#r_supError').hide();
            return false;
        }
    }).on('input', function() { $('#r_supId').val(''); });
});

function switchTab(mode) {
    document.getElementById('frmRange').style.display    = mode === 'range'    ? 'flex' : 'none';
    document.getElementById('frmLr').style.display       = mode === 'lr'       ? 'flex' : 'none';
    document.getElementById('frmSupplier').style.display = mode === 'supplier' ? 'flex' : 'none';
    document.querySelectorAll('.tab-btn').forEach(function(btn) { btn.classList.remove('active'); });
    var idx = ['range','lr','supplier'].indexOf(mode);
    document.querySelectorAll('.tab-btn')[idx].classList.add('active');
}

function validateSup() {
    if (!document.getElementById('r_supId').value) {
        document.getElementById('r_supError').style.display = '';
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
    a.download = 'supplier-payment-report-' + fromDate + '-to-' + toDate + '.csv';
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
