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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Transportation Bill</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        /* ── Page layout ── */
        .tb-page { padding: 0 16px 40px; }
        /* align-items:stretch (default) lets the right col grow as tall as the left,
           which is required for position:sticky to work inside it. */
        .tb-main-row { align-items: stretch; }

        /*
         * theme.css sets overflow-x:hidden on body which creates a new scroll
         * container and silently breaks position:sticky on all descendants.
         * overflow-x:clip achieves the same visual effect (no horizontal bar)
         * WITHOUT creating a scroll container, so sticky works correctly.
         */
        html, body { overflow-x: clip !important; }

        /* ── Sticky right panel ── */
        .billing-panel-wrap {
            position: sticky;
            top: 16px;
            max-height: calc(100vh - 32px);
            overflow-y: auto;
        }

        /* ── LR Selector Card ── */
        .lr-selector-card { border: 1px solid #dee2e6; border-radius: 12px; background: #fff; }
        .lr-selector-card .card-header-custom {
            background: linear-gradient(135deg, #343a40 0%, #212529 100%);
            color: #fff;
            border-radius: 10px 10px 0 0;
            padding: 11px 16px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
            font-size: 14px;
        }
        .lr-selector-card .card-body { padding: 16px; }

        /* LR dropdown search */
        .lr-search-wrap { position: relative; max-width: 380px; }
        .lr-search-wrap input { padding-right: 40px; }
        .lr-search-wrap .search-icon { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); color: #6c757d; pointer-events: none; }
        .lr-dropdown-list {
            position: absolute; top: 100%; left: 0; right: 0;
            background: #fff; border: 1px solid #ced4da; border-top: none;
            border-radius: 0 0 8px 8px; max-height: 220px; overflow-y: auto;
            z-index: 999; box-shadow: 0 4px 12px rgba(0,0,0,.12); display: none;
        }
        .lr-dropdown-list .lr-item {
            display: flex; align-items: center; justify-content: space-between;
            padding: 8px 14px; cursor: pointer; border-bottom: 1px solid #f0f0f0; transition: background .15s;
        }
        .lr-dropdown-list .lr-item:last-child { border-bottom: none; }
        .lr-dropdown-list .lr-item:hover { background: #f1f3f5; }
        .lr-dropdown-list .lr-item .lr-no-text { font-weight: 600; color: #212529; font-size: 14px; }
        .lr-dropdown-list .lr-item .lr-meta { font-size: 12px; color: #6c757d; }
        .lr-dropdown-list .lr-item .lr-dpf-badge {
            background: #198754; color: #fff; border-radius: 20px;
            padding: 2px 10px; font-size: 12px; font-weight: 600; white-space: nowrap;
        }
        .lr-dropdown-list .no-result { padding: 12px 14px; color: #6c757d; font-size: 13px; text-align: center; }

        /* ── Selected LR Chips ── */
        .selected-lr-chips { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 8px; min-height: 32px; }
        .lr-chip {
            display: inline-flex; align-items: center; gap: 6px;
            background: #495057; color: #fff; border-radius: 20px;
            padding: 4px 10px 4px 12px; font-size: 12.5px; font-weight: 500;
        }
        .lr-chip .chip-remove {
            background: rgba(255,255,255,.3); border: none; border-radius: 50%;
            width: 18px; height: 18px; display: flex; align-items: center; justify-content: center;
            font-size: 10px; cursor: pointer; color: #fff; padding: 0; line-height: 1; transition: background .15s;
        }
        .lr-chip .chip-remove:hover { background: rgba(255,255,255,.55); }

        /* ── LEFT: LR Info Block ── */
        .lr-info-block {
            border: 1px solid #dee2e6; border-radius: 10px; overflow: hidden;
            margin-bottom: 14px; background: #fff; box-shadow: 0 1px 4px rgba(0,0,0,.05);
        }
        .lr-info-header {
            background: linear-gradient(90deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 9px 14px; display: flex; align-items: center;
            justify-content: space-between; border-bottom: 1px solid #dee2e6;
        }
        .lr-no-badge {
            background: #343a40; color: #fff; border-radius: 6px;
            padding: 3px 12px; font-weight: 700; font-size: 13px;
            display: inline-flex; align-items: center; gap: 6px;
        }
        .lr-detail-grid {
            display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 0;
        }
        .lr-detail-item {
            padding: 12px 16px; border-right: 1px solid #f0f0f0; border-bottom: 1px solid #f0f0f0;
        }
        .lr-detail-item:nth-child(3n) { border-right: none; }
        .lr-detail-item:nth-last-child(-n+3) { border-bottom: none; }
        .lr-detail-label { font-size: 10.5px; color: #6c757d; text-transform: uppercase; letter-spacing: .5px; margin-bottom: 3px; }
        .lr-detail-val   { font-size: 13.5px; font-weight: 600; color: #212529; }
        .lr-detail-item.dpf-item .lr-detail-val { color: #198754; font-size: 15px; }

        /* DPF progress bar (left block) */
        .dpf-bar-section { padding: 10px 16px 14px; background: #fafafa; border-top: 1px solid #f0f0f0; }
        .dpf-bar-labels { font-size: 11.5px; color: #6c757d; display: flex; justify-content: space-between; margin-bottom: 5px; }
        .dpf-bar-labels .lbl-used   { font-weight: 600; color: #495057; }
        .dpf-bar-labels .lbl-remain { font-weight: 600; color: #198754; }
        .dpf-bar-labels .lbl-remain.over { color: #dc3545; }
        .progress.dpf-bar { height: 8px; border-radius: 10px; background: #e9ecef; }
        .progress.dpf-bar .progress-bar { border-radius: 10px; transition: width .3s ease; }
        .over-limit-alert {
            display: none; font-size: 12px; color: #dc3545;
            font-weight: 500; align-items: center; gap: 4px; margin-top: 5px;
        }
        .over-limit-alert.visible { display: flex; }
        .under-limit-alert {
            display: none; font-size: 12px; color: #fd7e14;
            font-weight: 500; align-items: center; gap: 4px; margin-top: 5px;
        }
        .under-limit-alert.visible { display: flex; }

        /* Left empty state */
        .lr-empty-state {
            text-align: center; padding: 50px 20px; color: #6c757d;
            border: 2px dashed #dee2e6; border-radius: 10px; background: #fafafa;
        }
        .lr-empty-state .empty-icon { font-size: 44px; color: #ced4da; margin-bottom: 12px; }
        .lr-empty-state p { font-size: 13px; margin: 0; }

        /* ── Particulars table (inside LR block on left) ── */
        .part-pane { padding: 10px 16px 4px; }
        .part-table { width: 100%; border-collapse: collapse; font-size: 12.5px; }
        .part-table thead th {
            background: #495057; color: #fff; padding: 7px 6px;
            font-weight: 600; font-size: 11.5px; white-space: nowrap;
        }
        .part-table thead th:first-child { border-radius: 6px 0 0 0; }
        .part-table thead th:last-child  { border-radius: 0 6px 0 0; }
        .part-table tbody td { padding: 4px 4px; vertical-align: middle; border-bottom: 1px solid #f0f0f0; }
        .part-table tbody tr:last-child td { border-bottom: none; }
        .part-table tbody tr:hover { background: #f8f9fa; }

        .tbl-inp {
            border: 1px solid #ced4da; border-radius: 5px; padding: 4px 6px;
            width: 100%; font-size: 12px; background: #fff; outline: none;
            transition: border-color .15s, box-shadow .15s;
        }
        .tbl-inp:focus { border-color: #adb5bd; box-shadow: 0 0 0 2px rgba(73,80,87,.12); }
        .tbl-inp.inp-particular { min-width: 80px; }
        .tbl-inp.inp-sm  { max-width: 64px; }
        .tbl-inp.inp-amount { max-width: 70px; text-align: right; font-weight: 600; color: #198754; }
        .tbl-inp.inp-amount.over-limit { color: #dc3545; border-color: #dc3545; }

        .btn-remove-row {
            background: #fff0f0; border: 1px solid #f5c2c7; color: #dc3545;
            border-radius: 5px; width: 24px; height: 24px;
            display: inline-flex; align-items: center; justify-content: center;
            cursor: pointer; font-size: 11px; transition: background .15s;
        }
        .btn-remove-row:hover { background: #f8d7da; }

        .btn-add-row {
            display: inline-flex; align-items: center; gap: 5px;
            background: #f1f3f5; border: 1px dashed #868e96; color: #343a40;
            border-radius: 6px; padding: 4px 12px; font-size: 12px; font-weight: 500;
            cursor: pointer; margin: 6px 0 0 10px; transition: background .15s;
        }
        .btn-add-row:hover { background: #e9ecef; border-color: #495057; }

        /* LR Notes */
        .lr-notes-wrap { padding: 10px 16px 14px; border-top: 1px solid #f0f0f0; }
        .lr-notes-label { font-size: 12px; font-weight: 600; color: #495057; margin-bottom: 5px; display: flex; align-items: center; gap: 5px; }
        .lr-notes-inp {
            width: 100%; border: 1.5px solid #dee2e6; border-radius: 7px;
            padding: 7px 10px; font-size: 13px; color: #212529; resize: vertical;
            min-height: 58px; outline: none; background: #fafafa;
            transition: border-color .15s, box-shadow .15s;
            font-family: inherit;
        }
        .lr-notes-inp:focus { border-color: #adb5bd; box-shadow: 0 0 0 3px rgba(73,80,87,.1); background: #fff; }
        .lr-notes-inp::placeholder { color: #adb5bd; font-style: italic; }

        /* LR subtotal strip */
        .lr-subtotal-strip {
            background: #f8f9fa; border-top: 1px solid #dee2e6; padding: 7px 16px;
            display: flex; align-items: center; justify-content: space-between; font-size: 12.5px;
        }
        .lr-subtotal-strip .sub-label { color: #6c757d; }
        .lr-subtotal-strip .sub-limit  { font-size: 11px; color: #adb5bd; }
        .lr-subtotal-strip .sub-val {
            font-weight: 700; color: #198754;
            background: #d1e7dd; border-radius: 6px; padding: 2px 10px;
        }
        .lr-subtotal-strip .sub-val.over   { color: #dc3545; background: #f8d7da; }
        .lr-subtotal-strip .sub-val.under  { color: #fd7e14; background: #fff3cd; }

        /* ── RIGHT: Payment Panel ── */
        .pay-panel {
            border: 1px solid #dee2e6; border-radius: 12px; overflow: hidden;
            background: #fff; box-shadow: 0 2px 8px rgba(0,0,0,.07);
        }
        .pay-panel-header {
            background: linear-gradient(135deg, #343a40 0%, #212529 100%);
            color: #fff; padding: 11px 16px; font-weight: 600; font-size: 14px;
            display: flex; align-items: center; gap: 8px;
        }
        .pay-empty-state { text-align: center; padding: 40px 16px; color: #6c757d; }
        .pay-empty-state .empty-icon { font-size: 36px; color: #dee2e6; margin-bottom: 10px; }
        .pay-empty-state p { font-size: 12.5px; margin: 0; }

        /* Total amount display */
        .pay-total-box {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-bottom: 1px solid #dee2e6; padding: 14px 16px;
            display: flex; align-items: center; justify-content: space-between;
        }
        .pay-total-box .pt-label { font-size: 12px; color: #6c757d; font-weight: 500; }
        .pay-total-box .pt-meta  { font-size: 10.5px; color: #adb5bd; margin-top: 1px; }
        .pay-total-box .pt-amount {
            font-size: 22px; font-weight: 800; color: #212529; line-height: 1;
        }
        .pay-total-box .pt-amount.over { color: #fd7e14; }

        /* Payment fields */
        .pay-fields { padding: 14px 16px; display: flex; flex-direction: column; gap: 14px; }
        .pay-field-label {
            font-size: 12px; font-weight: 600; color: #495057;
            margin-bottom: 4px; display: flex; align-items: center; gap: 5px;
        }
        .pay-inp {
            border: 1.5px solid #ced4da; border-radius: 7px; padding: 8px 12px;
            font-size: 14px; font-weight: 600; width: 100%; outline: none;
            transition: border-color .15s, box-shadow .15s; background: #fff;
        }
        .pay-inp:focus { border-color: #adb5bd; box-shadow: 0 0 0 3px rgba(73,80,87,.1); }
        .pay-inp.inp-paid  { color: #0a58ca; }
        .pay-inp.inp-balance { color: #198754; background: #f8fffe; }
        .pay-inp.inp-balance.negative { color: #dc3545; background: #fff8f8; border-color: #f5c2c7; }

        /* Payment mode buttons */
        .pay-mode-group { display: flex; flex-wrap: wrap; gap: 6px; }
        .pay-mode-btn {
            flex: 1 1 auto; min-width: 60px; padding: 7px 10px;
            border: 1.5px solid #dee2e6; border-radius: 7px;
            background: #fff; color: #495057; font-size: 12.5px; font-weight: 500;
            cursor: pointer; text-align: center; transition: all .15s;
            display: flex; align-items: center; justify-content: center; gap: 5px;
        }
        .pay-mode-btn:hover { border-color: #adb5bd; background: #f8f9fa; }
        .pay-mode-btn.active { border-color: #343a40; background: #343a40; color: #fff; }

        /* Credit days box */
        .credit-days-wrap {
            margin-top: 10px; display: none;
            background: #fff8e1; border: 1.5px solid #ffe082; border-radius: 8px; padding: 10px 12px;
        }
        .credit-days-wrap.visible { display: flex; align-items: center; gap: 10px; }
        .credit-days-wrap .cdl { font-size: 12px; font-weight: 600; color: #856404; white-space: nowrap; }
        .credit-days-inp {
            border: 1.5px solid #ffc107; border-radius: 6px; padding: 5px 10px;
            font-size: 14px; font-weight: 600; color: #212529; width: 90px;
            outline: none; background: #fff; text-align: center;
            transition: border-color .15s, box-shadow .15s;
        }
        .credit-days-inp:focus { border-color: #fd7e14; box-shadow: 0 0 0 3px rgba(255,193,7,.2); }
        .credit-days-wrap .cdunit { font-size: 12px; color: #856404; font-weight: 500; }

        /* Grand total section */
        .grand-total-section { padding: 12px 16px; border-top: 2px solid #dee2e6; }

        .action-bar { display: flex; gap: 8px; justify-content: flex-end; }
        .btn-tb-save {
            background: linear-gradient(135deg, #198754 0%, #146c43 100%);
            color: #fff; border: none; border-radius: 7px; padding: 9px 18px;
            font-size: 13.5px; font-weight: 600; cursor: pointer;
            display: inline-flex; align-items: center; gap: 7px; transition: opacity .2s;
        }
        .btn-tb-save:hover { opacity: .9; }
        .btn-tb-save:disabled { opacity: .5; cursor: not-allowed; }
        .btn-tb-reset {
            background: #fff; color: #6c757d; border: 1.5px solid #ced4da;
            border-radius: 7px; padding: 9px 14px; font-size: 13.5px; font-weight: 500;
            cursor: pointer; display: inline-flex; align-items: center; gap: 7px; transition: border-color .15s;
        }
        .btn-tb-reset:hover { border-color: #6c757d; }

        /* Step badges */
        .step-badge {
            display: inline-flex; align-items: center; justify-content: center;
            width: 18px; height: 18px; background: #343a40; color: #fff;
            border-radius: 50%; font-size: 10px; font-weight: 700; margin-right: 4px; flex-shrink: 0;
        }
        .lr-search-wrap input:disabled {
            background: #f0f0f0; color: #adb5bd; cursor: not-allowed; border-color: #dee2e6;
        }
        .customer-selected-chip {
            display: flex; align-items: center; gap: 8px;
            background: #343a40; color: #fff; border-radius: 8px;
            padding: 8px 12px; font-size: 13px; font-weight: 500;
        }
        .customer-selected-chip .chip-change {
            background: rgba(255,255,255,.2); border: none; border-radius: 5px;
            color: #fff; font-size: 11px; padding: 2px 8px; cursor: pointer;
            transition: background .15s; white-space: nowrap;
        }
        .customer-selected-chip .chip-change:hover { background: rgba(255,255,255,.35); }

        @media (max-width: 767px) {
            .billing-panel-wrap { position: static; max-height: none; }
        }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>

<%
    request.setAttribute("pageTitle",    "Transportation Bill");
    request.setAttribute("pageSubtitle", "Create bill from LR Orders");
    request.setAttribute("pageIcon",     "fa-solid fa-file-invoice-dollar");
%>
<jsp:include page="/assets/common/pageHeader.jsp" />

<div class="container-fluid mt-3 tb-page">
<div class="row g-3 tb-main-row">

    <!-- ═══════════════════════════════
         LEFT — LR Related Details (70%)
    ═══════════════════════════════ -->
    <div class="col-lg-8 col-md-7">

        <!-- LR Selector -->
        <div class="card lr-selector-card mb-3">
            <div class="card-header-custom">
                <i class="fa-solid fa-magnifying-glass"></i>
                Select LR Numbers&nbsp;<span style="font-weight:400;font-size:13px;opacity:.85">(search customer &rarr; select LRs)</span>
            </div>
            <div class="card-body">
                <div class="row g-3 align-items-start">

                    <!-- Step 1: Customer -->
                    <div class="col-sm-4">
                        <label class="form-label fw-semibold mb-1" style="font-size:13px;">
                            <span class="step-badge">1</span> Customer
                        </label>
                        <!-- Customer input area (hidden after selection) -->
                        <div id="customerInputArea">
                            <div class="lr-search-wrap" id="customerSearchWrap">
                                <input type="text" id="customerSearchInput" class="form-control fg-inp"
                                       placeholder="Type customer name…" autocomplete="off">
                                <span class="search-icon"><i class="fa-solid fa-user fa-sm"></i></span>
                                <div class="lr-dropdown-list" id="customerDropdownList"></div>
                            </div>
                            <div class="text-muted mt-1" style="font-size:11.5px;">
                                <i class="fa-solid fa-circle-info me-1"></i>Only customers with unbilled LRs.
                            </div>
                        </div>
                        <!-- Selected customer chip (shown after selection) -->
                        <div id="selectedCustomerChip" style="display:none;">
                            <div class="customer-selected-chip">
                                <i class="fa-solid fa-user fa-sm"></i>
                                <span id="selectedCustomerName" style="flex:1;"></span>
                                <button class="chip-change" onclick="clearCustomer()" title="Change customer">
                                    <i class="fa-solid fa-pen fa-xs me-1"></i>Change
                                </button>
                            </div>
                            <div class="text-muted mt-1" style="font-size:11.5px;color:#198754!important;">
                                <i class="fa-solid fa-circle-check me-1"></i>Customer selected. Now search LR.
                            </div>
                        </div>
                    </div>

                    <!-- Step 2: LR Number -->
                    <div class="col-sm-4">
                        <label class="form-label fw-semibold mb-1" style="font-size:13px;">
                            <span class="step-badge">2</span> LR Number
                            <span id="lrSearchLockHint" style="font-size:10.5px;color:#adb5bd;font-weight:400;margin-left:4px;">
                                <i class="fa-solid fa-lock fa-xs"></i> select customer first
                            </span>
                        </label>
                        <div class="lr-search-wrap" id="lrSearchWrap">
                            <input type="text" id="lrSearchInput" class="form-control fg-inp"
                                   placeholder="Select customer first…" autocomplete="off" disabled>
                            <span class="search-icon"><i class="fa-solid fa-magnifying-glass fa-sm"></i></span>
                            <div class="lr-dropdown-list" id="lrDropdownList"></div>
                        </div>
                        <div class="text-muted mt-1" style="font-size:11.5px;">
                            <i class="fa-solid fa-circle-info me-1"></i>Shows <strong>unbilled</strong> LRs of selected customer.
                        </div>
                    </div>

                    <!-- Step 3: Selected chips -->
                    <div class="col-sm-4">
                        <label class="form-label fw-semibold mb-1" style="font-size:13px;">
                            <span class="step-badge">3</span> Selected LRs
                        </label>
                        <div class="selected-lr-chips" id="selectedLrChips">
                            <span class="text-muted" style="font-size:13px;">
                                <i class="fa-solid fa-arrow-left me-1"></i>No LR selected yet
                            </span>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- LR Info Blocks (one per selected LR) -->
        <div id="lrInfoBlocksContainer">
            <div class="lr-empty-state" id="lrEmptyState">
                <div class="empty-icon"><i class="fa-solid fa-truck"></i></div>
                <p class="fw-semibold mb-1">No LR Selected</p>
                <p>Search and select an LR number above to view its details.</p>
            </div>
        </div>

    </div><!-- /left -->

    <!-- ═══════════════════════════════
         RIGHT — Payment Panel (30%)
    ═══════════════════════════════ -->
    <div class="col-lg-4 col-md-5">
        <div class="billing-panel-wrap">
            <div class="pay-panel">
                <div class="pay-panel-header">
                    <i class="fa-solid fa-indian-rupee-sign"></i> Payment
                </div>

                <!-- Empty state -->
                <div class="pay-empty-state" id="payEmptyState">
                    <div class="empty-icon"><i class="fa-solid fa-receipt"></i></div>
                    <p class="fw-semibold mb-1">No LR selected</p>
                    <p>Select an LR and enter particulars to proceed with payment.</p>
                </div>

                <!-- Payment fields (shown after LR selected) -->
                <div id="paySection" style="display:none;">

                    <!-- Grand Total display -->
                    <div class="pay-total-box">
                        <div>
                            <div class="pt-label"><i class="fa-solid fa-calculator me-1"></i>Grand Total</div>
                            <div class="pt-meta" id="gtItemsCount">0 LR(s) &bull; 0 particular(s)</div>
                        </div>
                        <div class="pt-amount" id="gtAmount">₹ 0.00</div>
                    </div>

                    <div class="pay-fields">

                        <!-- PO No -->
                        <div class="row g-2">
                            <div class="col-12">
                                <div class="pay-field-label">
                                    <i class="fa-solid fa-hashtag fa-sm"></i> PO No
                                </div>
                                <input type="text" id="poNo" class="pay-inp" style="font-size:13px;"
                                       placeholder="e.g. TN DEPO">
                            </div>
                        </div>

                        <!-- Paid amount -->
                        <div>
                            <div class="pay-field-label">
                                <i class="fa-solid fa-hand-holding-dollar fa-sm"></i> Paid Amount
                            </div>
                            <input type="number" id="paidAmount" class="pay-inp inp-paid"
                                   placeholder="0.00" min="0" step="any"
                                   oninput="calcBalance()">
                        </div>

                        <!-- Balance -->
                        <div>
                            <div class="pay-field-label">
                                <i class="fa-solid fa-scale-balanced fa-sm"></i> Balance
                                <span style="font-size:10.5px;color:#adb5bd;font-weight:400;">(Total &minus; Paid)</span>
                            </div>
                            <input type="text" id="balanceAmount" class="pay-inp inp-balance"
                                   placeholder="0.00" readonly>
                        </div>

                        <!-- Payment Type -->
                        <div>
                            <div class="pay-field-label">
                                <i class="fa-solid fa-wallet fa-sm"></i> Payment Type
                            </div>
                            <div class="pay-mode-group" id="payTypeGroup">
                                <button type="button" class="pay-mode-btn active" data-type="1" onclick="selectPayType(this)">
                                    <i class="fa-solid fa-money-bill-wave fa-xs"></i> Cash
                                </button>
                                <button type="button" class="pay-mode-btn" data-type="2" onclick="selectPayType(this)">
                                    <i class="fa-solid fa-building-columns fa-xs"></i> Bank
                                </button>
                            </div>
                        </div>

                        <!-- Payment Mode (enabled for Bank) -->
                        <div id="payModeWrap" style="opacity:0.45;">
                            <div class="pay-field-label">
                                <i class="fa-solid fa-credit-card fa-sm"></i> Payment Mode
                            </div>
                            <select id="payModeSelect" class="pay-inp" style="font-size:13px;" disabled>
                                <option value="1">UPI</option>
                                <option value="2">Cheque</option>
                                <option value="3">Credit Card</option>
                                <option value="4">Debit Card</option>
                                <option value="5">NEFT</option>
                                <option value="6">IMPS</option>
                            </select>
                        </div>

                        <!-- Credit Days (shown when balance > 0) -->
                        <div class="credit-days-wrap" id="creditDaysWrap">
                            <span class="cdl"><i class="fa-solid fa-calendar-days fa-xs me-1"></i>Credit Days</span>
                            <input type="text" id="creditDaysInp" class="credit-days-inp" maxlength="50" placeholder="e.g. 30 / Next Monday">
                            <span class="cdunit">days</span>
                        </div>

                    </div><!-- /pay-fields -->

                    <!-- Actions -->
                    <div class="grand-total-section">
                        <div class="action-bar">
                            <button type="button" class="btn-tb-reset" onclick="resetAll()">
                                <i class="fa-solid fa-rotate-left"></i> Reset
                            </button>
                            <button type="button" class="btn-tb-save" id="btnSaveBill" onclick="saveBill()">
                                <i class="fa-solid fa-floppy-disk"></i> Save Bill
                            </button>
                        </div>
                    </div>

                </div><!-- /paySection -->
            </div><!-- /pay-panel -->
        </div><!-- /billing-panel-wrap -->
    </div><!-- /right -->

</div><!-- /row -->
</div><!-- /tb-page -->


<!-- ══════════════════════════════════════════════════════════
     JAVASCRIPT
══════════════════════════════════════════════════════════ -->
<script>
let LR_DATA          = [];
let selectedLRs      = {};
let rowCounters      = {};
let selectedCustomer   = null;
let selectedCustomerId = 0;

/* ── Load unbilled LR list ── */
function loadUnbilledLRs() {
    $.ajax({
        url: contextPath + '/logistics/transportBill/getUnbilledLRs.jsp',
        type: 'GET', dataType: 'json',
        success: function(data) { LR_DATA = data || []; },
        error: function() {
            LR_DATA = [];
            Swal.fire({ icon: 'error', title: 'Load Failed', text: 'Could not load unbilled LR list.' });
        }
    });
}

var contextPath = '<%=request.getContextPath()%>';
$(document).ready(function() {
    loadUnbilledLRs();
    initLRSearch();
    initCustomerSearch();
});

/* ── LR Search (filtered to selected customer) ── */
function initLRSearch() {
    const $input = $('#lrSearchInput');
    const $list  = $('#lrDropdownList');

    $input.on('input', function() {
        if (!selectedCustomer) return;
        const q = $(this).val().trim().toLowerCase();
        $list.empty();
        const available = LR_DATA.filter(lr =>
            !selectedLRs[lr.id] &&
            lr.customerName === selectedCustomer &&
            (q === '' || lr.lrNo.toLowerCase().includes(q))
        );
        if (available.length === 0) {
            $list.append('<div class="no-result"><i class="fa-solid fa-circle-info me-1"></i>No unbilled LR found for this customer</div>');
        } else {
            available.forEach(lr => {
                const $item = $(`
                    <div class="lr-item" data-id="${lr.id}">
                        <div>
                            <div class="lr-no-text">${escHtml(lr.lrNo)}</div>
                            <div class="lr-meta">${escHtml(lr.destination)} &bull; ${escHtml(lr.lrDate)}</div>
                        </div>
                        <div class="lr-dpf-badge">DPF &#8377;${fmtAmt(lr.dpf)}</div>
                    </div>
                `);
                $item.on('click', function() { selectLR(lr); });
                $list.append($item);
            });
        }
        $list.show();
    });

    $input.on('focus', function() {
        if (selectedCustomer) $input.trigger('input');
    });
    $(document).on('mousedown', function(e) {
        if (!$(e.target).closest('#lrSearchWrap').length) $list.hide();
    });
}

/* ── Customer Search ── */
function initCustomerSearch() {
    const $input = $('#customerSearchInput');
    const $list  = $('#customerDropdownList');

    $input.on('input', function() {
        const q = $(this).val().trim().toLowerCase();
        $list.empty();
        const customers = [...new Set(LR_DATA.map(lr => lr.customerName).filter(Boolean))].sort();
        const filtered  = customers.filter(name => q === '' || name.toLowerCase().includes(q));
        if (filtered.length === 0) {
            $list.append('<div class="no-result"><i class="fa-solid fa-circle-info me-1"></i>No customer found</div>');
        } else {
            filtered.forEach(name => {
                const total   = LR_DATA.filter(lr => lr.customerName === name).length;
                const pending = LR_DATA.filter(lr => lr.customerName === name && !selectedLRs[lr.id]).length;
                const $item = $(`
                    <div class="lr-item" data-name="${escHtml(name)}">
                        <div>
                            <div class="lr-no-text">${escHtml(name)}</div>
                            <div class="lr-meta">${pending} unbilled LR${pending !== 1 ? 's' : ''} available</div>
                        </div>
                        <div class="lr-dpf-badge" style="background:#495057;">${pending}</div>
                    </div>
                `);
                $item.on('click', function() { selectCustomer(name); });
                $list.append($item);
            });
        }
        $list.show();
    });

    $input.on('focus', function() { $input.trigger('input'); });
    $(document).on('mousedown', function(e) {
        if (!$(e.target).closest('#customerSearchWrap').length) $list.hide();
    });
}

function selectCustomer(name) {
    selectedCustomer = name;
    // Grab customerId from first matching LR
    const matchLR = LR_DATA.find(lr => lr.customerName === name);
    selectedCustomerId = matchLR ? matchLR.customerId : 0;
    $('#customerDropdownList').hide();
    $('#selectedCustomerName').text(name);
    $('#customerInputArea').hide();
    $('#selectedCustomerChip').show();
    // Enable LR search
    $('#lrSearchInput').prop('disabled', false).attr('placeholder', 'Type LR number…');
    $('#lrSearchLockHint').hide();
    $('#lrSearchInput').focus();
}

function clearCustomer() {
    selectedCustomer = null;
    // Clear all selected LRs
    selectedLRs = {}; rowCounters = {};
    renderChips();
    $('#lrInfoBlocksContainer .lr-info-block').remove();
    $('#lrEmptyState').show();
    $('#paySection').hide();
    $('#payEmptyState').show();
    $('#paidAmount').val('');
    $('#balanceAmount').val('');
    updateGrandTotal();
    // Reset customer UI
    $('#customerInputArea').show();
    $('#selectedCustomerChip').hide();
    $('#customerSearchInput').val('');
    // Disable LR search
    $('#lrSearchInput').prop('disabled', true).val('').attr('placeholder', 'Select customer first…');
    $('#lrDropdownList').hide();
    $('#lrSearchLockHint').show();
}

/* ── Select LR ── */
function selectLR(lr) {
    if (selectedLRs[lr.id]) return;
    selectedLRs[lr.id] = lr;
    $('#lrSearchInput').val('');
    $('#lrDropdownList').hide();
    renderChips();
    renderLRInfoBlock(lr);
    $('#payEmptyState').hide();
    $('#paySection').show();
    updateGrandTotal();
}

/* ── Remove LR ── */
function removeLR(lrId) {
    delete selectedLRs[lrId];
    delete rowCounters[lrId];
    renderChips();
    $(`#lrInfoBlock_${lrId}`).remove();

    if (Object.keys(selectedLRs).length === 0) {
        $('#lrEmptyState').show();
        $('#paySection').hide();
        $('#payEmptyState').show();
        $('#paidAmount').val('');
        $('#balanceAmount').val('');
    }
    updateGrandTotal();
}

/* ── Get notes for a LR ── */
function getLRNotes(lrId) {
    return ($(`#lrNotes_${lrId}`).val() || '').trim();
}

/* ── Chips ── */
function renderChips() {
    const $chips = $('#selectedLrChips');
    $chips.empty();
    const ids = Object.keys(selectedLRs);
    if (ids.length === 0) {
        $chips.append('<span class="text-muted" style="font-size:13px;"><i class="fa-solid fa-arrow-left me-1"></i>No LR selected yet</span>');
        return;
    }
    ids.forEach(id => {
        const lr = selectedLRs[id];
        $chips.append(`
            <div class="lr-chip">
                <span>${escHtml(lr.lrNo)}</span>
                <button class="chip-remove" onclick="removeLR(${lr.id})" title="Remove">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>
        `);
    });
}

/* ── LEFT: render LR info block + particulars ── */
function renderLRInfoBlock(lr) {
    $('#lrEmptyState').hide();
    $('#lrInfoBlocksContainer').append(`
    <div class="lr-info-block" id="lrInfoBlock_${lr.id}">
        <div class="lr-info-header">
            <div class="lr-no-badge">
                <i class="fa-solid fa-truck fa-sm"></i> ${escHtml(lr.lrNo)}
            </div>
            <button class="btn btn-sm btn-outline-danger" onclick="removeLR(${lr.id})" style="border-radius:6px;font-size:12px;">
                <i class="fa-solid fa-trash-can me-1"></i>Remove
            </button>
        </div>
        <div class="lr-detail-grid">
            <div class="lr-detail-item">
                <div class="lr-detail-label">Customer</div>
                <div class="lr-detail-val">${escHtml(lr.customerName)}</div>
            </div>
            <div class="lr-detail-item">
                <div class="lr-detail-label">Destination</div>
                <div class="lr-detail-val">${escHtml(lr.destination)}</div>
            </div>
            <div class="lr-detail-item">
                <div class="lr-detail-label">LR Date</div>
                <div class="lr-detail-val">${escHtml(lr.lrDate)}</div>
            </div>
            <div class="lr-detail-item dpf-item">
                <div class="lr-detail-label">DPF Limit</div>
                <div class="lr-detail-val">&#8377; ${fmtAmt(lr.dpf)}</div>
            </div>
            <div class="lr-detail-item">
                <div class="lr-detail-label">DPF Used</div>
                <div class="lr-detail-val" id="dpfUsed_${lr.id}" style="color:#495057;">&#8377; 0.00</div>
            </div>
            <div class="lr-detail-item">
                <div class="lr-detail-label">Remaining</div>
                <div class="lr-detail-val lbl-remain" id="dpfRemain_${lr.id}">&#8377; ${fmtAmt(lr.dpf)}</div>
            </div>
        </div>
        <div class="dpf-bar-section">
            <div class="progress dpf-bar">
                <div class="progress-bar bg-success" id="dpfBar_${lr.id}" role="progressbar" style="width:0%"></div>
            </div>
            <div class="over-limit-alert" id="overLimitAlert_${lr.id}">
                <i class="fa-solid fa-triangle-exclamation me-1"></i>
                Amount exceeds DPF limit of &#8377; ${fmtAmt(lr.dpf)}
            </div>
            <div class="under-limit-alert" id="underLimitAlert_${lr.id}">
                <i class="fa-solid fa-circle-exclamation me-1"></i>
                Short by &#8377; <span id="underLimitAmt_${lr.id}">0.00</span>&nbsp;&mdash; total must equal DPF limit
            </div>
        </div>
    </div>`);
    renderParticularsSection(lr);
}

/* ── LEFT: render particulars table inside LR block ── */
function renderParticularsSection(lr) {
    $(`#lrInfoBlock_${lr.id}`).append(`
        <div class="part-pane pt-2">
            <div style="font-size:12px;font-weight:600;color:#495057;margin-bottom:6px;">
                <i class="fa-solid fa-list fa-xs me-1"></i>Particulars
            </div>
            <table class="part-table">
                <thead>
                    <tr>
                        <th style="width:26px;">#</th>
                        <th style="width:120px;">LR No</th>
                        <th>Particular</th>
                        <th style="width:80px;">Qty/Articles</th>
                        <th style="width:90px;">Rate/Wt</th>
                        <th style="width:90px;">Amount</th>
                        <th style="width:28px;"></th>
                    </tr>
                </thead>
                <tbody id="partBody_${lr.id}"></tbody>
            </table>
        </div>
        <button type="button" class="btn-add-row" onclick="addParticularsRow(${lr.id})">
            <i class="fa-solid fa-plus fa-xs"></i> Add Particular
        </button>
        <div class="lr-subtotal-strip mt-2">
            <div>
                <span class="sub-label">LR Total</span>
                <span class="sub-limit">&nbsp;/ &#8377;${fmtAmt(lr.dpf)} DPF</span>
            </div>
            <span class="sub-val" id="lrSubtotal_${lr.id}">&#8377; 0.00</span>
        </div>
        <div class="lr-notes-wrap">
            <div class="lr-notes-label">
                <i class="fa-solid fa-note-sticky fa-xs"></i> Notes
                <span style="font-size:10.5px;color:#adb5bd;font-weight:400;">(optional)</span>
            </div>
            <textarea class="lr-notes-inp" id="lrNotes_${lr.id}"
                      placeholder="Add any notes for LR ${escHtml(lr.lrNo)}…" rows="2"></textarea>
        </div>
    `);
    addParticularsRow(lr.id);
}

/* ── Add particulars row ── */
function addParticularsRow(lrId) {
    if (!rowCounters[lrId]) rowCounters[lrId] = 0;
    rowCounters[lrId]++;
    const rIdx   = rowCounters[lrId];
    const $tbody = $(`#partBody_${lrId}`);
    $tbody.append(`
        <tr id="partRow_${lrId}_${rIdx}">
            <td style="text-align:center;color:#6c757d;font-size:11px;" class="row-sno">${$tbody.children().length + 1}</td>
            <td><input type="text"   class="tbl-inp inp-lrno"      placeholder="LR No"></td>
            <td><input type="text"   class="tbl-inp inp-particular" placeholder="Particular…"  oninput="recalcLR(${lrId})"></td>
            <td><input type="number" class="tbl-inp inp-sm inp-qty"  placeholder="0"    min="0" step="any" oninput="recalcLR(${lrId})"></td>
            <td><input type="text"   class="tbl-inp inp-sm inp-rate" placeholder="0/text"       oninput="recalcLR(${lrId})"></td>
            <td><input type="number" class="tbl-inp inp-amount"     placeholder="0.00" min="0" step="any" oninput="recalcLR(${lrId})" id="amtInp_${lrId}_${rIdx}"></td>
            <td>
                <button type="button" class="btn-remove-row" onclick="removePartRow(${lrId},${rIdx})" title="Remove">
                    <i class="fa-solid fa-minus fa-xs"></i>
                </button>
            </td>
        </tr>
    `);
    renumberRows(lrId);
}

function removePartRow(lrId, rIdx) {
    $(`#partRow_${lrId}_${rIdx}`).remove();
    renumberRows(lrId);
    recalcLR(lrId);
}

function renumberRows(lrId) {
    $(`#partBody_${lrId} tr`).each(function(i) {
        $(this).find('.row-sno').text(i + 1);
    });
}

/* ── Recalculate one LR ── */
function recalcLR(lrId) {
    const lr = selectedLRs[lrId];
    if (!lr) return;
    let total = 0;
    $(`#partBody_${lrId} tr`).each(function() {
        total += parseFloat($(this).find('.inp-amount').val()) || 0;
    });

    const dpf     = lr.dpf;
    const pct     = dpf > 0 ? Math.min((total / dpf) * 100, 100) : 0;
    const shortfall = dpf - total;
    const isOver  = total > dpf + 0.004;          // over limit
    const isUnder = total < dpf - 0.004;          // below limit
    const isExact = !isOver && !isUnder;          // matches DPF

    $(`#dpfBar_${lrId}`)
        .css('width', pct + '%')
        .removeClass('bg-success bg-warning bg-danger')
        .addClass(isExact ? 'bg-success' : isOver ? 'bg-danger' : 'bg-warning');

    $(`#dpfUsed_${lrId}`).text('\u20b9 ' + fmtAmt(total));
    const $rem = $(`#dpfRemain_${lrId}`);
    $rem.text('\u20b9 ' + fmtAmt(Math.abs(shortfall)));
    $rem.toggleClass('over', isOver);

    $(`#overLimitAlert_${lrId}`).toggleClass('visible', isOver);
    const $ua = $(`#underLimitAlert_${lrId}`);
    $ua.toggleClass('visible', isUnder && total > 0);
    if (isUnder) $(`#underLimitAmt_${lrId}`).text(fmtAmt(shortfall));

    const $sub = $(`#lrSubtotal_${lrId}`);
    $sub.text('\u20b9 ' + fmtAmt(total));
    $sub.removeClass('over under').addClass(isOver ? 'over' : isUnder ? 'under' : '');
    $(`#partBody_${lrId} .inp-amount`).toggleClass('over-limit', isOver);

    updateGrandTotal();
}

/* ── Grand total ── */
function updateGrandTotal() {
    let grandTotal = 0, totalParts = 0, hasInvalid = false;
    const lrCount  = Object.keys(selectedLRs).length;
    Object.keys(selectedLRs).forEach(lrId => {
        const lr = selectedLRs[lrId];
        let lrTotal = 0;
        $(`#partBody_${lrId} tr`).each(function() {
            const amt = parseFloat($(this).find('.inp-amount').val()) || 0;
            lrTotal += amt;
            totalParts++;
        });
        grandTotal += lrTotal;
        if (Math.abs(lrTotal - lr.dpf) > 0.004) hasInvalid = true;  // must equal DPF
    });
    $('#gtAmount').text('\u20b9 ' + fmtAmt(grandTotal)).toggleClass('over', hasInvalid);
    $('#gtItemsCount').text(lrCount + ' LR(s) \u2022 ' + totalParts + ' particular(s)');
    $('#btnSaveBill').prop('disabled', hasInvalid || lrCount === 0);
    calcBalance();
}

/* ── Balance calculation ── */
function calcBalance() {
    const totalText = $('#gtAmount').text().replace(/[^0-9.]/g, '');
    const total   = parseFloat(totalText) || 0;
    const paid    = parseFloat($('#paidAmount').val()) || 0;
    const balance = total - paid;
    const $bal    = $('#balanceAmount');
    $bal.val('\u20b9 ' + fmtAmt(Math.abs(balance)));
    $bal.toggleClass('negative', balance < 0);
    if (balance < 0) {
        $bal.attr('title', 'Excess payment of \u20b9 ' + fmtAmt(Math.abs(balance)));
    } else {
        $bal.attr('title', '');
    }
    // Show/hide credit days box
    if (balance > 0.001) {
        $('#creditDaysWrap').addClass('visible');
    } else {
        $('#creditDaysWrap').removeClass('visible');
        $('#creditDaysInp').val('');
    }
}

/* ── Payment mode selection ── */
function selectPayType(btn) {
    $('#payTypeGroup .pay-mode-btn').removeClass('active');
    $(btn).addClass('active');
    const type = parseInt($(btn).data('type'));
    if (type === 1) { // Cash — disable mode
        $('#payModeSelect').prop('disabled', true);
        $('#payModeWrap').css('opacity', '0.45');
    } else { // Bank — enable mode, auto-select UPI if blank
        $('#payModeSelect').prop('disabled', false);
        if (!$('#payModeSelect').val()) $('#payModeSelect').val('1');
        $('#payModeWrap').css('opacity', '1');
    }
}

/* ── Save Bill ── */
function saveBill() {
    if (!selectedCustomerId) {
        Swal.fire({ icon: 'warning', title: 'No Customer', text: 'Please select a customer first.' });
        return;
    }
    const lrIds = Object.keys(selectedLRs);
    if (!lrIds.length) {
        Swal.fire({ icon: 'warning', title: 'No LR', text: 'Please select at least one LR.' });
        return;
    }

    // Collect payment type & mode
    const payType    = parseInt($('#payTypeGroup .pay-mode-btn.active').data('type')) || 1;
    const payModeInt = payType === 1 ? 0 : (parseInt($('#payModeSelect').val()) || 1);
    const creditDays = ($('#creditDaysInp').val() || '').trim();

    const totalText = $('#gtAmount').text().replace(/[^\.0-9]/g, '');
    const grandTotal  = parseFloat(totalText) || 0;
    const paidAmount  = parseFloat($('#paidAmount').val()) || 0;
    const balanceText = $('#balanceAmount').val().replace(/[^\.0-9]/g, '');
    const balance     = parseFloat(balanceText) || 0;

    // Build LR payload
    const lrs = lrIds.map(lrId => {
        const lr = selectedLRs[lrId];
        const parts = [];
        $(`#partBody_${lrId} tr`).each(function() {
            const lrNo       = $(this).find('.inp-lrno').val()        || '';
            const particular = $(this).find('.inp-particular').val() || '';
            const qty        = $(this).find('.inp-qty').val()         || '';
            const rateWt     = $(this).find('.inp-rate').val()        || '';
            const amount     = parseFloat($(this).find('.inp-amount').val()) || 0;
            if (particular.trim() || amount > 0) {
                parts.push({ lrNo, particular, qty, rateWt, amount });
            }
        });
        return {
            lrId:   parseInt(lrId),
            lrTotal: parseFloat(($(`#lrSubtotal_${lrId}`).text().replace(/[^\.0-9]/g,'')) || 0),
            notes:  getLRNotes(parseInt(lrId)),
            particulars: parts
        };
    });

    const payload = {
        customerId:   selectedCustomerId,
        poNo:         $('#poNo').val().trim(),
        sacCode:      '996791',
        grandTotal,
        paidAmount,
        balance,
        paymentType:  payType,
        paymentModeInt: payModeInt,
        creditDays,
        lrs
    };

    // Disable save button during request
    $('#btnSaveBill').prop('disabled', true).html('<i class="fa-solid fa-spinner fa-spin me-1"></i> Saving...');

    $.ajax({
        url:  contextPath + '/logistics/transportBill/saveBill.jsp',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(payload),
        dataType: 'json',
        success: function(res) {
            if (res.success) {
                Swal.fire({
                    icon: 'success',
                    title: 'Bill Saved!',
                    html: '<b>Invoice No: ' + res.invoiceNo + '</b>',
                    showCancelButton: true,
                    confirmButtonText: '<i class="fa-solid fa-print me-1"></i> Print Bill',
                    cancelButtonText: 'Close',
                    confirmButtonColor: '#198754'
                }).then(r => {
                    if (r.isConfirmed) {
                        window.open(contextPath + '/logistics/transportBill/print.jsp?billId=' + res.billId, '_blank');
                    }
                    resetAll(true);
                });
            } else {
                Swal.fire({ icon: 'error', title: 'Save Failed', text: res.error || 'Unknown error' });
                $('#btnSaveBill').prop('disabled', false).html('<i class="fa-solid fa-floppy-disk"></i> Save Bill');
            }
        },
        error: function() {
            Swal.fire({ icon: 'error', title: 'Network Error', text: 'Could not connect to server.' });
            $('#btnSaveBill').prop('disabled', false).html('<i class="fa-solid fa-floppy-disk"></i> Save Bill');
        }
    });
}

/* ── Reset ── */
function resetAll(skipConfirm) {
    function doReset() {
        selectedLRs = {}; rowCounters = {}; selectedCustomer = null; selectedCustomerId = 0;
        renderChips();
        $('#lrInfoBlocksContainer .lr-info-block').remove();
        $('#lrEmptyState').show();
        $('#paySection').hide();
        $('#payEmptyState').show();
        $('#paidAmount').val('');
        $('#balanceAmount').val('');
        $('#creditDaysInp').val('');
        $('#creditDaysWrap').removeClass('visible');
        $('#poNo').val('');
        $('#payTypeGroup .pay-mode-btn').removeClass('active');
        $('#payTypeGroup .pay-mode-btn[data-type="1"]').addClass('active');
        $('#payModeSelect').prop('disabled', true).val('1');
        $('#payModeWrap').css('opacity', '0.45');
        $('#gtAmount').text('\u20b9 0.00');
        $('#gtItemsCount').text('0 LR(s) \u2022 0 particular(s)');
        $('#btnSaveBill').prop('disabled', false).html('<i class="fa-solid fa-floppy-disk"></i> Save Bill');
        // Reset customer step
        $('#customerInputArea').show();
        $('#selectedCustomerChip').hide();
        $('#customerSearchInput').val('');
        // Reset LR search step
        $('#lrSearchInput').prop('disabled', true).val('').attr('placeholder', 'Select customer first…');
        $('#lrDropdownList').hide();
        $('#lrSearchLockHint').show();
        loadUnbilledLRs();
    }
    if (skipConfirm === true) { doReset(); return; }
    Swal.fire({
        icon: 'warning', title: 'Reset?',
        text: 'This will clear all selected LRs and entered data.',
        showCancelButton: true, confirmButtonText: 'Yes, Reset',
        cancelButtonText: 'Cancel', confirmButtonColor: '#dc3545'
    }).then(res => { if (res.isConfirmed) doReset(); });
}

/* ── Helpers ── */
function fmtAmt(n) {
    return parseFloat(n || 0).toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}
function escHtml(s) {
    if (!s) return '';
    return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}
</script>

</body>
</html>
