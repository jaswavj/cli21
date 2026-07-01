<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}

String idParam = request.getParameter("id");
if (idParam == null || idParam.trim().isEmpty()) {
    out.print("<h3 style='padding:30px;'>Invalid LR id.</h3>");
    return;
}

int id = 0;
try { id = Integer.parseInt(idParam.trim()); } catch (Exception e) {
    out.print("<h3 style='padding:30px;'>Invalid LR id.</h3>");
    return;
}

Vector lr = bill.getLrCopyById(id);
if (lr.isEmpty()) {
    out.print("<h3 style='padding:30px;'>LR not found.</h3>");
    return;
}

Vector co = bill.getCompanyDetailsForPrint();
if (co.isEmpty()) {
    co.addElement("");
    co.addElement("");
    co.addElement("");
    co.addElement("");
}

String contextPath = request.getContextPath();
String copyType = request.getParameter("copyType");
if (copyType == null || copyType.trim().isEmpty()) copyType = "consignee";
String copyTitle = "Consignee Copy ";
if ("consignor".equalsIgnoreCase(copyType)) {
    copyTitle = "Consignor Copy ";
} else if ("driver".equalsIgnoreCase(copyType)) {
    copyTitle = "Driver Copy ";
}
String copyTitleHeading = copyTitle.trim().toUpperCase();
int customerId = 0;
try { customerId = Integer.parseInt(lr.get(2).toString()); } catch (Exception ignore) {}
String customerAddress = "";
try { customerAddress = bill.getCustomerAddressById(customerId); } catch (Exception ignore) {}
String lrNo = lr.get(1).toString();
String customerName = lr.get(3).toString();
String phone = lr.get(4).toString();
String lrDate = lr.get(5).toString();
String truckNo = lr.get(6).toString();
String fromLocation = lr.get(7).toString();
String toLocation = lr.get(8).toString();
String consigneeName = lr.get(9).toString();
String consigneeAddress = "";
try { consigneeAddress = bill.getCustomerAddressByName(consigneeName); } catch (Exception ignore) {}
String noOfArticles = lr.get(10).toString();
String descriptionText = lr.get(11).toString();
String weightMt = lr.get(12).toString();
String modePayment1 = lr.get(13).toString();
boolean toBeBilledInChennai = modePayment1 != null && modePayment1.toLowerCase().contains("billed in chennai");
String freightAmount = lr.get(14).toString();
String toPayAmount = lr.get(15).toString();
String paidAmount = lr.get(16).toString();
String amountInWords = lr.get(17).toString();
String dcNo = lr.get(18).toString();
String invDate = lr.get(19).toString();
String invNo = lr.get(20).toString();
String invNoDisplay = "";
if (invNo != null) {
    String invNoFlat = invNo.replace("\r", "").replace("\n", "");
    StringBuilder invNoBuf = new StringBuilder();
    for (int i = 0; i < invNoFlat.length(); i += 20) {
        int end = Math.min(i + 20, invNoFlat.length());
        if (i > 0) invNoBuf.append("<br>");
        invNoBuf.append(invNoFlat.substring(i, end));
    }
    invNoDisplay = invNoBuf.toString();
}
String invDate2 = lr.get(21).toString();
String declaredValueRs = lr.get(22).toString();
String declaredValueDisplay = declaredValueRs == null ? "" : declaredValueRs.trim();
if (!declaredValueDisplay.isEmpty()) {
    String[] rawParts = declaredValueDisplay.split("[,\\n\\r\\+]+");
    java.util.ArrayList numParts = new java.util.ArrayList();
    boolean allNumeric = true;
    double declaredTotal = 0;
    for (int dv = 0; dv < rawParts.length; dv++) {
        String part = rawParts[dv].trim();
        if (part.isEmpty()) continue;
        String cleaned = part.replace(",", "");
        try {
            double val = Double.parseDouble(cleaned);
            numParts.add(part);
            declaredTotal += val;
        } catch (Exception ignore) {
            allNumeric = false;
            break;
        }
    }
    if (allNumeric && !numParts.isEmpty()) {
        String totalText;
        if (declaredTotal == Math.floor(declaredTotal)) totalText = String.valueOf((long) declaredTotal);
        else totalText = String.valueOf(declaredTotal);
        declaredValueDisplay = totalText + "";
    }
}
String pnlSealNo = lr.get(23).toString();
String materialReceivedDate = lr.get(24).toString();
String pnlNo = lr.get(25).toString();
String driverName = lr.get(26).toString();
String vehicleType = lr.get(27).toString();
String deliverIn = lr.get(28).toString();
String deliverInNorm = (deliverIn == null ? "" : deliverIn.trim().toLowerCase());
boolean isDoorDelivery = "door delivery".equals(deliverInNorm);
boolean isUnloadedByParty = "unloaded by party".equals(deliverInNorm);
boolean isByTransporter = "by transporter".equals(deliverInNorm);
String companyName = co.get(0).toString();
companyName = companyName.replaceAll("(?i)<br\\s*/?>", " ").replace('\n', ' ').replace('\r', ' ').trim();
String companyAddressPrint = co.get(1).toString().replaceAll("(?i)<br\\s*/?>", ", ").replace('\n', ' ').replace('\r', ' ').trim();
String companyContactPrint = "99941 82275, 98844 83426";
String qrContent = companyName + "\n" + companyAddressPrint + "\nCell: " + companyContactPrint;
String qrContentJs = qrContent.replace("\\", "\\\\").replace("\"", "\\\"").replace("\r", "").replace("\n", "\\n");
String qrDataEncoded = java.net.URLEncoder.encode(qrContent, "UTF-8").replace("+", "%20");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>LR Copy - <%=lrNo%></title>
<style>
    * { box-sizing: border-box; }
    body { margin:0; font-family: Arial, Helvetica, sans-serif; color:#0b2f63; font-size:12px; background:#fff; }
    .page {
        width: 210mm;
        min-height: 297mm;
        height: 297mm;
        margin: 0 auto;
        padding: 7mm 8mm;
        display: flex;
        flex-direction: column;
        border: 1px solid #5a5a5a;
        background: #fff;
    }

    .print-header {
        padding: 4px 6px 6px;
        margin-bottom: 0;
        border: 1px solid #666;
        position: relative;
    }
    .header-corner-decor { display:none; }

    .header-topline {
        display:flex;
        align-items:flex-start;
        justify-content:space-between;
        padding: 1px 2px 3px;
        margin-bottom: 5px;
    }
    .header-meta-left, .header-meta-right {
        width: 26%;
        font-size:11px;
        font-weight:700;
        color:#1b5e20;
        white-space:nowrap;
    }
    .header-meta-right { text-align:right; }
    .header-cell {
        display:inline-block;
        text-align:right;
        line-height:1.15;
        white-space:normal;
        color:#1b5e20;
    }
    .header-cell .cell-label { color:#1b5e20; }
    .header-devotion-center {
        width: 48%;
        display:flex;
        justify-content:center;
    }

    .header-main { display:flex; position:relative; z-index:2; }
    .logo-wrap { width:20%; display:flex; align-items:center; justify-content:center; padding-right:8px; }
    .logo-wrap img {
        width:100%;
        max-width:128px;
        filter: brightness(0) saturate(100%) invert(16%) sepia(73%) saturate(1918%) hue-rotate(341deg) brightness(92%) contrast(94%);
    }
    .logo-wrap .no-logo { width:100%; max-width:128px; aspect-ratio:1.7; display:flex; align-items:center; justify-content:center; color:#222; border:1px solid #999; }
    .header-content { width:80%; display:flex; align-items:center; padding-left:8px; }
    .co-block { width:100%; text-align:center; color:#0b2f63; }
    .co-name {
        font-size:34px;
        font-weight:800;
        letter-spacing:1px;
        text-transform:uppercase;
        line-height:1.02;
        color:#8d1f1f;
        white-space:nowrap;
    }
    .co-sub { font-size:12px; margin-top:3px; white-space:pre-wrap; line-height:1.2; color:#0b2f63; }
    .co-devotion { display:inline-flex; align-items:flex-start; gap:6px; font-size:11px; white-space:nowrap; }
    .dev-soolam-wrap {
        width:24px;
        height:42px;
        display:inline-flex;
        align-items:flex-start;
        justify-content:center;
        overflow:hidden;
        margin-right:4px;
        flex-shrink:0;
    }
    .dev-soolam {
        width:34px;
        height:34px;
        display:inline-block;
        vertical-align:middle;
        object-fit:cover;
        object-position:center 0%;
        transform:translateY(-2px) scale(1.9);
        transform-origin:center top;
    }
    .dev-left { display:inline-flex; flex-direction:column; align-items:flex-start; gap:1px; }
    .dev-top { display:inline-flex; align-items:center; gap:3px; color:#1b5e20; }
    .dev-main { font-weight:800; letter-spacing:0.2px; color:#1b5e20; }
    .dev-win { font-weight:800; letter-spacing:0.2px; font-size:10px; margin-left:26px; color:#1b5e20; }
    .header-divider { display:none; height:0; margin:0; border:0; }

    .title-bar {
        border:1px solid #666;
        text-align:center;
        font-weight:700;
        color:#0b2f63;
        padding:4px;
        margin-bottom:0;
        font-size:15px;
        text-transform:uppercase;
        letter-spacing:0.5px;
    }
    .copy-part { color:#8d1f1f; }
    .risk-part { color:#0b2f63; }
    .header-divider + .title-bar { margin-top:-1px; }

    .box { border:1px solid #000; margin-bottom:0; }
    .info-row .cell { width:33.33%; }
    .route-row .cell { width:50%; }
    .info-row .inline-pair,
    .route-row .inline-pair { margin-bottom:0; }
    .info-row .val,
    .route-row .val { font-size:15px; font-weight:700; min-height:0; }
    .row { display:flex; }
    .cell { border-right:1px solid #000; border-bottom:1px solid #000; padding:7px 9px; font-size:13px; }
    .cell:last-child { border-right:none; }
    .row:last-child .cell { border-bottom:none; }
    .lbl {
        font-size:12px;
        color:#0b2f63;
        text-transform:uppercase;
        font-weight:700;
        display:block;
        margin-bottom:4px;
        line-height:1.1;
    }
    .val {
        font-size:14px;
        font-weight:600;
        min-height:20px;
        white-space:pre-wrap;
        line-height:1.35;
    }
    .inline-pair {
        display:flex;
        align-items:baseline;
        gap:8px;
        margin-bottom:6px;
        flex-wrap:nowrap;
    }
    .inline-pair:last-child { margin-bottom:0; }
    .inline-pair .lbl {
        display:inline;
        margin:0;
        white-space:nowrap;
        flex:0 0 auto;
    }
    .inline-pair .val {
        display:inline-block;
        min-height:0;
        white-space:normal;
        line-height:1.3;
        flex:1 1 auto;
        min-width:0;
        word-break:break-word;
    }
    .party-block {
        display:grid;
        grid-template-columns:auto 1fr;
        column-gap:8px;
        row-gap:4px;
        align-items:start;
    }
    .party-lbl {
        grid-column:1;
        grid-row:1;
        font-size:12px;
        font-weight:700;
        text-transform:uppercase;
        color:#0b2f63;
        white-space:nowrap;
        line-height:1.1;
    }
    .party-name {
        grid-column:2;
        grid-row:1;
        font-size:15px;
        font-weight:700;
        color:#0b2f63;
        line-height:1.35;
        word-break:break-word;
    }
    .party-addr {
        grid-column:2;
        grid-row:2;
        font-size:15px;
        font-weight:700;
        color:#0b2f63;
        line-height:1.35;
        white-space:pre-wrap;
        word-break:break-word;
    }

    .w40 { width:40%; } .w60 { width:60%; } .w25 { width:25%; } .w20 { width:20%; } .w15 { width:15%; } .w35 { width:35%; } .w33 { width:33.33%; } .w50 { width:50%; }

    table.lr-table { width:100%; border-collapse:collapse; margin-top:0; }
    .lr-table th, .lr-table td { border:1px solid #000; padding:7px 9px; font-size:13px; vertical-align:top; color:#0b2f63; }
    .lr-table th { background:#ececec; text-transform:none; font-size:12px; font-weight:700; text-align:center; }
    .lr-table td:nth-child(1), .lr-table td:nth-child(2) { text-align:center; }

    .mode-grid { display:grid; grid-template-columns: 1fr; gap:2px; }
    .mode-item { border:1px solid #777; padding:5px 7px; font-size:12px; color:#0b2f63; }

    .detail-grid {
        width:100%;
        border-collapse:collapse;
        table-layout:fixed;
    }
    .detail-grid td {
        border:1px solid #000;
        padding:7px 9px;
        vertical-align:top;
    }
    .detail-grid td.detail-split-cell { padding:0; }
    .detail-grid td.deliver-cell { vertical-align:bottom; }
    .detail-grid td.qr-cell {
        vertical-align:middle;
        text-align:center;
        padding:4px;
    }
    .detail-grid td.qr-cell canvas,
    .detail-grid td.qr-cell img {
        display:block;
        width:100%;
        max-width:108px;
        height:auto;
        margin:0 auto;
    }
    .detail-half-row { display:flex; height:100%; }
    .detail-half-col {
        width:50%;
        padding:7px 9px;
        border-right:1px solid #000;
    }
    .detail-half-col:last-child { border-right:none; }
    .detail-lbl {
        font-size:12px;
        color:#0b2f63;
        text-transform:uppercase;
        font-weight:700;
        display:block;
        margin-bottom:4px;
        line-height:1.1;
    }
    .detail-val {
        font-size:14px;
        font-weight:600;
        min-height:20px;
        white-space:pre-wrap;
        line-height:1.35;
        color:#0b2f63;
    }
    .inv-wrap {
        white-space:normal;
        overflow-wrap:anywhere;
        word-break:break-word;
    }
    .deliver-options-list {
        display:flex;
        flex-direction:row;
        flex-wrap:nowrap;
        align-items:center;
        justify-content:space-between;
        gap:3px;
    }
    .deliver-opt-item {
        flex:1;
        font-weight:700;
        text-transform:uppercase;
        font-size:9px;
        line-height:1.15;
        color:#0b2f63;
        white-space:nowrap;
        text-align:center;
    }
    .deliver-opt-item .tick-mark {
        width:9px;
        margin-right:2px;
        font-size:9px;
    }
    .deliver-in-grid {
        margin-top:6px;
        display:flex;
        gap:0;
        border:1px solid #000;
    }
    .deliver-opt {
        flex:1;
        border-right:1px solid #000;
        padding:4px 6px;
        font-size:12px;
        font-weight:700;
        text-transform:uppercase;
        text-align:center;
        line-height:1.2;
        color:#0b2f63;
    }
    .deliver-opt:last-child { border-right:none; }
    .tick-mark {
        display:inline-block;
        width:12px;
        margin-right:4px;
        color:#0b2f63;
        font-weight:800;
    }

    .footer-sign { margin-top:0; border:1px solid #000; border-top:0; padding:0; min-height:116px; }
    .footer-grid { display:flex; gap:0; min-height:116px; height:100%; align-items:stretch; }
    .recv-box { width:60%; border-right:1px solid #000; padding:10px; }
    .recv-title { color:#8d1f1f; font-weight:700; text-transform:uppercase; font-size:12px; margin-bottom:8px; }
    .recv-oval {
        height:62px;
        width:94%;
        margin:0 auto;
        border:2.5px solid #a63a2f;
        border-radius:50%;
    }
    .clerk-box { width:40%; display:flex; flex-direction:column; justify-content:flex-end; padding:10px; }
    .sign-line { border-top:1px solid #000; text-align:center; font-size:11px; font-weight:700; padding-top:4px; }

    .print-note { text-align:center; font-size:11px; color:#666; margin-top:6px; }
    .footer-bottom {
        display:flex;
        justify-content:space-between;
        align-items:flex-start;
        gap:10px;
        margin-top:3px;
        padding:0 2px;
        line-height:1.25;
    }
    .footer-bottom-left {
        text-align:left;
        flex:1 1 auto;
        font-size:8px;
        color:#777;
        font-weight:600;
        letter-spacing:0.2px;
        opacity:0.8;
    }
    .footer-bottom-right {
        text-align:right;
        flex:1 1 auto;
        font-size:10px;
        color:#0b2f63;
        font-weight:600;
        print-color-adjust:exact;
        -webkit-print-color-adjust:exact;
    }
    .print-spacer { display:none; }

    .page-terms {
        margin-top:12px;
        display:flex;
        flex-direction:column;
        height:297mm;
        min-height:297mm;
    }
    .terms-title {
        text-align:center;
        font-size:17px;
        font-weight:800;
        text-transform:uppercase;
        letter-spacing:0.5px;
        color:#0b2f63;
        margin:0 0 14px;
        padding-bottom:8px;
        border-bottom:1px solid #000;
        flex-shrink:0;
    }
    .terms-body {
        flex:1;
        font-size:12px;
        line-height:1.4;
        color:#0b2f63;
        text-align:justify;
    }
    .terms-body p {
        margin:0 0 5px;
    }
    .terms-body p:last-child { margin-bottom:0; }

    .body-with-gst {
        display:flex;
        align-items:stretch;
        margin-top:-1px;
    }
    .body-main {
        flex:1;
        min-width:0;
        display:flex;
        flex-direction:column;
    }
    .gst-vertical-strip {
        width:26px;
        flex-shrink:0;
        border:1px solid #000;
        border-left:1px solid #000;
        margin-left:-1px;
        background:#fff;
        display:flex;
        align-items:center;
        justify-content:center;
        padding:6px 2px;
    }
    .gst-vertical-text {
        writing-mode:vertical-rl;
        transform:rotate(180deg);
        font-size:9px;
        font-weight:700;
        text-transform:uppercase;
        letter-spacing:0.3px;
        color:#0b2f63;
        line-height:1.15;
        text-align:center;
        white-space:nowrap;
    }

    /* Join adjacent section borders as one continuous form */
    .title-bar + .box,
    .box + .body-with-gst,
    .body-main table.lr-table + .box,
    .body-with-gst + .footer-sign {
        margin-top: -1px;
    }

    .no-print { background:#343a40; color:#fff; padding:10px 16px; display:flex; gap:10px; align-items:center; }
    .no-print button { border:none; border-radius:6px; padding:7px 14px; font-size:13px; cursor:pointer; }

    @media print {
        @page { size: A4; margin: 0; }
        .no-print { display:none !important; }
        html, body {
            width: 210mm;
            margin: 0;
            padding: 0;
            overflow: visible;
            height: auto;
            print-color-adjust: exact;
            -webkit-print-color-adjust: exact;
        }
        .page {
            margin: 0 auto;
            min-height: 297mm;
            height: 297mm;
            page-break-after: always;
            break-after: page;
        }
        .page:last-of-type {
            page-break-after: auto;
            break-after: auto;
        }
        .page-terms {
            page-break-before: always;
            break-before: page;
            margin-top: 0;
        }
    }
</style>
</head>
<body>
<div class="no-print">
    <span><%=copyTitle%> - <%=lrNo%></span>
    <button style="background:#198754;color:#fff;" onclick="window.print()">Print</button>
    <button style="background:#6c757d;color:#fff;" onclick="window.close()">Close</button>
</div>

<div class="page page-lr">
    <div class="print-header">
        <div class="header-topline">
            <div class="header-meta-left">
                <% if (!co.get(2).toString().isEmpty()) { %>
                GSTIN : <%=co.get(2)%>
                <% } %>
            </div>
            <div class="header-devotion-center">
                <div class="co-devotion">
                    <span class="dev-soolam-wrap">
                        <img class="dev-soolam" src="<%=contextPath%>/logistics/transportBill/soolam2.png" alt="Soolam" onerror="this.onerror=null;this.src='<%=contextPath%>/logistics/transportBill/soolam1.png';">
                    </span>
                    <span class="dev-left">
                        <span class="dev-top">
                            <span>&#x5350;</span><span class="dev-main">GOD'S GRACE</span><span>&#x5350;</span>
                        </span>
                        <span class="dev-win">WIN WIN</span>
                    </span>
                </div>
            </div>
            <div class="header-meta-right">
                <span class="header-cell">
                    <span class="cell-label">Cell :</span> 99941 82275<br>
                    98844 83426
                </span>
            </div>
        </div>

        <div class="header-main">
            <div class="logo-wrap">
                <%
                String logoPath = application.getRealPath("/logistics/transportBill/logo.png");
                java.io.File logoFile = new java.io.File(logoPath);
                if (logoFile.exists()) { %>
                    <img src="<%=contextPath%>/logistics/transportBill/logo.png" alt="Logo">
                <% } else { %>
                    <div class="no-logo">LOGO</div>
                <% } %>
            </div>
            <div class="header-content">
                <div class="co-block">
                    <div class="co-name"><%=companyName%></div>
                    <div class="co-sub"><%=co.get(1)%></div>
                </div>
            </div>
        </div>
        <div class="header-corner-decor"><div class="ct1"></div><div class="ct2"></div></div>
    </div>
    <div class="header-divider"></div>

    <div class="title-bar"><span class="copy-part"><%=copyTitleHeading%></span><span class="risk-part"> | BOOKED AT OWNER'S RISK</span></div>

    <div class="box">
        <div class="row info-row">
            <div class="cell w33">
                <div class="inline-pair">
                    <span class="lbl">LR No :</span>
                    <span class="val"><%=lrNo%></span>
                </div>
            </div>
            <div class="cell w33">
                <div class="inline-pair">
                    <span class="lbl">Date :</span>
                    <span class="val"><%=lrDate%></span>
                </div>
            </div>
            <div class="cell w33">
                <div class="inline-pair">
                    <span class="lbl">Truck No :</span>
                    <span class="val"><%=truckNo%></span>
                </div>
            </div>
        </div>
        <div class="row route-row">
            <div class="cell w50">
                <div class="inline-pair">
                    <span class="lbl">From :</span>
                    <span class="val"><%=fromLocation%></span>
                </div>
            </div>
            <div class="cell w50">
                <div class="inline-pair">
                    <span class="lbl">To :</span>
                    <span class="val"><%=toLocation%></span>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="cell w50">
                <div class="party-block">
                    <span class="party-lbl">Consignor Name &amp; Address :</span>
                    <span class="party-name"><%=customerName%></span>
                    <span class="party-addr"><%= (customerAddress == null ? "" : customerAddress.replace("\r", " ").replace("\n", " ")) %><% if (phone != null && !phone.trim().isEmpty()) { %> / <%=phone%><% } %></span>
                </div>
            </div>
            <div class="cell w50">
                <div class="party-block">
                    <span class="party-lbl">Consignee Name &amp; Address :</span>
                    <span class="party-name"><%=consigneeName%></span>
                    <span class="party-addr"><%= (consigneeAddress == null ? "" : consigneeAddress.replace("\r", " ").replace("\n", " ")) %></span>
                </div>
            </div>
        </div>
    </div>

    <div class="body-with-gst">
        <div class="body-main">
    <table class="lr-table">
        <thead>
            <tr>
                <th style="width:12%;">No of Articles</th>
                <th style="width:46%;">Description (Said to contain)</th>
                <th style="width:42%;">Mode of Payment</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><%=noOfArticles%></td>
                <td><%=descriptionText%></td>
                <td>
                    <div class="mode-grid">
                        <% if (toBeBilledInChennai) { %>
                        <div class="mode-item"><span class="tick-mark">&#10003;</span> To be billed in Chennai</div>
                        <% } %>
                        <div class="mode-item">Freight Amount Rs: <%=freightAmount%></div>
                        <div class="mode-item">To Pay Amount Rs: <%=toPayAmount%></div>
                        <div class="mode-item">Paid Amount Rs: <%=paidAmount%></div>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>

    <div class="box">
        <table class="detail-grid">
            <colgroup>
                <col style="width:50%;">
                <col style="width:25%;">
                <col style="width:25%;">
            </colgroup>
            <tr>
                <td><span class="detail-lbl">D.C No</span><div class="detail-val"><%=dcNo%></div></td>
                <td colspan="2" class="detail-split-cell">
                    <div class="detail-half-row">
                        <div class="detail-half-col">
                            <span class="detail-lbl">Date</span>
                            <div class="detail-val"><%=invDate%></div>
                        </div>
                        <div class="detail-half-col">
                            <span class="detail-lbl">Weight (M.T)</span>
                            <div class="detail-val"><%=weightMt%></div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td rowspan="3"><span class="detail-lbl">Inv No</span><div class="detail-val inv-wrap"><%=invNoDisplay%></div></td>
                <td colspan="2"><span class="detail-lbl">Declared Value Rs</span><div class="detail-val"><%=declaredValueDisplay%></div></td>
            </tr>
            <tr>
                <td colspan="2"><span class="detail-lbl">PNL Seal No</span><div class="detail-val"><%=pnlSealNo%></div></td>
            </tr>
            <tr>
                <td><span class="detail-lbl">Material Received Date</span><div class="detail-val"><%=materialReceivedDate%></div></td>
                <td rowspan="3" class="qr-cell">
                    <canvas id="companyQrCanvas" width="108" height="108"></canvas>
                    <img id="companyQrFallback" style="display:none;" src="https://api.qrserver.com/v1/create-qr-code/?size=108x108&amp;margin=0&amp;data=<%=qrDataEncoded%>" alt="Company QR">
                </td>
            </tr>
            <tr>
                <td><span class="detail-lbl">Type of Vehicle</span><div class="detail-val"><%=vehicleType%></div></td>
                <td><span class="detail-lbl">Driver Name</span><div class="detail-val"><%=driverName%></div></td>
            </tr>
            <tr>
                <td class="deliver-cell">
                    <div class="deliver-options-list">
                        <div class="deliver-opt-item"><span class="tick-mark"><%= isDoorDelivery ? "&#10003;" : "" %></span>Door Delivery</div>
                        <div class="deliver-opt-item"><span class="tick-mark"><%= isUnloadedByParty ? "&#10003;" : "" %></span>Unloading by Party</div>
                        <div class="deliver-opt-item"><span class="tick-mark"><%= isByTransporter ? "&#10003;" : "" %></span>By Transporter</div>
                    </div>
                </td>
                <td><span class="detail-lbl">D.L No</span><div class="detail-val"><%=pnlNo%></div></td>
            </tr>
        </table>
    </div>
        </div>
        <div class="gst-vertical-strip">
            <div class="gst-vertical-text">GST PAID BY SERVICE RECEIVER BY REVERSE CHARGE MECHANISM</div>
        </div>
    </div>

    <div class="print-spacer"></div>

    <div class="footer-sign">
        <div class="footer-grid">
            <div class="recv-box">
                <div class="recv-title">Receiver's Sign. Seal and Unloading Date :</div>
                <div class="recv-oval"></div>
            </div>
            <div class="clerk-box">
                <div class="sign-line">Signature of Booking Clerk and Date</div>
            </div>
        </div>
    </div>

    <div class="footer-bottom">
        <div class="footer-bottom-left">Powered by JASXBILL - 8667214152</div>
        <div class="footer-bottom-right">Signature to Terms &amp; Condition of carriage Printed Overleaf</div>
    </div>
</div>

<div class="page page-terms">
    <h1 class="terms-title">Terms &amp; Condition for Goods Receipt – Owner's Risk</h1>
    <div class="terms-body">
        <p>Nature, condition and value of the consignment are unknown to the "<%=companyName.toUpperCase()%>" (hereinafter called the company). The company carries the goods as packed at owner's risk.</p>
        <p>The company does not guarantee delivery within any specified time and the company shall not be liable for any delay in transport delivery not due to any negligence or default of the carrier or his agents or employees.</p>
        <p>In the event of any interruption of through communication of the booked or customary route due to causes beyond the control of the company, it will be within the discretion of their company to cause the traffic to be carried by the next shortest open route but only on the conditions applying to the booked or customer route in respect of the company's liability and of freight and forwarding note held in respect of the consignment being equally operative over the route by which the consignment is carried notwithstanding change of route or of carrier for the transport for reasons of the company.</p>
        <p>The company shall not be liable for any loss or damage due to pilferage, theft, weather conditions, strikes, riots, disturbances, fire, explosion, accidents, leakages and breakages, provided however all reasonable precautions are taken to provide against such contingencies.</p>
        <p>Delivery of goods should be taken from company's godown within a week of their arrival, failing which a godown rent of 10 NP per kg per day or part thereof per day will be charged. The consignor or consignee or other holder of the receipt interested shall ascertain the date and time of arrival from the company.</p>
        <p>The company undertakes to and shall deliver the goods in the like order and condition as received subject to any deterioration in the condition of goods resulting from natural causes like order and conditions as received subject to any deterioration in the condition of goods resulting from natural causes like affect of temperature, weather conditions to the consignee or to his order or his assigns on the relative receipt being surrendered to the company duly discharged by the bank through which receipt has negotiated or the holder of receipt producing a letter from such bank authorizing delivery of the goods and only the holder of the receipt entered to delivery as aforesaid shall have right of recourse against the company for all claims arising thereon.</p>
        <p>The company has the right to re-weigh, re-measure, reclassify and recalculate the rates at the rates at the place of destination before delivery for reasons assigned in writing and only in the presence of the holder of receipt or his duly authorized agent and to collect any commission or undercharge.</p>
        <p>The company reserves the right to refuse goods for transport without assigning any reason.</p>
        <p>The company shall have the right to dispose of perishables lying undelivered after 24 hours of arrival without any notice and other goods after 30 days of arrival after due notice in writing to the consignor or holder interested and the claimant shall be entitled to the proceeds less freight and demurrage.</p>
        <p>The company shall not be responsible if the goods are detained, seized or confiscated by Government authorities.</p>
        <p>The company shall be primarily liable to pay the transport charges and all other incidental charges if any at the Head Office of the Company in Chennai or at any agreed place.</p>
        <p>The company shall have the right to entrust the goods of any other lorry or services for transport. In the event of the goods being so trusted by the company to another carrier, the other carrier shall, as between the consignor and the company, be deemed to be the company, be deemed to be the company agent, so that the company shall, notwithstanding the delivery of the goods to the other carrier, continue to be responsible for the goods and for due delivery at the destination.</p>
        <p>No enquiry will be entertained relating to any consignment after the expiry of 30 days from the day of delivery.</p>
        <p>No suit shall lie against the company in respect of any consignment without a claim made in writing at the head office and preferred within 30 days, from the date of booking or from the date of arrival at destination, by the party concerned.</p>
        <p>Where a Bank has agreed to accept this Lorry Receipt as a document of title to the goods hereby carried, and has become interested as pledgee or assignee or endorsee of the Lorry Receipt whether before or after the entrustment of the goods to the Company for carriage, the company hereby agrees in consideration of the Bank concerned as if the Bank were a party to the contract herein contained with the right of recourse against the company to the extent of the Bank's interest in the security as such, as insurers in terms of the provisions of the Carriers Act III of 1855 against any and all risk of physical loss or damage under any circumstance whatsoever, any to indemnify and pay the Bank if the extent of loss sustained, without reference to the consignor or the consignee or the owner of the goods carried, notwithstanding the company's right to immunity if any from liability for such loss or damage on any ground whatsoever against the consignor, consignee or owner under any contract between them and the Bank shall have the right to demand, sue and recover its claim direct from the company.</p>
        <p>The Court, Chennai City alone shall have jurisdiction in respect of all claims and matters arising out of or in respect of this goods receipt.</p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/qrcode@1.5.3/build/qrcode.min.js"></script>
<script>
var companyQrText = "<%=qrContentJs%>";

function startPrint() { window.print(); }

function showQrFallback() {
    var canvas = document.getElementById('companyQrCanvas');
    var fallback = document.getElementById('companyQrFallback');
    if (canvas) canvas.style.display = 'none';
    if (fallback) fallback.style.display = 'block';
    startPrint();
}

window.onload = function() {
    var canvas = document.getElementById('companyQrCanvas');
    if (canvas && typeof QRCode !== 'undefined') {
        QRCode.toCanvas(canvas, companyQrText, { width: 108, margin: 1 }, function(err) {
            if (err) showQrFallback();
            else startPrint();
        });
    } else {
        showQrFallback();
    }
};
window.onafterprint = function() { window.close(); };
</script>
</body>
</html>
