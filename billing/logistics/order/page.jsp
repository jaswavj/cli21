<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page errorPage="" %>
<jsp:useBean id="bill" class="billing.billingBean" />

<%
// Session check
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}

String msg  = request.getParameter("msg");
String type = request.getParameter("type");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LR Order Entry</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>
<%
    request.setAttribute("pageTitle",    "LR Order Entry");
    request.setAttribute("pageSubtitle", "Create a new logistics order");
    request.setAttribute("pageIcon",     "fa-solid fa-truck");
%>
<jsp:include page="/assets/common/pageHeader.jsp" />

<div class="container-fluid mt-3 mst-page" style="max-width:960px;">

    <div class="card mst-card">
        <div class="mst-card-header">
            <h5 class="mb-0"><i class="fa-solid fa-truck me-2"></i>New LR Order</h5>
        </div>
        <div class="card-body p-4">
            <form action="<%=contextPath%>/logistics/order/saveOrder.jsp" method="post" onsubmit="return validateForm()">

                <!-- Row 1 : Supplier + Date -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Supplier Name</label>
                        <input type="hidden" name="supplierId" id="supplierId">
                        <div class="input-group">
                            <input type="text" id="supplierName" class="form-control fg-inp" autocomplete="off"
                                   placeholder="Type supplier name...">
                            <button type="button" class="btn" style="background:#e0e0e0;border:1px solid #ccc;" title="Add New Supplier"
                                    onclick="window.open('<%=contextPath%>/product/master/supplier/page.jsp','_blank','width=900,height=600,scrollbars=yes')">
                                <i class="fas fa-plus"></i>
                            </button>
                        </div>
                        <div id="supplierError" class="text-danger small mt-1" style="display:none;">Please select a valid supplier from the list.</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Date</label>
                        <input type="date" name="lrDate" id="lrDate" class="form-control fg-inp" required
                               value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                    </div>
                </div>

                <!-- Row 2 : Vehicle No + Driver Phone -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Vehicle Number</label>
                        <input type="text" name="vehicleNo" id="vehicleNo" class="form-control fg-inp"
                               placeholder="e.g. TN01AB1234" maxlength="50" style="text-transform:uppercase;">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Driver Phone</label>
                        <input type="text" name="driverPhone" id="driverPhone" class="form-control fg-inp"
                               placeholder="10-digit mobile" maxlength="20" inputmode="numeric">
                    </div>
                </div>

                <!-- Row 3 : LR No + Customer -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">LR No</label>
                        <div class="input-group">
                            <input type="text" name="lrNo" id="lrNo" class="form-control fg-inp"
                                   placeholder="Enter LR Number" maxlength="100">
                            <span class="input-group-text" id="lrNoStatus" style="display:none;"></span>
                        </div>
                        <div id="lrNoError" class="text-danger small mt-1" style="display:none;"></div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Customer Name</label>
                        <input type="hidden" name="customerId" id="customerId">
                        <div class="input-group">
                            <input type="text" id="customerName" class="form-control fg-inp" autocomplete="off"
                                   placeholder="Type customer name...">
                            <button type="button" class="btn" style="background:#e0e0e0;border:1px solid #ccc;" title="Add New Customer"
                                    onclick="window.open('<%=contextPath%>/product/master/customer/page.jsp','_blank','width=900,height=600,scrollbars=yes')">
                                <i class="fas fa-plus"></i>
                            </button>
                        </div>
                        <div id="customerError" class="text-danger small mt-1" style="display:none;">Please select a valid customer from the list.</div>
                    </div>
                </div>

                <!-- Row 3 : Destination -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Destination</label>
                    <input type="text" name="destination" id="destination" class="form-control fg-inp"
                           placeholder="Enter destination" maxlength="255">
                </div>

                <!-- Row 4 : Amount boxes -->
                <div class="card p-3 mb-3 bg-light border">
                    <h6 class="fw-bold mb-3"><i class="fa-solid fa-indian-rupee-sign me-1"></i>Amount Details</h6>
                    <div class="row g-3">
                        <div class="col-6 col-md-4">
                            <label class="form-label fw-semibold">DPF</label>
                            <input type="number" step="0.01" min="0" name="dpf" id="dpf"
                                   class="form-control fg-inp amount-field" placeholder="0.00" value="0">
                        </div>
                        <div class="col-6 col-md-4">
                            <label class="form-label fw-semibold">LH</label>
                            <input type="number" step="0.01" min="0" name="lh" id="lh"
                                   class="form-control fg-inp amount-field" placeholder="0.00" value="0">
                        </div>
                        <div class="col-6 col-md-4">
                            <label class="form-label fw-semibold">LOAD</label>
                            <input type="number" step="0.01" min="0" name="loadAmt" id="loadAmt"
                                   class="form-control fg-inp amount-field" placeholder="0.00" value="0">
                        </div>
                        <div class="col-6 col-md-4">
                            <label class="form-label fw-semibold">U/L</label>
                            <input type="number" step="0.01" min="0" name="ul" id="ul"
                                   class="form-control fg-inp amount-field" placeholder="0.00" value="0">
                        </div>
                        <div class="col-6 col-md-4">
                            <label class="form-label fw-semibold">LC</label>
                            <input type="number" step="0.01" min="0" name="lc" id="lc"
                                   class="form-control fg-inp amount-field" placeholder="0.00" value="0">
                        </div>
                        <div class="col-6 col-md-4">
                            <label class="form-label fw-semibold">HOTING</label>
                            <input type="number" step="0.01" min="0" name="hoting" id="hoting"
                                   class="form-control fg-inp amount-field" placeholder="0.00" value="0">
                        </div>
                        <div class="col-6 col-md-4 d-flex align-items-end">
                            <div class="w-100">
                                <label class="form-label fw-semibold" id="profitLabel">Profit</label>
                                <input type="text" id="totalAmount" class="form-control fg-inp fw-bold"
                                       readonly value="0.00">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Supplier Payment Section -->
                <div class="card p-3 mb-3 border" style="background:#f0f8ff;">
                    <h6 class="fw-bold mb-3"><i class="fa-solid fa-truck-ramp-box me-1"></i>Supplier Payment &mdash; LH: <span id="lhDisplay">0.00</span> &#8377;</h6>
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label fw-semibold"><i class="fa-solid fa-wallet fa-sm me-1"></i>Payment Type</label>
                            <div class="btn-group w-100" id="supPayTypeGroup" role="group">
                                <button type="button" class="btn btn-outline-primary sup-pay-type-btn active" data-type="1" onclick="supSelectPayType(this)">
                                    <i class="fa-solid fa-money-bill-wave fa-xs me-1"></i>Cash
                                </button>
                                <button type="button" class="btn btn-outline-primary sup-pay-type-btn" data-type="2" onclick="supSelectPayType(this)">
                                    <i class="fa-solid fa-building-columns fa-xs me-1"></i>Bank
                                </button>
                            </div>
                            <input type="hidden" name="supPayType" id="supPayType" value="1">
                            <input type="hidden" name="supPayMode" id="supPayModeHidden" value="0">
                        </div>
                        <div class="col-md-6" id="supPayModeWrap" style="opacity:0.45;">
                            <label class="form-label fw-semibold"><i class="fa-solid fa-credit-card fa-sm me-1"></i>Payment Mode</label>
                            <select id="supPayModeSelect" class="form-select fg-inp" disabled>
                                <option value="1">UPI</option>
                                <option value="2">Cheque</option>
                                <option value="3">Credit Card</option>
                                <option value="4">Debit Card</option>
                                <option value="5">NEFT</option>
                                <option value="6">IMPS</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Paid Amount (&#8377;)</label>
                            <input type="number" step="0.01" min="0" name="supPaid" id="supPaid" class="form-control fg-inp" placeholder="0.00" value="0">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Balance (&#8377;)</label>
                            <input type="text" id="supBalance" class="form-control fg-inp fw-bold" readonly value="0.00" style="color:#dc3545;">
                        </div>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="d-flex gap-2 justify-content-end mt-4">
                    <button type="reset" class="bb bb-outline" onclick="resetForm()">
                        <i class="fa-solid fa-rotate-left me-2"></i>Reset
                    </button>
                    <button type="submit" class="bb bb-primary" id="btnSave">
                        <i class="fa-solid fa-floppy-disk me-2"></i>Save Order
                    </button>
                </div>

            </form>
        </div>
    </div>
</div>

<script>
var lrNoValid    = true;
var lrNoChecked  = false;

$(function() {

    <% if (msg != null) { %>
    Swal.fire({
        icon: '<%= "danger".equals(type) ? "error" : ("warning".equals(type) ? "warning" : "success") %>',
        title: '<%= "danger".equals(type) ? "Error" : ("warning".equals(type) ? "Warning" : "Success") %>',
        text: '<%=msg.replace("'", "\\'")%>',
        confirmButtonText: 'OK'
    });
    history.replaceState(null, '', window.location.pathname);
    <% } %>

    // Supplier autocomplete (AJAX)
    $('#supplierName').autocomplete({
        source: function(request, response) {
            $.getJSON('<%=request.getContextPath()%>/logistics/order/getSuppliers.jsp', { term: request.term }, response);
        },
        minLength: 1,
        select: function(event, ui) {
            $('#supplierId').val(ui.item.id);
            $('#supplierName').val(ui.item.label);
            $('#supplierError').hide();
            return false;
        }
    }).on('input', function() {
        $('#supplierId').val('');
    });

    // Customer autocomplete (AJAX)
    $('#customerName').autocomplete({
        source: function(request, response) {
            $.getJSON('<%=request.getContextPath()%>/logistics/order/getCustomers.jsp', { term: request.term }, response);
        },
        minLength: 1,
        select: function(event, ui) {
            $('#customerId').val(ui.item.id);
            $('#customerName').val(ui.item.label);
            $('#customerError').hide();
            return false;
        }
    }).on('input', function() {
        $('#customerId').val('');
    });

    // LR No duplicate check on blur
    $('#lrNo').on('blur', function() {
        var lrNo = $(this).val().trim();
        if (!lrNo) { clearLrStatus(); return; }
        $.ajax({
            url: '<%=request.getContextPath()%>/logistics/order/checkLrNo.jsp',
            type: 'GET',
            data: { lrNo: lrNo },
            success: function(res) {
                lrNoChecked = true;
                if ($.trim(res) === 'EXISTS') {
                    lrNoValid = false;
                    $('#lrNoStatus').show().html('<i class="fas fa-times-circle text-danger"></i>');
                    $('#lrNoError').show().text('This LR No already exists. Please enter a different one.');
                    $('#lrNo').addClass('is-invalid').removeClass('is-valid');
                    $('#btnSave').hide();
                    Swal.fire({
                        icon: 'warning',
                        title: 'Duplicate LR No',
                        text: 'LR No "' + lrNo + '" is already saved. Please use a different LR number.',
                        confirmButtonText: 'OK'
                    });
                } else {
                    lrNoValid = true;
                    $('#lrNoStatus').show().html('<i class="fas fa-check-circle text-success"></i>');
                    $('#lrNoError').hide();
                    $('#lrNo').addClass('is-valid').removeClass('is-invalid');
                    $('#btnSave').show();
                }
            },
            error: function() { lrNoChecked = true; clearLrStatus(); }
        });
    }).on('input', function() {
        lrNoValid   = true;
        lrNoChecked = false;
        clearLrStatus();
        $('#btnSave').show();
    });

    // Amount fields: select all on focus
    $('.amount-field').on('focus', function() { this.select(); }).on('input', calcProfit);

    // LH field: also update supplier LH display and balance
    $('#lh').on('input', function() {
        var lh = parseFloat($(this).val()) || 0;
        $('#lhDisplay').text(lh.toFixed(2));
        calcSupBalance();
    });
    $('#supPaid').on('focus', function() { this.select(); }).on('input', calcSupBalance);
});

function clearLrStatus() {
    $('#lrNoStatus').hide().html('');
    $('#lrNoError').hide();
    $('#lrNo').removeClass('is-invalid is-valid');
}

function calcProfit() {
    var dpf    = parseFloat($('#dpf').val())     || 0;
    var lh     = parseFloat($('#lh').val())      || 0;
    var load   = parseFloat($('#loadAmt').val()) || 0;
    var ul     = parseFloat($('#ul').val())      || 0;
    var lc     = parseFloat($('#lc').val())      || 0;
    var hoting = parseFloat($('#hoting').val())  || 0;
    var profit = dpf - (lh + load + ul + lc + hoting);
    $('#totalAmount').val(profit.toFixed(2));
    var color = profit > 0 ? '#198754' : (profit < 0 ? '#dc3545' : '');
    $('#totalAmount, #profitLabel').css('color', color);
}

function calcSupBalance() {
    var lh   = parseFloat($('#lh').val())   || 0;
    var paid = parseFloat($('#supPaid').val()) || 0;
    var bal  = lh - paid;
    $('#supBalance').val(bal.toFixed(2));
    $('#supBalance').css('color', bal > 0 ? '#dc3545' : '#198754');
}

function supSelectPayType(btn) {
    $('.sup-pay-type-btn').removeClass('active');
    $(btn).addClass('active');
    var type = parseInt($(btn).data('type'));
    $('#supPayType').val(type);
    if (type === 1) {
        $('#supPayModeSelect').prop('disabled', true);
        $('#supPayModeHidden').val('0');
        $('#supPayModeWrap').css('opacity', '0.45');
    } else {
        $('#supPayModeSelect').prop('disabled', false);
        $('#supPayModeWrap').css('opacity', '1');
        $('#supPayModeHidden').val($('#supPayModeSelect').val());
    }
}

// sync select -> hidden when changed
$(document).on('change', '#supPayModeSelect', function() {
    $('#supPayModeHidden').val($(this).val());
});

function resetForm() {
    $('#supplierId, #customerId').val('');
    $('#supplierName, #customerName').val('');
    $('#supplierError, #customerError').hide();
    $('#vehicleNo, #driverPhone').val('');
    clearLrStatus();
    lrNoValid   = true;
    lrNoChecked = false;
    $('#btnSave').show();
    $('#totalAmount').val('0.00');
    $('#totalAmount, #profitLabel').css('color', '');
    $('#supPaid').val('0');
    $('#supBalance').val('0.00').css('color', '#dc3545');
    $('#lhDisplay').text('0.00');
    $('.sup-pay-type-btn').removeClass('active');
    $('.sup-pay-type-btn[data-type="1"]').addClass('active');
    $('#supPayType').val('1');
    $('#supPayModeHidden').val('0');
    $('#supPayModeSelect').prop('disabled', true);
    $('#supPayModeWrap').css('opacity', '0.45');
}

function validateForm() {
    if (!$('#supplierId').val()) {
        $('#supplierError').show();
        $('#supplierName').focus();
        Swal.fire({ icon: 'warning', title: 'Validation', text: 'Please select a valid supplier from the list.' });
        return false;
    }
    if (!$('#lrDate').val()) {
        Swal.fire({ icon: 'warning', title: 'Validation', text: 'Please select a date.' });
        return false;
    }
    var lrNoVal = $('#lrNo').val().trim();
    if (!lrNoVal) {
        Swal.fire({ icon: 'warning', title: 'Validation', text: 'Please enter LR No.' });
        $('#lrNo').focus();
        return false;
    }
    if (!lrNoChecked) {
        $('#lrNo').blur();  // trigger AJAX check
        Swal.fire({ icon: 'info', title: 'Validating LR No', text: 'LR No is being checked. Please click Save again.' });
        return false;
    }
    if (!lrNoValid) {
        Swal.fire({ icon: 'warning', title: 'Duplicate LR No', text: 'This LR No already exists. Please use a different one.' });
        $('#lrNo').focus();
        return false;
    }
    if (!$('#customerId').val()) {
        $('#customerError').show();
        $('#customerName').focus();
        Swal.fire({ icon: 'warning', title: 'Validation', text: 'Please select a valid customer from the list.' });
        return false;
    }
    if (!$('#destination').val().trim()) {
        Swal.fire({ icon: 'warning', title: 'Validation', text: 'Please enter destination.' });
        $('#destination').focus();
        return false;
    }
    var lhVal   = parseFloat($('#lh').val()) || 0;
    var supPaid = parseFloat($('#supPaid').val()) || 0;
    if (supPaid > lhVal + 0.001) {
        Swal.fire({ icon: 'warning', title: 'Validation', text: 'Supplier paid amount cannot exceed LH amount (\u20b9' + lhVal.toFixed(2) + ').' });
        $('#supPaid').focus();
        return false;
    }
    return true;
}
</script>
</body>
</html>
