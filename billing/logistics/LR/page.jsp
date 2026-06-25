<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}
String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Prepare LR</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        .lr-copy-wrap { max-width: 1150px; }
        .lr-copy-card { border: 1px solid #dfe6ee; border-radius: 14px; }
        .lr-copy-card .card-header { background: linear-gradient(135deg, #12324a, #245477); color: #fff; }
        .field-title { font-size: 12px; font-weight: 700; color: #4b6070; margin-bottom: 6px; }
        .payment-grid { border: 1px dashed #ccd8e2; border-radius: 10px; padding: 10px; background: #f8fbfe; }
        .save-state { font-size: 12px; color: #6c757d; }
        .row-spacer { margin-top: 14px; }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>
<%
    request.setAttribute("pageTitle", "Prepare LR");
    request.setAttribute("pageSubtitle", "LR Copy Entry and Edit");
    request.setAttribute("pageIcon", "fa-solid fa-file-lines");
%>
<jsp:include page="/assets/common/pageHeader.jsp" />

<div class="container-fluid mt-3 mst-page lr-copy-wrap">
    <div class="card lr-copy-card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fa-solid fa-file-signature me-2"></i>LR Copy - Prepare LR</h5>
            <div class="d-flex gap-2 align-items-center">
                <input type="text" id="searchLrNo" class="form-control form-control-sm" placeholder="Enter LR No and press Enter" style="width:220px;">
                <span class="save-state" id="saveState">New Entry</span>
            </div>
        </div>
        <div class="card-body p-4">
            <form id="lrForm">
                <input type="hidden" id="id" name="id">
                <input type="hidden" id="customerId" name="customerId">

                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="field-title">Customer Name</label>
                        <input type="text" class="form-control fg-inp" id="customerName" name="customerName" autocomplete="off" placeholder="Type customer name">
                    </div>
                    <div class="col-md-4">
                        <label class="field-title">Phone Number</label>
                        <input type="text" class="form-control fg-inp" id="phoneNumber" name="phoneNumber" placeholder="Phone number">
                    </div>
                    <div class="col-md-4">
                        <label class="field-title">Date</label>
                        <input type="date" class="form-control fg-inp" id="lrDate" name="lrDate" value="<%=today%>">
                    </div>
                </div>

                <div class="row g-3 row-spacer">
                    <div class="col-md-4">
                        <label class="field-title">Truck</label>
                        <input type="text" class="form-control fg-inp" id="truckNo" name="truckNo">
                    </div>
                    <div class="col-md-4">
                        <label class="field-title">From</label>
                        <input type="text" class="form-control fg-inp" id="fromLocation" name="fromLocation">
                    </div>
                    <div class="col-md-4">
                        <label class="field-title">To</label>
                        <input type="text" class="form-control fg-inp" id="toLocation" name="toLocation">
                    </div>
                </div>

                <div class="row g-3 row-spacer">
                    <div class="col-md-6">
                        <label class="field-title">Consignee Name</label>
                        <input type="text" class="form-control fg-inp" id="consigneeName" name="consigneeName" placeholder="Select or type consignee">
                    </div>
                </div>

                <div class="payment-grid row-spacer">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="field-title">No of Articles</label>
                            <input type="text" class="form-control fg-inp" id="noOfArticles" name="noOfArticles">
                        </div>
                        <div class="col-md-3">
                            <label class="field-title">Description</label>
                            <input type="text" class="form-control fg-inp" id="descriptionText" name="descriptionText" value="Said to Contain">
                        </div>
                        <div class="col-md-2">
                            <label class="field-title">Weight (M.T)</label>
                            <input type="text" class="form-control fg-inp" id="weightMt" name="weightMt">
                        </div>
                        <div class="col-md-4">
                            <label class="field-title">Mode of Payment (Blank)</label>
                            <input type="text" class="form-control fg-inp" id="modePayment1" name="modePayment1" placeholder="Any text">
                        </div>
                        <div class="col-md-4">
                            <label class="field-title">Freight Amount Rs</label>
                            <input type="text" class="form-control fg-inp" id="freightAmount" name="freightAmount">
                        </div>
                        <div class="col-md-4">
                            <label class="field-title">To Pay Amount Rs</label>
                            <input type="text" class="form-control fg-inp" id="toPayAmount" name="toPayAmount">
                        </div>
                        <div class="col-md-4">
                            <label class="field-title">Paid Amount Rs</label>
                            <input type="text" class="form-control fg-inp" id="paidAmount" name="paidAmount">
                        </div>
                    </div>
                </div>

                <div class="row g-3 row-spacer">
                    <div class="col-md-6"><label class="field-title">In Words</label><input type="text" class="form-control fg-inp" id="amountInWords" name="amountInWords"></div>
                    <div class="col-md-3"><label class="field-title">DC No</label><input type="text" class="form-control fg-inp" id="dcNo" name="dcNo"></div>
                    <div class="col-md-3"><label class="field-title">Inv Date</label><input type="date" class="form-control fg-inp" id="invDate" name="invDate"></div>

                    <div class="col-md-3"><label class="field-title">Inv No</label><input type="text" class="form-control fg-inp" id="invNo" name="invNo"></div>
                    <div class="col-md-3"><label class="field-title">Inv Date 2</label><input type="date" class="form-control fg-inp" id="invDate2" name="invDate2"></div>
                    <div class="col-md-3"><label class="field-title">Declared Value Rs</label><input type="text" class="form-control fg-inp" id="declaredValueRs" name="declaredValueRs"></div>
                    <div class="col-md-3"><label class="field-title">PNL Seal No</label><input type="text" class="form-control fg-inp" id="pnlSealNo" name="pnlSealNo"></div>

                    <div class="col-md-3"><label class="field-title">Material Received Date</label><input type="date" class="form-control fg-inp" id="materialReceivedDate" name="materialReceivedDate"></div>
                    <div class="col-md-3"><label class="field-title">PNL No</label><input type="text" class="form-control fg-inp" id="pnlNo" name="pnlNo"></div>
                    <div class="col-md-3"><label class="field-title">Driver Name</label><input type="text" class="form-control fg-inp" id="driverName" name="driverName"></div>
                    <div class="col-md-3"><label class="field-title">Type of Vehicle</label><input type="text" class="form-control fg-inp" id="vehicleType" name="vehicleType"></div>

                    <div class="col-md-4">
                        <label class="field-title">Deliver In</label>
                        <select class="form-select fg-inp" id="deliverIn" name="deliverIn">
                            <option value="">Select</option>
                            <option value="Door delivery">Door delivery</option>
                            <option value="Unloaded by party">Unloaded by party</option>
                            <option value="By transporter">By transporter</option>
                        </select>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4">
                    <button type="button" class="bb bb-outline" id="btnReset">Refresh</button>
                    <button type="button" class="bb bb-danger" id="btnCancel" style="display:none;">Cancel LR</button>
                    <button type="button" class="bb bb-primary" id="btnSave">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
(function() {
    var saveDisabledAfterSave = false;

    function setSaveState(text) { $('#saveState').text(text); }

    function disableSaveAfterSuccess() {
        saveDisabledAfterSave = true;
        $('#btnSave').prop('disabled', true);
        setSaveState('Saved. Refresh to enable save');
    }

    function enableSave() {
        saveDisabledAfterSave = false;
        $('#btnSave').prop('disabled', false);
        setSaveState($('#id').val() ? 'Edit Mode' : 'New Entry');
    }

    function resetForm() {
        document.getElementById('lrForm').reset();
        $('#id').val('');
        $('#customerId').val('');
        $('#lrDate').val('<%=today%>');
        $('#searchLrNo').val('');
        $('#btnCancel').hide();
        enableSave();
    }

    function esc(v) { return (v || '').toString().replace(/[&<>\"]/g, function(m){ return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[m]; }); }

    $('#customerName').autocomplete({
        source: function(req, res) {
            $.getJSON('<%=request.getContextPath()%>/logistics/LR/getCustomers.jsp', { term: req.term }, function(data) {
                res($.map(data, function(item) {
                    return { label: item.label, value: item.label, id: item.id, phone: item.phone };
                }));
            });
        },
        minLength: 1,
        select: function(e, ui) {
            $('#customerId').val(ui.item.id);
            $('#customerName').val(ui.item.value);
            if (!$('#phoneNumber').val()) $('#phoneNumber').val(ui.item.phone || '');
            if (!$('#consigneeName').val()) $('#consigneeName').val(ui.item.value);
            return false;
        }
    }).on('input', function() {
        $('#customerId').val('');
    });

    $('#consigneeName').autocomplete({
        source: function(req, res) {
            $.getJSON('<%=request.getContextPath()%>/logistics/LR/getCustomers.jsp', { term: req.term }, function(data) {
                res($.map(data, function(item) {
                    return { label: item.label, value: item.label };
                }));
            });
        },
        minLength: 1
    });

    $('#searchLrNo').on('keypress', function(e) {
        if (e.which !== 13) return;
        e.preventDefault();

        var lrNo = $(this).val().trim();
        if (!lrNo) return;

        $.getJSON('<%=request.getContextPath()%>/logistics/LR/getLRByNo.jsp', { lrNo: lrNo }, function(resp) {
            if (!resp || resp.status !== 'OK') {
                Swal.fire({ icon: 'warning', title: 'Not found', text: (resp && resp.message) ? resp.message : 'LR not found' });
                return;
            }

            $('#id').val(resp.id);
            $('#customerId').val(resp.customerId);
            $('#customerName').val(resp.customerName);
            $('#phoneNumber').val(resp.phoneNumber);
            $('#lrDate').val(resp.lrDate);
            $('#truckNo').val(resp.truckNo);
            $('#fromLocation').val(resp.fromLocation);
            $('#toLocation').val(resp.toLocation);
            $('#consigneeName').val(resp.consigneeName);
            $('#noOfArticles').val(resp.noOfArticles);
            $('#descriptionText').val(resp.descriptionText);
            $('#weightMt').val(resp.weightMt);
            $('#modePayment1').val(resp.modePayment1);
            $('#freightAmount').val(resp.freightAmount);
            $('#toPayAmount').val(resp.toPayAmount);
            $('#paidAmount').val(resp.paidAmount);
            $('#amountInWords').val(resp.amountInWords);
            $('#dcNo').val(resp.dcNo);
            $('#invDate').val(resp.invDate);
            $('#invNo').val(resp.invNo);
            $('#invDate2').val(resp.invDate2);
            $('#declaredValueRs').val(resp.declaredValueRs);
            $('#pnlSealNo').val(resp.pnlSealNo);
            $('#materialReceivedDate').val(resp.materialReceivedDate);
            $('#pnlNo').val(resp.pnlNo);
            $('#driverName').val(resp.driverName);
            $('#vehicleType').val(resp.vehicleType);
            $('#deliverIn').val(resp.deliverIn);

            $('#btnCancel').show();
            $('#btnSave').prop('disabled', resp.isCancelled == 1);
            setSaveState(resp.isCancelled == 1 ? 'Cancelled LR' : 'Edit Mode');
        }).fail(function() {
            Swal.fire({ icon: 'error', title: 'Error', text: 'Failed to fetch LR details' });
        });
    });

    $('#btnSave').on('click', function() {
        if (saveDisabledAfterSave) return;
        $.ajax({
            url: '<%=request.getContextPath()%>/logistics/LR/saveLR.jsp',
            type: 'POST',
            dataType: 'json',
            data: $('#lrForm').serialize(),
            success: function(resp) {
                if (resp.status === 'OK') {
                    if (resp.id) $('#id').val(resp.id);
                    if (resp.lrNo) $('#searchLrNo').val(resp.lrNo);
                    Swal.fire({ icon: 'success', title: 'Success', text: resp.message + (resp.lrNo ? (' - LR No: ' + resp.lrNo) : '') });
                    $('#btnCancel').show();
                    disableSaveAfterSuccess();
                } else {
                    Swal.fire({ icon: 'error', title: 'Error', text: resp.message || 'Save failed' });
                }
            },
            error: function() {
                Swal.fire({ icon: 'error', title: 'Error', text: 'Unable to save LR' });
            }
        });
    });

    $('#btnCancel').on('click', function() {
        var id = $('#id').val();
        if (!id) return;
        Swal.fire({
            icon: 'warning',
            title: 'Cancel LR?',
            text: 'This will mark LR as cancelled.',
            showCancelButton: true,
            confirmButtonText: 'Yes, Cancel'
        }).then(function(r) {
            if (!r.isConfirmed) return;
            $.post('<%=request.getContextPath()%>/logistics/LR/cancelLR.jsp', { id: id }, function(txt) {
                if ((txt || '').trim() === 'OK') {
                    Swal.fire({ icon: 'success', title: 'Cancelled', text: 'LR cancelled successfully' });
                    $('#btnSave').prop('disabled', true);
                    setSaveState('Cancelled LR');
                } else {
                    Swal.fire({ icon: 'error', title: 'Error', text: txt || 'Cancel failed' });
                }
            });
        });
    });

    $('#btnReset').on('click', function() {
        resetForm();
        enableSave();
    });

    enableSave();
})();
</script>
</body>
</html>
