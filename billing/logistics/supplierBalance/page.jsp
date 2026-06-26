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

Vector pendingList = new Vector();
try { pendingList = bill.getSupplierPendingBalances(); } catch (Exception ex) { ex.printStackTrace(); }

double totalPending = 0;
for (int i = 0; i < pendingList.size(); i++) {
    try { totalPending += Double.parseDouble(((Vector)pendingList.get(i)).get(6).toString()); } catch (Exception _e) {}
}

String msg  = request.getParameter("msg");
String type = request.getParameter("type");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Supplier Balance Collection</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        .tbl-amt { text-align:right; min-width:90px; }
        .bal-pos { color:#dc3545; font-weight:600; }
        .bal-zero{ color:#198754; font-weight:600; }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>
<%
    request.setAttribute("pageTitle",    "Supplier Balance Collection");
    request.setAttribute("pageSubtitle", "Logistics — Pending Supplier (LH) Payments");
    request.setAttribute("pageIcon",     "fa-solid fa-truck-ramp-box");
%>
<jsp:include page="/assets/common/pageHeader.jsp" />

<div class="container-fluid mt-3 mst-page">

    <!-- Summary card -->
    <div class="row mb-3">
        <div class="col-12 col-md-4">
            <div class="card mst-card text-white" style="background:linear-gradient(135deg,#7c3aed,#4c1d95);border:none;">
                <div class="card-body py-3 px-4">
                    <div class="small fw-bold text-uppercase opacity-75 mb-1">Total Pending (LH)</div>
                    <div class="fs-3 fw-bold">&#8377;<%= String.format("%,.2f", totalPending) %></div>
                    <div class="small opacity-75 mt-1"><%= pendingList.size() %> LR<%= pendingList.size() != 1 ? "s" : "" %> pending</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Search bar -->
    <div class="card mst-card mb-3">
        <div class="card-body py-2 px-3">
            <div class="row g-2 align-items-end">
                <div class="col-auto">
                    <input type="text" id="fltLrNo" class="form-control fg-inp" placeholder="Search LR No..." style="min-width:140px;">
                </div>
                <div class="col-auto">
                    <input type="text" id="fltSupplier" class="form-control fg-inp" placeholder="Search supplier..." style="min-width:180px;">
                </div>
                <div class="col-auto">
                    <label for="fltFromDate" class="form-label small mb-1">From LR Date</label>
                    <input type="date" id="fltFromDate" class="form-control fg-inp" style="min-width:170px;">
                </div>
                <div class="col-auto">
                    <label for="fltToDate" class="form-label small mb-1">To LR Date</label>
                    <input type="date" id="fltToDate" class="form-control fg-inp" style="min-width:170px;">
                </div>
                <div class="col-auto">
                    <button type="button" class="bb bb-secondary" onclick="clearFilters()">
                        <i class="fa-solid fa-xmark me-1"></i>Clear
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Pending LRs table -->
    <div class="card mst-card">
        <div class="mst-card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fa-solid fa-list me-2"></i>Pending LR Orders
                <span class="badge bg-secondary ms-2"><%= pendingList.size() %></span>
            </h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
            <table class="table table-bordered table-hover mb-0" id="pendingTable">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>LR No</th>
                        <th>LR Date</th>
                        <th>Supplier</th>
                        <th>Vehicle No</th>
                        <th class="tbl-amt">LH (&#8377;)</th>
                        <th class="tbl-amt">Paid (&#8377;)</th>
                        <th class="tbl-amt">Balance (&#8377;)</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
<%
if (pendingList.isEmpty()) {
%>
                    <tr><td colspan="9" class="text-center text-muted py-4">No pending supplier balances found.</td></tr>
<%
} else {
    for (int i = 0; i < pendingList.size(); i++) {
        Vector row = (Vector) pendingList.get(i);
        String lrId      = row.get(0).toString();
        String lrNo      = row.get(1).toString();
        String lrDate    = row.get(2).toString();
        String supName   = row.get(3).toString();
        double lhAmt = 0, paidAmt = 0, balAmt = 0;
        try { lhAmt   = Double.parseDouble(row.get(4).toString()); } catch (Exception _e) {}
        try { paidAmt = Double.parseDouble(row.get(5).toString()); } catch (Exception _e) {}
        try { balAmt  = Double.parseDouble(row.get(6).toString()); } catch (Exception _e) {}
        String vehicleNo = row.get(7).toString();
        String lrDateDisplay = lrDate;
        try {
            java.text.SimpleDateFormat inFmt2  = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.text.SimpleDateFormat outFmt2 = new java.text.SimpleDateFormat("dd-MM-yyyy");
            lrDateDisplay = outFmt2.format(inFmt2.parse(lrDate));
        } catch (Exception _e) {}
%>
                    <tr data-lrno="<%=lrNo.toLowerCase()%>" data-supplier="<%=supName.toLowerCase()%>" data-lrdate="<%=lrDate%>">
                        <td><%=i+1%></td>
                        <td><strong><%=lrNo%></strong></td>
                        <td><%=lrDateDisplay%></td>
                        <td><%=supName%></td>
                        <td><%=vehicleNo.isEmpty()?"-":vehicleNo%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f", lhAmt)%></td>
                        <td class="tbl-amt text-success"><%=String.format("%,.2f", paidAmt)%></td>
                        <td class="tbl-amt bal-pos"><%=String.format("%,.2f", balAmt)%></td>
                        <td>
                            <button class="btn btn-sm btn-success me-1"
                                onclick="showPay('<%=lrId%>','<%=lrNo.replace("'","\\'")%>','<%=supName.replace("'","\\'")%>','<%=String.format("%.2f",balAmt)%>')">
                                <i class="fas fa-hand-holding-usd me-1"></i>Pay
                            </button>
                            <button class="btn btn-sm btn-outline-info"
                                onclick="showHistory('<%=lrId%>','<%=lrNo.replace("'","\\'")%>')">
                                <i class="fas fa-history me-1"></i>History
                            </button>
                        </td>
                    </tr>
<%  } } %>
                </tbody>
            </table>
            </div>
        </div>
    </div>
</div>

<!-- Pay Modal -->
<div class="modal fade" id="payModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><i class="fas fa-hand-holding-usd me-2"></i>Pay Supplier Balance</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" id="p_lrId">
        <div class="mb-3">
            <label class="form-label fw-semibold">LR No</label>
            <input type="text" id="p_lrNo" class="form-control fg-inp" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Supplier</label>
            <input type="text" id="p_supplier" class="form-control fg-inp" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Current Balance (&#8377;)</label>
            <input type="text" id="p_balance" class="form-control fg-inp fw-bold text-danger" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold"><i class="fa-solid fa-wallet fa-sm me-1"></i>Payment Type</label>
            <div class="btn-group w-100" id="p_payTypeGroup" role="group">
                <button type="button" class="btn btn-outline-primary p-pay-type-btn active" data-type="1" onclick="paySelectType(this)">
                    <i class="fa-solid fa-money-bill-wave fa-xs me-1"></i>Cash
                </button>
                <button type="button" class="btn btn-outline-primary p-pay-type-btn" data-type="2" onclick="paySelectType(this)">
                    <i class="fa-solid fa-building-columns fa-xs me-1"></i>Bank
                </button>
            </div>
        </div>
        <div class="mb-3" id="p_payModeWrap" style="opacity:0.45;">
            <label class="form-label fw-semibold"><i class="fa-solid fa-credit-card fa-sm me-1"></i>Payment Mode</label>
            <select id="p_payMode" class="form-select fg-inp" disabled>
                <option value="1">UPI</option>
                <option value="2">Cheque</option>
                <option value="3">Credit Card</option>
                <option value="4">Debit Card</option>
                <option value="5">NEFT</option>
                <option value="6">IMPS</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Amount to Pay (&#8377;)</label>
            <input type="number" step="0.01" min="0.01" id="p_payNow" class="form-control fg-inp" placeholder="Enter amount">
            <div id="p_payError" class="text-danger small mt-1" style="display:none;"></div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="bb bb-outline" data-bs-dismiss="modal">
            <i class="fas fa-times me-1"></i>Close
        </button>
        <button type="button" class="bb bb-primary" onclick="submitPay()">
            <i class="fas fa-check me-1"></i>Confirm Payment
        </button>
      </div>
    </div>
  </div>
</div>

<!-- History Modal -->
<div class="modal fade" id="historyModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><i class="fas fa-history me-2"></i>Payment History — <span id="h_lrNo"></span></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body" id="historyModalBody">
        <div class="text-center py-4"><i class="fas fa-spinner fa-spin fa-2x"></i></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="bb bb-outline" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script>
var contextPath = '<%=contextPath%>';

$(function() {
    <% if (msg != null) { %>
    Swal.fire({
        icon: '<%= "error".equals(type) ? "error" : "success" %>',
        title: '<%= "error".equals(type) ? "Error" : "Success" %>',
        text: '<%=msg.replace("'","\\'")%>'
    });
    <% } %>
    $('#fltLrNo, #fltSupplier').on('input', applyFilters);
    $('#fltFromDate, #fltToDate').on('change', applyFilters);
});

function applyFilters() {
    var lr   = $('#fltLrNo').val().trim().toLowerCase();
    var sup  = $('#fltSupplier').val().trim().toLowerCase();
    var fromDate = $('#fltFromDate').val();
    var toDate = $('#fltToDate').val();
    $('#pendingTable tbody tr').each(function() {
        var r = $(this);
        var rowDate = (r.data('lrdate') || '').toString();
        var dateMatch = true;
        if (fromDate) dateMatch = dateMatch && !!rowDate && rowDate >= fromDate;
        if (toDate) dateMatch = dateMatch && !!rowDate && rowDate <= toDate;
        var match = (!lr  || (r.data('lrno')     || '').includes(lr))
                 && (!sup || (r.data('supplier')  || '').includes(sup))
                 && dateMatch;
        r.toggle(match);
    });
}
function clearFilters() {
    $('#fltLrNo, #fltSupplier, #fltFromDate, #fltToDate').val('');
    applyFilters();
}

function showPay(lrId, lrNo, supplier, balance) {
    $('#p_lrId').val(lrId);
    $('#p_lrNo').val(lrNo);
    $('#p_supplier').val(supplier);
    $('#p_balance').val(balance);
    $('#p_payNow').val('');
    $('#p_payError').hide();
    $('.p-pay-type-btn').removeClass('active');
    $('.p-pay-type-btn[data-type="1"]').addClass('active');
    $('#p_payMode').prop('disabled', true);
    $('#p_payModeWrap').css('opacity', '0.45');
    new bootstrap.Modal(document.getElementById('payModal')).show();
}

function paySelectType(btn) {
    $('#p_payTypeGroup .p-pay-type-btn').removeClass('active');
    $(btn).addClass('active');
    var type = parseInt($(btn).data('type'));
    if (type === 1) {
        $('#p_payMode').prop('disabled', true);
        $('#p_payModeWrap').css('opacity', '0.45');
    } else {
        $('#p_payMode').prop('disabled', false);
        if (!$('#p_payMode').val()) $('#p_payMode').val('1');
        $('#p_payModeWrap').css('opacity', '1');
    }
}

function submitPay() {
    var lrId    = $('#p_lrId').val();
    var payNow  = parseFloat($('#p_payNow').val()) || 0;
    var balance = parseFloat($('#p_balance').val()) || 0;
    var payType = parseInt($('#p_payTypeGroup .p-pay-type-btn.active').data('type')) || 1;
    var payMode = payType === 1 ? 0 : (parseInt($('#p_payMode').val()) || 1);

    if (payNow <= 0) {
        $('#p_payError').text('Please enter a valid amount.').show(); return;
    }
    if (payNow > balance + 0.001) {
        $('#p_payError').text('Amount cannot exceed balance of \u20b9' + balance.toFixed(2)).show(); return;
    }
    $('#p_payError').hide();

    Swal.fire({
        icon: 'question',
        title: 'Confirm Payment?',
        html: 'Pay <strong>\u20b9' + payNow.toFixed(2) + '</strong> to supplier for LR <strong>' + $('#p_lrNo').val() + '</strong>?',
        showCancelButton: true,
        confirmButtonColor: '#7c3aed',
        confirmButtonText: 'Yes, Pay',
        cancelButtonText: 'Cancel'
    }).then(function(result) {
        if (!result.isConfirmed) return;
        $.post(contextPath + '/logistics/supplierBalance/savePayment.jsp', {
            lrId: lrId, payNow: payNow, payType: payType, payMode: payMode
        }, function(res) {
            res = $.trim(res);
            if (res === 'OK') {
                bootstrap.Modal.getInstance(document.getElementById('payModal')).hide();
                Swal.fire({ icon: 'success', title: 'Paid!', text: 'Payment recorded successfully.', timer: 1500, showConfirmButton: false })
                    .then(function() { location.reload(); });
            } else {
                Swal.fire({ icon: 'error', title: 'Error', text: res || 'Failed to save payment.' });
            }
        }).fail(function() {
            Swal.fire({ icon: 'error', title: 'Error', text: 'Server error. Please try again.' });
        });
    });
}

function showHistory(lrId, lrNo) {
    $('#h_lrNo').text(lrNo);
    $('#historyModalBody').html('<div class="text-center py-4"><i class="fas fa-spinner fa-spin fa-2x"></i></div>');
    new bootstrap.Modal(document.getElementById('historyModal')).show();
    $.getJSON(contextPath + '/logistics/supplierBalance/getPaymentHistory.jsp', { lrId: lrId }, function(data) {
        if (data.error) {
            $('#historyModalBody').html('<div class="alert alert-danger">' + data.error + '</div>');
            return;
        }
        var html = '';
        html += '<div class="row mb-3 g-2">';
        html += '<div class="col-4"><div class="p-2 rounded border text-center"><div class="small text-muted">LH Total</div><div class="fw-bold">\u20b9' + parseFloat(data.lh).toLocaleString('en-IN',{minimumFractionDigits:2}) + '</div></div></div>';
        html += '<div class="col-4"><div class="p-2 rounded border text-center bg-light"><div class="small text-muted">Total Paid</div><div class="fw-bold text-success">\u20b9' + parseFloat(data.lhPaid).toLocaleString('en-IN',{minimumFractionDigits:2}) + '</div></div></div>';
        html += '<div class="col-4"><div class="p-2 rounded border text-center"><div class="small text-muted">Balance</div><div class="fw-bold text-danger">\u20b9' + parseFloat(data.lhBalance).toLocaleString('en-IN',{minimumFractionDigits:2}) + '</div></div></div>';
        html += '</div>';
        html += '<div class="table-responsive"><table class="table table-bordered table-sm">';
        html += '<thead class="table-dark"><tr><th>#</th><th>Type</th><th>Payment Mode</th><th class="text-end">Amount (&#8377;)</th><th>Paid By</th><th>Date &amp; Time</th></tr></thead><tbody>';
        var typeNames = ['','Cash','Bank'];
        var modeNames = ['','UPI','Cheque','Credit Card','Debit Card','NEFT','IMPS'];
        if (data.payments && data.payments.length > 0) {
            var runBal = parseFloat(data.lh);
            for (var i = 0; i < data.payments.length; i++) {
                var p = data.payments[i];
                var amt = parseFloat(p.paidAmount) || 0;
                runBal -= amt;
                if (runBal < 0) runBal = 0;
                var ptIdx = parseInt(p.paymentType) || 1;
                var pmIdx = parseInt(p.paymentMode) || 0;
                var tName = typeNames[ptIdx] || '';
                var mName = pmIdx > 0 ? (modeNames[pmIdx] || '') : '';
                var payLabel = ptIdx === 1 ? 'Cash' : (mName ? tName + ' / ' + mName : tName);
                var badge = i === 0 ? '<span class="badge bg-primary ms-1">Initial</span>' : '<span class="badge bg-success ms-1">Payment</span>';
                html += '<tr>'
                      + '<td>' + (i+1) + badge + '</td>'
                      + '<td>' + (typeNames[ptIdx] || '-') + '</td>'
                      + '<td>' + payLabel + '</td>'
                      + '<td class="text-end fw-bold">' + amt.toLocaleString('en-IN',{minimumFractionDigits:2}) + '</td>'
                      + '<td>' + (p.paidBy || '-') + '</td>'
                      + '<td>' + (p.paidOn || '-') + '</td>'
                      + '</tr>';
            }
        } else {
            html += '<tr><td colspan="6" class="text-center text-muted">No payment records found.</td></tr>';
        }
        html += '</tbody></table></div>';
        $('#historyModalBody').html(html);
    }).fail(function() {
        $('#historyModalBody').html('<div class="alert alert-danger">Failed to load history.</div>');
    });
}
</script>
</body>
</html>
