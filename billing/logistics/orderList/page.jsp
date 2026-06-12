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

// Build supplier & customer JSON for autocomplete in edit rows
StringBuilder supplierJson = new StringBuilder("[");
try {
    Vector suppliers = bill.getLogisticsSupplierList();
    for (int i = 0; i < suppliers.size(); i++) {
        if (i > 0) supplierJson.append(",");
        Vector srow = (Vector) suppliers.get(i);
        String sname = srow.get(1).toString().replace("\\","\\\\").replace("\"","\\\"");
        supplierJson.append("{\"id\":").append(srow.get(0)).append(",\"label\":\"").append(sname).append("\"}");
    }
} catch (Exception ex) {}
supplierJson.append("]");

StringBuilder customerJson = new StringBuilder("[");
try {
    Vector customers = bill.getLogisticsCustomerList();
    for (int i = 0; i < customers.size(); i++) {
        if (i > 0) customerJson.append(",");
        Vector crow = (Vector) customers.get(i);
        String cname = crow.get(1).toString().replace("\\","\\\\").replace("\"","\\\"");
        customerJson.append("{\"id\":").append(crow.get(0)).append(",\"label\":\"").append(cname).append("\"}");
    }
} catch (Exception ex) {}
customerJson.append("]");

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
        .filter-card .form-control, .filter-card .form-select { font-size: 13px; }
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
                        <th>Supplier</th>
                        <th>Date</th>
                        <th>LR No</th>
                        <th>Customer</th>
                        <th>Destination</th>
                        <th class="tbl-amt">DPF</th>
                        <th class="tbl-amt">LH</th>
                        <th class="tbl-amt">LOAD</th>
                        <th class="tbl-amt">U/L</th>
                        <th class="tbl-amt">LC</th>
                        <th class="tbl-amt">HOTING</th>
                        <th class="tbl-amt">Costing</th>
                        <th class="tbl-amt">Profit</th>
                        <th>Status</th>
                        <th>Action</th>
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
        String lrNo       = row.get(4).toString().replace("'","\\'");
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
                        <td><%=row.get(2).toString()%></td>
                        <td><%=lrDateDisplay%></td>
                        <td><%=row.get(4).toString()%></td>
                        <td><%=row.get(6).toString()%></td>
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
                            <a href="<%=contextPath%>/logistics/transportBill/print.jsp?billId=<%=tbBillId%>" target="_blank"
                               class="btn btn-sm btn-success">
                                <i class="fas fa-print"></i> Print
                            </a>
<%              } %><%  } %>
                        </td>
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
            <input type="text" id="m_lrNo" class="form-control fg-inp" maxlength="100" placeholder="LR Number">
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
        <button type="button" class="bb bb-outline" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>Cancel
        </button>
        <button type="button" class="bb bb-primary" onclick="saveEdit()">
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
var supplierData = <%=supplierJson%>;
var customerData = <%=customerJson%>;
var contextPath  = '<%=contextPath%>';

$(function() {
    <% if (msg != null) { %>
    Swal.fire({
        icon: '<%= "danger".equals(type) ? "error" : ("warning".equals(type) ? "warning" : "success") %>',
        title: '<%= "danger".equals(type) ? "Error" : ("warning".equals(type) ? "Warning" : "Success") %>',
        text: '<%=msg.replace("'", "\\'")%>',
        confirmButtonText: 'OK'
    });
    history.replaceState(null, '', window.location.pathname + '?fromDate=<%=fromDate%>&toDate=<%=toDate%>');
    <% } %>

    // Supplier autocomplete in modal
    $('#m_supplierName').autocomplete({
        source: supplierData,
        minLength: 0,
        select: function(event, ui) {
            $('#m_supplierId').val(ui.item.id);
            $(this).val(ui.item.label);
            $('#m_supplierError').hide();
            return false;
        }
    }).on('focus', function() {
        if (!$(this).val()) $(this).autocomplete('search', '');
    }).on('input', function() {
        $('#m_supplierId').val('');
    });

    // Customer autocomplete in modal
    $('#m_customerName').autocomplete({
        source: customerData,
        minLength: 0,
        select: function(event, ui) {
            $('#m_customerId').val(ui.item.id);
            $(this).val(ui.item.label);
            $('#m_customerError').hide();
            return false;
        }
    }).on('focus', function() {
        if (!$(this).val()) $(this).autocomplete('search', '');
    }).on('input', function() {
        $('#m_customerId').val('');
    });

    // Amount recalc
    $('.m-amt').on('input', calcModalProfit).on('focus', function() { this.select(); });
});

function showEdit(id, suppId, suppName, lrDate, lrNo, custId, custName, dest, dpf, lh, load, ul, lc, hoting) {
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
</script>
</body>
</html>
