<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page errorPage="" %>
<jsp:useBean id="bill" class="billing.billingBean" />

<%
// Session check
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}

// Date range – default to current month
String today     = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String firstOfMonth = today.substring(0, 8) + "01";

String fromDate = request.getParameter("fromDate");
String toDate   = request.getParameter("toDate");
if (fromDate == null || fromDate.trim().isEmpty()) fromDate = firstOfMonth;
if (toDate   == null || toDate.trim().isEmpty())   toDate   = today;

// Load orders
Vector orders = new Vector();
try {
    orders = bill.getLogisticsOrderList(fromDate, toDate);
} catch (Exception ex) { ex.printStackTrace(); }

String msg  = request.getParameter("msg");
String type = request.getParameter("type");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LR Order List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        .view-row td { vertical-align: middle; }
        .profit-pos { color: #198754; font-weight: 600; }
        .profit-neg { color: #dc3545; font-weight: 600; }
        .badge-unbilled { background: #fff3cd; color: #856404; border: 1px solid #ffc107; }
        .badge-billed   { background: #d1e7dd; color: #0a3622; border: 1px solid #a3cfbb; }
        .tbl-amt { text-align: right; min-width: 64px; }
        .col-customer { width: 130px; min-width: 130px; max-width: 130px; }
        .lrno-cell {
            white-space: pre-line;
            line-height: 1.2;
        }
        .customer-cell {
            display: inline-block;
            width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            vertical-align: middle;
        }
        .filter-card .form-control, .filter-card .form-select { font-size: 13px; }
        .ui-autocomplete { z-index: 99999 !important; }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>

<%
    request.setAttribute("pageTitle",    "LR Order List");
    request.setAttribute("pageSubtitle", "View and edit logistics orders");
    request.setAttribute("pageIcon",     "fa-solid fa-list");
%>
<jsp:include page="/assets/common/pageHeader.jsp" />

<div class="container-fluid mt-3 mst-page">

    <!-- Date filter card -->
    <div class="card mst-card mb-3">
        <div class="card-body py-2 px-3">
            <form method="get" action="<%=contextPath%>/logistics/orderList/page.jsp" class="row g-2 align-items-end">
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
                </div>
            </form>
        </div>
    </div>

    <!-- Filter bar -->
    <div class="card mst-card mb-3 filter-card">
        <div class="card-body py-2 px-3">
            <div class="row g-2 align-items-end">
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">Customer</label>
                    <input type="text" id="fltCustomer" class="form-control fg-inp" placeholder="Search customer..." style="min-width:150px;">
                </div>
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">Supplier</label>
                    <input type="text" id="fltSupplier" class="form-control fg-inp" placeholder="Search supplier..." style="min-width:150px;">
                </div>
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">Destination</label>
                    <input type="text" id="fltDest" class="form-control fg-inp" placeholder="Search destination..." style="min-width:140px;">
                </div>
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">LR No</label>
                    <input type="text" id="fltLrNo" class="form-control fg-inp" placeholder="Search LR no..." style="min-width:120px;">
                </div>
                <div class="col-auto">
                    <label class="form-label fw-semibold mb-1">Status</label>
                    <select id="fltStatus" class="form-select fg-inp" style="min-width:120px;">
                        <option value="">All</option>
                        <option value="unbilled">Unbilled</option>
                        <option value="billed">Billed</option>
                    </select>
                </div>
                <div class="col-auto">
                    <button type="button" class="bb bb-secondary" onclick="clearFilters()">
                        <i class="fa-solid fa-xmark me-1"></i>Clear
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Orders table card -->
    <div class="card mst-card">
        <div class="mst-card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fa-solid fa-list me-2"></i>Orders
                <span class="badge bg-secondary ms-2"><%=orders.size()%></span>
            </h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
            <table class="table table-bordered table-hover mb-0" id="orderTable">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Date</th>
                        <th class="col-customer">Customer</th>
                        <th>LR No</th>
                        <th>Destination</th>
                        <th class="tbl-amt">DPF</th>
                        <th class="tbl-amt">LH</th>
                        <th class="tbl-amt">LOAD</th>
                        <th class="tbl-amt">U/L</th>
                        <th class="tbl-amt">LC</th>
                        <th class="tbl-amt">HALTING</th>
                        <th class="tbl-amt">Costing</th>
                        <th class="tbl-amt">Profit</th>
                        <th>Status</th>
                        <th>Action</th>
                        <th>Supplier</th>
                    </tr>
                </thead>
                <tbody>
<%
if (orders.isEmpty()) {
%>
                    <tr><td colspan="16" class="text-center text-muted py-4">No orders found for the selected date range.</td></tr>
<%
} else {
    int sno = 1;
    for (int i = 0; i < orders.size(); i++) {
        Vector row   = (Vector) orders.get(i);
        String id         = row.get(0).toString();
        String suppId     = row.get(1).toString();
        String suppName   = row.get(2).toString().replace("'","\\'");
        String lrDate     = row.get(3).toString();
        String lrNo       = row.get(4).toString().replace("'","\\'").replace("\r", "").replace("\n", "\\n");
        String custId     = row.get(5).toString();
        String custName   = row.get(6).toString().replace("'","\\'");
        String dest       = row.get(7).toString().replace("'","\\'");
        double dpf        = Double.parseDouble(row.get(8).toString());
        double lh         = Double.parseDouble(row.get(9).toString());
        double load       = Double.parseDouble(row.get(10).toString());
        double ul         = Double.parseDouble(row.get(11).toString());
        double hoting     = Double.parseDouble(row.get(12).toString());
        double lc         = Double.parseDouble(row.get(13).toString());
        int    isBilled   = Integer.parseInt(row.get(14).toString());
        String vehicleNo  = row.get(15).toString();
        String driverPh   = row.get(16).toString();
        double profit     = dpf - (lh + load + ul + lc + hoting);
        double costing    = lh + load + ul + lc + hoting;
        String profitCls  = profit >= 0 ? "profit-pos" : "profit-neg";
        String profitStr  = String.format("%.2f", profit);
        String costingStr = String.format("%.2f", costing);
        String dpfStr     = String.format("%.2f", dpf);
        String lhStr      = String.format("%.2f", lh);
        String loadStr    = String.format("%.2f", load);
        String ulStr      = String.format("%.2f", ul);
        String lcStr      = String.format("%.2f", lc);
        String hotingStr  = String.format("%.2f", hoting);
        String badgeCls   = isBilled == 0 ? "badge-unbilled" : "badge-billed";
        String badgeTxt   = isBilled == 0 ? "Unbilled" : "Billed";
        String lrDateDisplay = lrDate;
        try {
            java.text.SimpleDateFormat inFmt  = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.text.SimpleDateFormat outFmt = new java.text.SimpleDateFormat("dd-MM-yyyy");
            lrDateDisplay = outFmt.format(inFmt.parse(lrDate));
        } catch (Exception _e) {}%>
                    <!-- VIEW ROW -->
                    <tr class="view-row" id="view-<%=id%>"
                        data-customer="<%=row.get(6).toString().toLowerCase()%>"
                        data-supplier="<%=row.get(2).toString().toLowerCase()%>"
                        data-dest="<%=row.get(7).toString().toLowerCase()%>"
                        data-lrno="<%=row.get(4).toString().toLowerCase()%>"
                        data-status="<%=badgeTxt.toLowerCase()%>">
                        <td><%=sno%></td>
                        <td><%=lrDateDisplay%></td>
                        <td class="col-customer"><span class="customer-cell" title="<%=row.get(6).toString()%>"><%=row.get(6).toString()%></span></td>
                        <td class="lrno-cell"><%=row.get(4).toString()%></td>
                        <td><%=row.get(7).toString()%></td>
                        <td class="tbl-amt"><%=dpfStr%></td>
                        <td class="tbl-amt"><%=lhStr%></td>
                        <td class="tbl-amt"><%=loadStr%></td>
                        <td class="tbl-amt"><%=ulStr%></td>
                        <td class="tbl-amt"><%=lcStr%></td>
                        <td class="tbl-amt"><%=hotingStr%></td>
                        <td class="tbl-amt"><%=costingStr%></td>
                        <td class="tbl-amt <%=profitCls%>"><%=profitStr%></td>
                        <td><span class="badge <%=badgeCls%>"><%=badgeTxt%></span></td>
                        <td>
<%  if (isBilled == 0) { %>
                            <button class="btn btn-sm btn-warning"
                                onclick="showEdit('<%=id%>','<%=suppId%>','<%=suppName%>','<%=lrDate%>','<%=lrNo%>','<%=custId%>','<%=custName%>','<%=dest%>','<%=dpfStr%>','<%=lhStr%>','<%=loadStr%>','<%=ulStr%>','<%=lcStr%>','<%=hotingStr%>')">
                                <i class="fas fa-pen"></i> Edit
                            </button><%  } else { %>
<%
                int tbBillId = 0;
                try { tbBillId = bill.getTransportBillIdByLrId(Integer.parseInt(id.toString())); } catch (Exception _ex) {}
                if (tbBillId > 0) { %>
                            <button class="btn btn-sm btn-info text-white"
                                onclick="showBillModal('<%=id%>', this.closest('tr').querySelector('.lrno-cell').innerText, <%=tbBillId%>)">
                                <i class="fas fa-file-invoice"></i> View Bill
                            </button>
<%              } %><%  } %>
                        </td>
<%
        // Build tooltip for vehicle/driver info
        StringBuilder suppTip = new StringBuilder();
        if (!vehicleNo.isEmpty()) suppTip.append("Vehicle: ").append(vehicleNo.replace("'","&#39;"));
        if (!driverPh.isEmpty()) { if (suppTip.length() > 0) suppTip.append(" | "); suppTip.append("Driver: ").append(driverPh.replace("'","&#39;")); }
        String suppTipStr = suppTip.toString();
%>
<%  if (!suppTipStr.isEmpty()) { %>
                        <td data-bs-toggle="tooltip" data-bs-placement="left"
                            title="<%=suppTipStr%>" style="cursor:help;"><%=row.get(2).toString()%></td>
<%  } else { %>
                        <td><%=row.get(2).toString()%></td>
<%  } %>
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

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editModalLabel"><i class="fas fa-pen me-2"></i>Edit LR Order</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" id="m_id">
        <div class="row mb-3">
          <div class="col-md-6">
            <label class="form-label fw-semibold">Supplier Name</label>
            <input type="hidden" id="m_supplierId">
            <input type="text" id="m_supplierName" class="form-control fg-inp" autocomplete="off" placeholder="Type supplier name...">
            <div id="m_supplierError" class="text-danger small mt-1" style="display:none;">Please select a valid supplier.</div>
          </div>
          <div class="col-md-6">
            <label class="form-label fw-semibold">Date</label>
            <input type="date" id="m_lrDate" class="form-control fg-inp">
          </div>
        </div>
        <div class="row mb-3">
          <div class="col-md-6">
            <label class="form-label fw-semibold">LR No</label>
                        <input type="text" id="m_lrNo" class="form-control fg-inp" placeholder="LR Number">
          </div>
          <div class="col-md-6">
            <label class="form-label fw-semibold">Customer Name</label>
            <input type="hidden" id="m_customerId">
            <input type="text" id="m_customerName" class="form-control fg-inp" autocomplete="off" placeholder="Type customer name...">
            <div id="m_customerError" class="text-danger small mt-1" style="display:none;">Please select a valid customer.</div>
          </div>
        </div>
        <div class="mb-3">
          <label class="form-label fw-semibold">Destination</label>
          <input type="text" id="m_destination" class="form-control fg-inp" maxlength="255" placeholder="Destination">
        </div>
        <div class="card p-3 bg-light border">
          <h6 class="fw-bold mb-3"><i class="fa-solid fa-indian-rupee-sign me-1"></i>Amount Details</h6>
          <div class="row g-3">
            <div class="col-6 col-md-4">
              <label class="form-label fw-semibold">DPF</label>
              <input type="number" step="0.01" min="0" id="m_dpf" class="form-control fg-inp m-amt" placeholder="0.00">
            </div>
            <div class="col-6 col-md-4">
              <label class="form-label fw-semibold">LH</label>
              <input type="number" step="0.01" min="0" id="m_lh" class="form-control fg-inp m-amt" placeholder="0.00">
            </div>
            <div class="col-6 col-md-4">
              <label class="form-label fw-semibold">LOAD</label>
              <input type="number" step="0.01" min="0" id="m_loadAmt" class="form-control fg-inp m-amt" placeholder="0.00">
            </div>
            <div class="col-6 col-md-4">
              <label class="form-label fw-semibold">U/L</label>
              <input type="number" step="0.01" min="0" id="m_ul" class="form-control fg-inp m-amt" placeholder="0.00">
            </div>
            <div class="col-6 col-md-4">
              <label class="form-label fw-semibold">LC</label>
              <input type="number" step="0.01" min="0" id="m_lc" class="form-control fg-inp m-amt" placeholder="0.00">
            </div>
            <div class="col-6 col-md-4">
              <label class="form-label fw-semibold">HOTING</label>
              <input type="number" step="0.01" min="0" id="m_hoting" class="form-control fg-inp m-amt" placeholder="0.00">
            </div>
            <div class="col-6 col-md-4 d-flex align-items-end">
              <div class="w-100">
                <label class="form-label fw-semibold" id="m_profitLabel">Profit</label>
                <input type="text" id="m_profit" class="form-control fg-inp fw-bold" readonly placeholder="0.00">
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger me-auto" id="btnCancelOrder" onclick="cancelOrderFromModal()">
          <i class="fas fa-ban me-1"></i>Cancel Order
        </button>
        <button type="button" class="bb bb-outline" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>Close
        </button>
        <button type="button" class="bb bb-primary" onclick="saveEdit()">
          <i class="fas fa-save me-1"></i>Save Changes
        </button>
      </div>
    </div>
  </div>
</div>

<!-- Bill View/Edit Modal -->
<div class="modal fade" id="billModal" tabindex="-1" aria-labelledby="billModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="billModalLabel"><i class="fas fa-file-invoice me-2"></i>Transport Bill — LR <span id="bm_lrNo"></span></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body" id="billModalBody">
        <div class="text-center py-4"><i class="fas fa-spinner fa-spin fa-2x"></i></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger me-auto" id="bmBtnCancelBill" onclick="cancelBillFromModal()">
          <i class="fas fa-ban me-1"></i>Cancel Bill
        </button>
        <a id="bmBtnPrint" href="#" target="_blank" class="bb bb-secondary">
          <i class="fas fa-print me-1"></i>Print
        </a>
        <button type="button" class="bb bb-outline" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>Close
        </button>
        <button type="button" class="bb bb-primary" onclick="saveBillEdit()">
          <i class="fas fa-save me-1"></i>Save Changes
        </button>
      </div>
    </div>
  </div>
</div>

<script>
// Auto-collapse sidebar when this page loads
document.addEventListener('DOMContentLoaded', function() {
    var sidebar = document.getElementById('sidebar');
    if (sidebar && !sidebar.classList.contains('hidden')) {
        sidebar.classList.add('hidden');
        document.body.classList.add('sidebar-hidden');
    }
});
</script>

<script>
var contextPath  = '<%=contextPath%>';

$(function() {
    // Init Bootstrap tooltips
    document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function(el) {
        new bootstrap.Tooltip(el);
    });

    <% if (msg != null) { %>
    Swal.fire({
        icon: '<%= "danger".equals(type) ? "error" : ("warning".equals(type) ? "warning" : "success") %>',
        title: '<%= "danger".equals(type) ? "Error" : ("warning".equals(type) ? "Warning" : "Success") %>',
        text: '<%=msg.replace("'", "\\'")%>',
        confirmButtonText: 'OK'
    });
    history.replaceState(null, '', window.location.pathname + '?fromDate=<%=fromDate%>&toDate=<%=toDate%>');
    <% } %>

    // Supplier autocomplete in modal (AJAX)
    $('#m_supplierName').autocomplete({
        source: function(request, response) {
            $.getJSON(contextPath + '/logistics/order/getSuppliers.jsp', { term: request.term }, response);
        },
        minLength: 1,
        select: function(event, ui) {
            $('#m_supplierId').val(ui.item.id);
            $(this).val(ui.item.label);
            $('#m_supplierError').hide();
            return false;
        }
    }).on('input', function() {
        $('#m_supplierId').val('');
    });

    // Customer autocomplete in modal (AJAX)
    $('#m_customerName').autocomplete({
        source: function(request, response) {
            $.getJSON(contextPath + '/logistics/order/getCustomers.jsp', { term: request.term }, response);
        },
        minLength: 1,
        select: function(event, ui) {
            $('#m_customerId').val(ui.item.id);
            $(this).val(ui.item.label);
            $('#m_customerError').hide();
            return false;
        }
    }).on('input', function() {
        $('#m_customerId').val('');
    });

    // Amount recalc
    $('.m-amt').on('input', calcModalProfit).on('focus', function() { this.select(); });

    // Re-attach autocomplete when modal opens (ensures proper context)
    $('#editModal').on('shown.bs.modal', function() {
        if (!$('#m_supplierName').data('ui-autocomplete')) {
            $('#m_supplierName').autocomplete({
                source: function(request, response) {
                    $.getJSON(contextPath + '/logistics/order/getSuppliers.jsp', { term: request.term }, response);
                },
                minLength: 1,
                select: function(event, ui) {
                    $('#m_supplierId').val(ui.item.id);
                    $(this).val(ui.item.label);
                    $('#m_supplierError').hide();
                    return false;
                }
            }).on('input', function() { $('#m_supplierId').val(''); });
        }
        if (!$('#m_customerName').data('ui-autocomplete')) {
            $('#m_customerName').autocomplete({
                source: function(request, response) {
                    $.getJSON(contextPath + '/logistics/order/getCustomers.jsp', { term: request.term }, response);
                },
                minLength: 1,
                select: function(event, ui) {
                    $('#m_customerId').val(ui.item.id);
                    $(this).val(ui.item.label);
                    $('#m_customerError').hide();
                    return false;
                }
            }).on('input', function() { $('#m_customerId').val(''); });
        }
    });
});

function showEdit(id, suppId, suppName, lrDate, lrNo, custId, custName, dest, dpf, lh, load, ul, lc, hoting) {
    $('#btnCancelOrder').data('id', id).data('lrno', lrNo);
    $('#m_id').val(id);
    $('#m_supplierId').val(suppId);
    $('#m_supplierName').val(suppName);
    $('#m_lrDate').val(lrDate);
    $('#m_lrNo').val(lrNo);
    $('#m_customerId').val(custId);
    $('#m_customerName').val(custName);
    $('#m_destination').val(dest);
    $('#m_dpf').val(dpf);
    $('#m_lh').val(lh);
    $('#m_loadAmt').val(load);
    $('#m_ul').val(ul);
    $('#m_lc').val(lc);
    $('#m_hoting').val(hoting);
    $('#m_supplierError, #m_customerError').hide();
    calcModalProfit();
    var modal = new bootstrap.Modal(document.getElementById('editModal'));
    modal.show();
}

function calcModalProfit() {
    var dpf    = parseFloat($('#m_dpf').val())    || 0;
    var lh     = parseFloat($('#m_lh').val())     || 0;
    var load   = parseFloat($('#m_loadAmt').val())|| 0;
    var ul     = parseFloat($('#m_ul').val())     || 0;
    var lc     = parseFloat($('#m_lc').val())     || 0;
    var hoting = parseFloat($('#m_hoting').val()) || 0;
    var profit = dpf - (lh + load + ul + lc + hoting);
    $('#m_profit').val(profit.toFixed(2));
    var color = profit > 0 ? '#198754' : (profit < 0 ? '#dc3545' : '');
    $('#m_profit, #m_profitLabel').css('color', color);
}

function saveEdit() {
    var id          = $('#m_id').val();
    var supplierId  = $('#m_supplierId').val();
    var lrDate      = $('#m_lrDate').val();
    var lrNo        = $('#m_lrNo').val().trim();
    var customerId  = $('#m_customerId').val();
    var destination = $('#m_destination').val().trim();

    if (!supplierId) {
        $('#m_supplierError').show();
        $('#m_supplierName').focus(); return;
    }
    if (!lrDate) {
        Swal.fire({ icon: 'warning', title: 'Validation', text: 'Please select a date.' }); return;
    }
    if (!lrNo) {
        Swal.fire({ icon: 'warning', title: 'Validation', text: 'Please enter LR No.' });
        $('#m_lrNo').focus(); return;
    }
    if (!customerId) {
        $('#m_customerError').show();
        $('#m_customerName').focus(); return;
    }
    if (!destination) {
        Swal.fire({ icon: 'warning', title: 'Validation', text: 'Please enter destination.' });
        $('#m_destination').focus(); return;
    }

    $.post(contextPath + '/logistics/orderList/updateOrder.jsp', {
        id:          id,
        supplierId:  supplierId,
        lrDate:      lrDate,
        lrNo:        lrNo,
        customerId:  customerId,
        destination: destination,
        dpf:         $('#m_dpf').val()    || 0,
        lh:          $('#m_lh').val()     || 0,
        loadAmt:     $('#m_loadAmt').val()|| 0,
        ul:          $('#m_ul').val()     || 0,
        lc:          $('#m_lc').val()     || 0,
        hoting:      $('#m_hoting').val() || 0
    }, function(res) {
        res = $.trim(res);
        if (res === 'OK') {
            bootstrap.Modal.getInstance(document.getElementById('editModal')).hide();
            Swal.fire({ icon: 'success', title: 'Updated', text: 'Order updated successfully!', timer: 1500, showConfirmButton: false })
                .then(function() { location.reload(); });
        } else {
            Swal.fire({ icon: 'error', title: 'Error', text: res || 'Failed to update order.' });
        }
    }).fail(function() {
        Swal.fire({ icon: 'error', title: 'Error', text: 'Server error. Please try again.' });
    });
}

// ── Live table filters ──────────────────────────────────────────
function applyFilters() {
    const customer = $('#fltCustomer').val().trim().toLowerCase();
    const supplier = $('#fltSupplier').val().trim().toLowerCase();
    const dest     = $('#fltDest').val().trim().toLowerCase();
    const lrno     = $('#fltLrNo').val().trim().toLowerCase();
    const status   = $('#fltStatus').val().toLowerCase();

    $('#orderTable tbody tr.view-row').each(function() {
        const r = $(this);
        const match =
            (!customer || r.data('customer').includes(customer)) &&
            (!supplier || r.data('supplier').includes(supplier)) &&
            (!dest     || r.data('dest').includes(dest))         &&
            (!lrno     || r.data('lrno').includes(lrno))         &&
            (!status   || r.data('status') === status);
        r.toggle(match);
    });
}
function clearFilters() {
    $('#fltCustomer, #fltSupplier, #fltDest, #fltLrNo').val('');
    $('#fltStatus').val('');
    applyFilters();
}
$(function() {
    $('#fltCustomer, #fltSupplier, #fltDest, #fltLrNo').on('input', applyFilters);
    $('#fltStatus').on('change', applyFilters);
});

function cancelOrderFromModal() {
    var id   = $('#btnCancelOrder').data('id');
    var lrNo = $('#btnCancelOrder').data('lrno');
    bootstrap.Modal.getInstance(document.getElementById('editModal')).hide();
    cancelOrder(id, lrNo);
}

// ── Bill modal ──────────────────────────────────────────────────
var _bm_billId = 0;
var _bm_lrId   = 0;

function showBillModal(lrId, lrNo, billId) {
    _bm_billId = billId;
    _bm_lrId   = lrId;
    $('#bm_lrNo').text(lrNo);
    $('#bmBtnCancelBill').data('billid', billId);
    $('#bmBtnPrint').attr('href', contextPath + '/logistics/transportBill/print.jsp?billId=' + billId);
    $('#billModalBody').html('<div class="text-center py-4"><i class="fas fa-spinner fa-spin fa-2x"></i></div>');
    var modal = new bootstrap.Modal(document.getElementById('billModal'));
    modal.show();
    $.getJSON(contextPath + '/logistics/orderList/getLrBillDetails.jsp', { lrId: lrId }, function(data) {
        if (data.error) {
            $('#billModalBody').html('<div class="alert alert-danger">' + data.error + '</div>');
            return;
        }
        var dpf = parseFloat(data.dpf) || 0;
        var html = '';
        html += '<div class="row mb-3">';
        html += '  <div class="col-md-3"><label class="form-label fw-semibold">Invoice No</label>';
        html += '  <input type="text" class="form-control fg-inp" readonly value="' + esc(data.invoiceNo) + '"></div>';
        html += '  <div class="col-md-3"><label class="form-label fw-semibold">LR Date</label>';
        html += '  <input type="date" id="bm_lrDate" class="form-control fg-inp" value="' + esc(data.lrDate) + '"></div>';
        html += '  <div class="col-md-3"><label class="form-label fw-semibold">PO No</label>';
        html += '  <input type="text" id="bm_poNo" class="form-control fg-inp" maxlength="100" value="' + esc(data.poNo) + '"></div>';
        html += '  <div class="col-md-3"><label class="form-label fw-semibold">SAC Code</label>';
        html += '  <input type="text" id="bm_sacCode" class="form-control fg-inp" maxlength="50" value="' + esc(data.sacCode) + '"></div>';
        html += '</div>';
        html += '<div class="mb-3">';
        html += '  <label class="form-label fw-semibold">Notes</label>';
        html += '  <textarea id="bm_notes" class="form-control fg-inp" rows="2" maxlength="500" placeholder="Notes...">' + esc(data.notes) + '</textarea>';
        html += '</div>';
        html += '<div class="d-flex justify-content-between align-items-center mb-2">';
        html += '  <h6 class="fw-bold mb-0"><i class="fa-solid fa-list me-1"></i>Particulars</h6>';
        html += '  <div><span class="me-3 text-muted">DPF Limit: <strong class="text-success">&#8377;' + dpf.toFixed(2) + '</strong></span>';
        html += '  <button type="button" class="btn btn-sm btn-outline-secondary" onclick="bmAddRow()"><i class="fas fa-plus me-1"></i>Add Row</button></div>';
        html += '</div>';
        html += '<div class="table-responsive"><table class="table table-bordered table-sm mb-1" id="bmPartTable">';
        html += '<thead class="table-dark"><tr><th>Particular</th><th style="width:100px">Qty</th><th style="width:130px">Rate/Wt</th><th style="width:120px">Amount (&#8377;)</th><th style="width:40px"></th></tr></thead>';
        html += '<tbody id="bmPartBody">';
        if (data.details && data.details.length > 0) {
            for (var i = 0; i < data.details.length; i++) {
                html += bmRow(data.details[i].particular, data.details[i].qty, data.details[i].rateWt, data.details[i].amount);
            }
        } else {
            html += bmRow('','','',0);
        }
        html += '</tbody>';
        html += '<tfoot><tr><td colspan="3" class="text-end fw-bold">LR Total</td>';
        html += '<td><input type="text" id="bm_lrTotal" class="form-control form-control-sm fw-bold" readonly></td><td></td></tr></tfoot>';
        html += '</table></div>';
        html += '<div id="bm_dpfWarning" class="alert alert-warning py-1 mt-1" style="display:none;"><i class="fas fa-exclamation-triangle me-1"></i>LR Total must equal DPF limit of &#8377;' + dpf.toFixed(2) + '!</div>';
        $('#billModalBody').html(html);
        // Store dpf
        $('#billModalBody').data('dpf', dpf);
        bmCalcTotal();
        $('#bmPartBody').on('input', 'input.bm-amt', bmCalcTotal);
    }).fail(function() {
        $('#billModalBody').html('<div class="alert alert-danger">Failed to load bill details.</div>');
    });
}

function esc(s) {
    if (!s) return '';
    return $('<div>').text(s).html();
}

function bmRow(particular, qty, rateWt, amount) {
    return '<tr>'
        + '<td><input type="text" class="form-control form-control-sm" value="' + esc(particular) + '"></td>'
        + '<td><input type="text" class="form-control form-control-sm" value="' + esc(qty) + '"></td>'
        + '<td><input type="text" class="form-control form-control-sm" value="' + esc(rateWt) + '"></td>'
        + '<td><input type="number" step="0.01" min="0" class="form-control form-control-sm bm-amt" value="' + (parseFloat(amount)||0).toFixed(2) + '"></td>'
        + '<td><button type="button" class="btn btn-sm btn-outline-danger" onclick="$(this).closest(\'tr\').remove();bmCalcTotal();"><i class="fas fa-times"></i></button></td>'
        + '</tr>';
}

function bmAddRow() {
    $('#bmPartBody').append(bmRow('','','',0));
}

function bmCalcTotal() {
    var total = 0;
    $('#bmPartBody input.bm-amt').each(function() { total += parseFloat($(this).val()) || 0; });
    $('#bm_lrTotal').val(total.toFixed(2));
    var dpf = parseFloat($('#billModalBody').data('dpf')) || 0;
    if (dpf > 0 && Math.abs(total - dpf) > 0.001) {
        $('#bm_dpfWarning').show();
        $('#bm_lrTotal').css('color', '#dc3545');
    } else {
        $('#bm_dpfWarning').hide();
        $('#bm_lrTotal').css('color', '#198754');
    }
}

function saveBillEdit() {
    var poNo    = $('#bm_poNo').val().trim();
    var sacCode = $('#bm_sacCode').val().trim();
    var notes   = $('#bm_notes').val().trim();
    var lrDate  = $('#bm_lrDate').val();
    var lrTotal = parseFloat($('#bm_lrTotal').val()) || 0;
    var dpf     = parseFloat($('#billModalBody').data('dpf')) || 0;

    if (!lrDate) {
        Swal.fire({ icon: 'warning', title: 'Validation', text: 'Please select LR Date.' });
        return;
    }
    if (dpf > 0 && Math.abs(lrTotal - dpf) > 0.001) {
        Swal.fire({ icon: 'warning', title: 'Amount Mismatch', text: 'LR Total (\u20b9' + lrTotal.toFixed(2) + ') must equal the DPF amount (\u20b9' + dpf.toFixed(2) + ').' });
        return;
    }

    var parts = [];
    $('#bmPartBody tr').each(function() {
        var inputs = $(this).find('input');
        parts.push({
            particular: $(inputs[0]).val(),
            qty:        $(inputs[1]).val(),
            rateWt:     $(inputs[2]).val(),
            amount:     parseFloat($(inputs[3]).val()) || 0
        });
    });

    $.ajax({
        url: contextPath + '/logistics/orderList/updateBillLr.jsp',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ billId: _bm_billId, lrId: _bm_lrId, poNo: poNo, sacCode: sacCode, notes: notes, lrDate: lrDate, lrTotal: lrTotal, particulars: parts }),
        success: function(res) {
            if (res.ok) {
                bootstrap.Modal.getInstance(document.getElementById('billModal')).hide();
                Swal.fire({ icon: 'success', title: 'Updated', text: 'Bill updated successfully!', timer: 1500, showConfirmButton: false })
                    .then(function() { location.reload(); });
            } else {
                Swal.fire({ icon: 'error', title: 'Error', text: res.msg || 'Update failed.' });
            }
        },
        error: function() { Swal.fire({ icon: 'error', title: 'Error', text: 'Server error.' }); }
    });
}

function cancelBillFromModal() {
    var billId = $('#bmBtnCancelBill').data('billid');
    bootstrap.Modal.getInstance(document.getElementById('billModal')).hide();
    Swal.fire({
        icon: 'warning',
        title: 'Cancel Transport Bill?',
        html: 'This will cancel the bill and mark all its LRs as <strong>Unbilled</strong> again.',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        confirmButtonText: 'Yes, Cancel Bill',
        cancelButtonText: 'No'
    }).then(function(result) {
        if (result.isConfirmed) {
            $.post(contextPath + '/logistics/orderList/cancelBill.jsp', { billId: billId }, function(res) {
                res = $.trim(res);
                if (res === 'OK') {
                    Swal.fire({ icon: 'success', title: 'Cancelled', text: 'Transport bill cancelled!', timer: 1500, showConfirmButton: false })
                        .then(function() { location.reload(); });
                } else {
                    Swal.fire({ icon: 'error', title: 'Error', text: res || 'Failed to cancel bill.' });
                }
            }).fail(function() { Swal.fire({ icon: 'error', title: 'Error', text: 'Server error.' }); });
        } else {
            bootstrap.Modal.getInstance(document.getElementById('billModal')) && bootstrap.Modal.getInstance(document.getElementById('billModal')).show();
        }
    });
}

function cancelOrder(id, lrNo) {
    Swal.fire({
        icon: 'warning',
        title: 'Cancel Order?',
        html: 'Are you sure you want to cancel LR No <strong>' + lrNo + '</strong>?<br>This cannot be undone.',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        confirmButtonText: 'Yes, Cancel Order',
        cancelButtonText: 'No'
    }).then(function(result) {
        if (result.isConfirmed) {
            $.post(contextPath + '/logistics/orderList/cancelOrder.jsp', { id: id }, function(res) {
                res = $.trim(res);
                if (res === 'OK') {
                    Swal.fire({ icon: 'success', title: 'Cancelled', text: 'Order cancelled successfully!', timer: 1500, showConfirmButton: false })
                        .then(function() { location.reload(); });
                } else {
                    Swal.fire({ icon: 'error', title: 'Error', text: res || 'Failed to cancel order.' });
                }
            }).fail(function() {
                Swal.fire({ icon: 'error', title: 'Error', text: 'Server error. Please try again.' });
            });
        }
    });
}
</script>
</body>
</html>
