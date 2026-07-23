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
try { pendingList = bill.getTransportPendingBalances(); } catch (Exception ex) { ex.printStackTrace(); }

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
    <title>Transport Balance Collection</title>
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
    request.setAttribute("pageTitle",    "Balance Collection");
    request.setAttribute("pageSubtitle", "Logistics — Pending Transport Bill Payments");
    request.setAttribute("pageIcon",     "fa-solid fa-money-bill-wave");
%>
<jsp:include page="/assets/common/pageHeader.jsp" />

<div class="container-fluid mt-3 mst-page">

    <!-- Summary card -->
    <div class="row mb-3">
        <div class="col-12 col-md-4">
            <div class="card mst-card text-white" style="background:linear-gradient(135deg,#dc2626,#991b1b);border:none;">
                <div class="card-body py-3 px-4">
                    <div class="small fw-bold text-uppercase opacity-75 mb-1">Total Pending Balance</div>
                    <div class="fs-3 fw-bold">&#8377;<%= String.format("%,.2f", totalPending) %></div>
                    <div class="small opacity-75 mt-1"><%= pendingList.size() %> bill<%= pendingList.size() != 1 ? "s" : "" %> pending</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Search bar -->
    <div class="card mst-card mb-3">
        <div class="card-body py-2 px-3">
            <div class="row g-2 align-items-end">
                <div class="col-auto">
                    <input type="text" id="fltInvoice" class="form-control fg-inp" placeholder="Search invoice..." style="min-width:150px;">
                </div>
                <div class="col-auto">
                    <input type="text" id="fltCustomer" class="form-control fg-inp" placeholder="Search customer..." style="min-width:180px;">
                </div>
                <div class="col-auto">
                    <label for="fltFromDate" class="form-label small mb-1">From Bill Date</label>
                    <input type="date" id="fltFromDate" class="form-control fg-inp" style="min-width:170px;">
                </div>
                <div class="col-auto">
                    <label for="fltToDate" class="form-label small mb-1">To Bill Date</label>
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

    <!-- Pending bills table -->
    <div class="card mst-card">
        <div class="mst-card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fa-solid fa-list me-2"></i>Pending Bills
                <span class="badge bg-secondary ms-2"><%= pendingList.size() %></span>
            </h5>
            <button type="button" class="bb bb-success" onclick="downloadPendingExcel()">
                <i class="fa-solid fa-file-excel me-1"></i>Download Excel
            </button>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
            <table class="table table-bordered table-hover mb-0" id="pendingTable">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Invoice No</th>
                        <th>Bill Date</th>
                        <th>Customer</th>
                        <th class="tbl-amt">Total (&#8377;)</th>
                        <th class="tbl-amt">Paid (&#8377;)</th>
                        <th class="tbl-amt">Balance (&#8377;)</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
<%
if (pendingList.isEmpty()) {
%>
                    <tr><td colspan="8" class="text-center text-muted py-4">No pending balances found.</td></tr>
<%
} else {
    for (int i = 0; i < pendingList.size(); i++) {
        Vector row = (Vector) pendingList.get(i);
        String billId     = row.get(0).toString();
        String invoiceNo  = row.get(1).toString();
        String billDate   = row.get(2).toString();
        String custName   = row.get(3).toString();
        double grandTotal = 0, paidAmt = 0, balAmt = 0;
        try { grandTotal = Double.parseDouble(row.get(4).toString()); } catch (Exception _e) {}
        try { paidAmt    = Double.parseDouble(row.get(5).toString()); } catch (Exception _e) {}
        try { balAmt     = Double.parseDouble(row.get(6).toString()); } catch (Exception _e) {}
        String billDateDisplay = billDate;
        try {
            java.text.SimpleDateFormat inFmt2  = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.text.SimpleDateFormat outFmt2 = new java.text.SimpleDateFormat("dd-MM-yyyy");
            billDateDisplay = outFmt2.format(inFmt2.parse(billDate));
        } catch (Exception _e) {}
%>
                    <tr data-invoice="<%=invoiceNo.toLowerCase()%>" data-customer="<%=custName.toLowerCase()%>" data-billdate="<%=billDate%>">
                        <td><%=i+1%></td>
                        <td><strong><%=invoiceNo%></strong></td>
                        <td><%=billDateDisplay%></td>
                        <td><%=custName%></td>
                        <td class="tbl-amt"><%=String.format("%,.2f", grandTotal)%></td>
                        <td class="tbl-amt text-success"><%=String.format("%,.2f", paidAmt)%></td>
                        <td class="tbl-amt bal-pos"><%=String.format("%,.2f", balAmt)%></td>
                        <td>
                            <button class="btn btn-sm btn-success me-1"
                                onclick="showCollect('<%=billId%>','<%=invoiceNo.replace("'","\\'")%>','<%=custName.replace("'","\\'")%>','<%=String.format("%.2f",balAmt)%>')">
                                <i class="fas fa-hand-holding-usd me-1"></i>Collect
                            </button>
                            <button class="btn btn-sm btn-outline-info"
                                onclick="showHistory('<%=billId%>','<%=invoiceNo.replace("'","\\'")%>')">
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

<!-- Collect Payment Modal -->
<div class="modal fade" id="collectModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><i class="fas fa-hand-holding-usd me-2"></i>Collect Balance Payment</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" id="c_billId">
        <div class="mb-3">
            <label class="form-label fw-semibold">Invoice No</label>
            <input type="text" id="c_invoiceNo" class="form-control fg-inp" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Customer</label>
            <input type="text" id="c_customer" class="form-control fg-inp" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Current Balance (&#8377;)</label>
            <input type="text" id="c_balance" class="form-control fg-inp fw-bold text-danger" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold"><i class="fa-solid fa-wallet fa-sm me-1"></i>Payment Type</label>
            <div class="btn-group w-100" id="c_payTypeGroup" role="group">
                <button type="button" class="btn btn-outline-primary c-pay-type-btn active" data-type="1" onclick="collectSelectPayType(this)">
                    <i class="fa-solid fa-money-bill-wave fa-xs me-1"></i>Cash
                </button>
                <button type="button" class="btn btn-outline-primary c-pay-type-btn" data-type="2" onclick="collectSelectPayType(this)">
                    <i class="fa-solid fa-building-columns fa-xs me-1"></i>Bank
                </button>
            </div>
        </div>
        <div class="mb-3" id="c_payModeWrap" style="opacity:0.45;">
            <label class="form-label fw-semibold"><i class="fa-solid fa-credit-card fa-sm me-1"></i>Payment Mode</label>
            <select id="c_payMode" class="form-select fg-inp" disabled>
                <option value="1">UPI</option>
                <option value="2">Cheque</option>
                <option value="3">Credit Card</option>
                <option value="4">Debit Card</option>
                <option value="5">NEFT</option>
                <option value="6">IMPS</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Amount to Collect (&#8377;)</label>
            <input type="number" step="0.01" min="0" id="c_payNow" class="form-control fg-inp" placeholder="Enter amount">
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Tax Amount (&#8377;)</label>
            <input type="number" step="0.01" min="0" id="c_taxAmount" class="form-control fg-inp" placeholder="Enter tax (if any)" value="0">
            <div id="c_payError" class="text-danger small mt-1" style="display:none;"></div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="bb bb-outline" data-bs-dismiss="modal">
            <i class="fas fa-times me-1"></i>Close
        </button>
        <button type="button" class="bb bb-primary" onclick="submitCollect()">
            <i class="fas fa-check me-1"></i>Confirm Payment
        </button>
      </div>
    </div>
  </div>
</div>

<!-- Payment History Modal -->
<div class="modal fade" id="historyModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><i class="fas fa-history me-2"></i>Payment History — <span id="h_invoiceNo"></span></h5>
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
    $('#fltInvoice, #fltCustomer').on('input', applyFilters);
    $('#fltFromDate, #fltToDate').on('change', applyFilters);
});

function applyFilters() {
    var inv = $('#fltInvoice').val().trim().toLowerCase();
    var cust = $('#fltCustomer').val().trim().toLowerCase();
    var fromDate = $('#fltFromDate').val();
    var toDate = $('#fltToDate').val();
    $('#pendingTable tbody tr').each(function() {
        var r = $(this);
        var rowDate = (r.data('billdate') || '').toString();
        var dateMatch = true;
        if (fromDate) dateMatch = dateMatch && !!rowDate && rowDate >= fromDate;
        if (toDate) dateMatch = dateMatch && !!rowDate && rowDate <= toDate;
        var match = (!inv  || (r.data('invoice')  || '').includes(inv))
                 && (!cust || (r.data('customer') || '').includes(cust))
                 && dateMatch;
        r.toggle(match);
    });
}
function clearFilters() {
    $('#fltInvoice, #fltCustomer, #fltFromDate, #fltToDate').val('');
    applyFilters();
}

function csvCell(value) {
    var text = (value || '').toString().replace(/\r?\n|\r/g, ' ').trim();
    return '"' + text.replace(/"/g, '""') + '"';
}

function downloadPendingExcel() {
    var table = document.getElementById('pendingTable');
    if (!table) return;

    var excludeIndexes = [];
    var headCells = table.querySelectorAll('thead th');
    headCells.forEach(function(th, idx) {
        var txt = (th.textContent || '').trim().toLowerCase();
        if (txt === 'action') excludeIndexes.push(idx);
    });

    var lines = [];
    var headerRow = [];
    headCells.forEach(function(th, idx) {
        if (excludeIndexes.indexOf(idx) !== -1) return;
        headerRow.push(csvCell(th.textContent));
    });
    lines.push(headerRow.join(','));

    var exported = 0;
    var totalAmt = 0, paidAmt = 0, balAmt = 0;
    $('#pendingTable tbody tr').each(function() {
        var row = this;
        if (!$(row).is(':visible')) return;
        if (row.querySelector('td[colspan]')) return;

        var rowCells = row.querySelectorAll('td');
        var values = [];
        rowCells.forEach(function(td, idx) {
            if (excludeIndexes.indexOf(idx) !== -1) return;
            values.push(csvCell(td.innerText));
        });
        if (values.length) {
            lines.push(values.join(','));
            exported++;
            try { totalAmt += parseFloat((rowCells[4].innerText || '0').replace(/,/g, '')); } catch (_e) {}
            try { paidAmt += parseFloat((rowCells[5].innerText || '0').replace(/,/g, '')); } catch (_e) {}
            try { balAmt += parseFloat((rowCells[6].innerText || '0').replace(/,/g, '')); } catch (_e) {}
        }
    });

    if (exported === 0) {
        Swal.fire({ icon: 'info', title: 'No Data', text: 'No rows available to download.' });
        return;
    }

    lines.push(['', '', '', csvCell('Total'), csvCell(totalAmt.toFixed(2)), csvCell(paidAmt.toFixed(2)), csvCell(balAmt.toFixed(2))].join(','));

    var csv = '\uFEFF' + lines.join('\r\n');
    var blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    var url = URL.createObjectURL(blob);
    var a = document.createElement('a');
    var fromDate = $('#fltFromDate').val() || 'all';
    var toDate = $('#fltToDate').val() || 'all';
    a.href = url;
    a.download = 'pending-balance-list-' + fromDate + '-to-' + toDate + '.csv';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
}

function showCollect(billId, invoiceNo, customer, balance) {
    $('#c_billId').val(billId);
    $('#c_invoiceNo').val(invoiceNo);
    $('#c_customer').val(customer);
    $('#c_balance').val(balance);
    $('#c_payNow').val('');
    $('#c_taxAmount').val('0');
    $('#c_payError').hide();
    new bootstrap.Modal(document.getElementById('collectModal')).show();
}

function collectSelectPayType(btn) {
    $('#c_payTypeGroup .c-pay-type-btn').removeClass('active');
    $(btn).addClass('active');
    var type = parseInt($(btn).data('type'));
    if (type === 1) {
        $('#c_payMode').prop('disabled', true);
        $('#c_payModeWrap').css('opacity', '0.45');
    } else {
        $('#c_payMode').prop('disabled', false);
        if (!$('#c_payMode').val()) $('#c_payMode').val('1');
        $('#c_payModeWrap').css('opacity', '1');
    }
}

function submitCollect() {
    var billId    = $('#c_billId').val();
    var payNow    = parseFloat($('#c_payNow').val()) || 0;
    var taxAmount = parseFloat($('#c_taxAmount').val()) || 0;
    var balance   = parseFloat($('#c_balance').val()) || 0;
    var payType   = parseInt($('#c_payTypeGroup .c-pay-type-btn.active').data('type')) || 1;
    var payMode   = payType === 1 ? 0 : (parseInt($('#c_payMode').val()) || 1);
    var total     = payNow + taxAmount;

    if (total <= 0) {
        $('#c_payError').text('Please enter a valid amount.').show(); return;
    }
    if (total > balance + 0.001) {
        $('#c_payError').text('Amount + Tax (\u20b9' + total.toFixed(2) + ') cannot exceed balance of \u20b9' + balance.toFixed(2)).show(); return;
    }
    $('#c_payError').hide();

    var html = 'Collect <strong>\u20b9' + payNow.toFixed(2) + '</strong>';
    if (taxAmount > 0) html += ' + Tax <strong>\u20b9' + taxAmount.toFixed(2) + '</strong>';
    html += ' for bill <strong>' + $('#c_invoiceNo').val() + '</strong>?';

    Swal.fire({
        icon: 'question',
        title: 'Confirm Payment?',
        html: html,
        showCancelButton: true,
        confirmButtonColor: '#198754',
        confirmButtonText: 'Yes, Collect',
        cancelButtonText: 'Cancel'
    }).then(function(result) {
        if (!result.isConfirmed) return;
        $.post(contextPath + '/logistics/balanceCollection/savePayment.jsp', {
            billId: billId, payNow: payNow, taxAmount: taxAmount, payType: payType, payMode: payMode
        }, function(res) {
            res = $.trim(res);
            if (res === 'OK') {
                bootstrap.Modal.getInstance(document.getElementById('collectModal')).hide();
                Swal.fire({ icon: 'success', title: 'Collected!', text: 'Payment recorded successfully.', timer: 1500, showConfirmButton: false })
                    .then(function() { location.reload(); });
            } else {
                Swal.fire({ icon: 'error', title: 'Error', text: res || 'Failed to save payment.' });
            }
        }).fail(function() {
            Swal.fire({ icon: 'error', title: 'Error', text: 'Server error. Please try again.' });
        });
    });
}

function showHistory(billId, invoiceNo) {
    $('#h_invoiceNo').text(invoiceNo);
    $('#historyModalBody').html('<div class="text-center py-4"><i class="fas fa-spinner fa-spin fa-2x"></i></div>');
    new bootstrap.Modal(document.getElementById('historyModal')).show();
    $.getJSON(contextPath + '/logistics/balanceCollection/getPaymentHistory.jsp', { billId: billId }, function(data) {
        if (data.error) {
            $('#historyModalBody').html('<div class="alert alert-danger">' + data.error + '</div>');
            return;
        }
        var html = '';
        // Summary bar
        html += '<div class="row mb-3 g-2">';
        html += '<div class="col-4"><div class="p-2 rounded border text-center"><div class="small text-muted">Total Bill</div><div class="fw-bold">\u20b9' + parseFloat(data.grandTotal).toLocaleString('en-IN',{minimumFractionDigits:2}) + '</div></div></div>';
        html += '<div class="col-4"><div class="p-2 rounded border text-center bg-light"><div class="small text-muted">Total Paid</div><div class="fw-bold text-success">\u20b9' + parseFloat(data.paidAmount).toLocaleString('en-IN',{minimumFractionDigits:2}) + '</div></div></div>';
        html += '<div class="col-4"><div class="p-2 rounded border text-center"><div class="small text-muted">Balance</div><div class="fw-bold text-danger">\u20b9' + parseFloat(data.balance).toLocaleString('en-IN',{minimumFractionDigits:2}) + '</div></div></div>';
        html += '</div>';
        html += '<div class="table-responsive"><table class="table table-bordered table-sm">';
        html += '<thead class="table-dark"><tr><th>#</th><th>Type</th><th>Payment Mode</th><th>Amount (&#8377;)</th><th>Tax (&#8377;)</th><th>Collected By</th><th>Date &amp; Time</th></tr></thead><tbody>';
        var typeNames = ['','Cash','Bank'];
        var modeNames = ['','UPI','Cheque','Credit Card','Debit Card','NEFT','IMPS'];
        if (data.payments && data.payments.length > 0) {
            var runBal = parseFloat(data.grandTotal);
            for (var i = 0; i < data.payments.length; i++) {
                var p = data.payments[i];
                var amt = parseFloat(p.paidAmount) || 0;
                var tax = parseFloat(p.taxAmount) || 0;
                runBal -= (amt + tax);
                var ptIdx = parseInt(p.paymentType) || 1;
                var pmIdx = parseInt(p.paymentMode) || 0;
                var tName = typeNames[ptIdx] || '';
                var mName = pmIdx > 0 ? (modeNames[pmIdx] || '') : '';
                var payLabel = ptIdx === 1 ? 'Cash' : (mName ? tName + ' / ' + mName : tName);
                var badge = i === 0 ? '<span class="badge bg-primary ms-1">Initial</span>' : '<span class="badge bg-success ms-1">Collection</span>';
                html += '<tr>'
                      + '<td>' + (i+1) + badge + '</td>'
                      + '<td>' + (typeNames[ptIdx] || '-') + '</td>'
                      + '<td>' + payLabel + '</td>'
                      + '<td class="text-end fw-bold">' + amt.toLocaleString('en-IN',{minimumFractionDigits:2}) + '</td>'
                      + '<td class="text-end text-info">' + (tax > 0 ? tax.toLocaleString('en-IN',{minimumFractionDigits:2}) : '-') + '</td>'
                      + '<td>' + (p.collectedBy || '-') + '</td>'
                      + '<td>' + (p.collectedOn || '-') + '</td>'
                      + '</tr>';
            }
        } else {
            html += '<tr><td colspan="7" class="text-center text-muted">No payment records found.</td></tr>';
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
