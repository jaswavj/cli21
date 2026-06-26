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
        color:#0b2f63;
        white-space:nowrap;
    }
    .header-meta-right { text-align:right; }
    .header-cell {
        display:inline-block;
        text-align:right;
        line-height:1.15;
        white-space:normal;
        color:#0b2f63;
    }
    .header-cell .cell-label { color:#0b2f63; }
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
    .dev-top { display:inline-flex; align-items:center; gap:3px; }
    .dev-main { font-weight:800; letter-spacing:0.2px; color:#0b2f63; }
    .dev-win { font-weight:800; letter-spacing:0.2px; font-size:10px; margin-left:26px; color:#0b2f63; }
    .header-divider { display:none; height:0; margin:0; border:0; }

    .title-bar {
        border:1px solid #666;
        text-align:center;
        font-weight:700;
        color:#0b2f63;
        padding:4px;
        margin-bottom:0;
        font-size:12px;
        text-transform:uppercase;
        letter-spacing:0.5px;
    }
    .copy-part { color:#8d1f1f; }
    .risk-part { color:#0b2f63; }
    .header-divider + .title-bar { margin-top:-1px; }

    .box { border:1px solid #000; margin-bottom:0; }
    .top-box { display:flex; border:1px solid #000; margin-bottom:0; }
    .top-box + .box { border-top:0; }
    .top-left { width:58%; border-right:1px solid #000; }
    .top-right { width:42%; }
    .top-cell { border-bottom:1px solid #000; padding:7px 9px; }
    .top-left .top-cell:last-child, .top-right .top-cell:last-child { border-bottom:none; }
    .top-right-row { display:flex; border-bottom:1px solid #000; }
    .top-right-row:last-child { border-bottom:none; }
    .top-right-row .lbl-cell { width:42%; border-right:1px solid #000; padding:8px 10px; font-size:12px; text-transform:uppercase; color:#0b2f63; font-weight:700; line-height:1.25; }
    .top-right-row .val-cell { width:58%; padding:8px 10px; font-size:15px; font-weight:700; line-height:1.25; color:#0b2f63; }
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

    .w40 { width:40%; } .w60 { width:60%; } .w25 { width:25%; } .w20 { width:20%; } .w15 { width:15%; } .w35 { width:35%; } .w50 { width:50%; }

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

    .footer-sign { margin-top:0; border:1px solid #000; border-top:0; padding:10px; min-height:116px; }
    .footer-grid { display:flex; gap:10px; height:100%; }
    .recv-box { width:60%; border-right:1px solid #000; padding-right:10px; }
    .recv-title { color:#8d1f1f; font-weight:700; text-transform:uppercase; font-size:12px; margin-bottom:8px; }
    .recv-oval {
        height:62px;
        width:94%;
        margin:0 auto;
        border:2.5px solid #a63a2f;
        border-radius:50%;
    }
    .clerk-box { width:40%; display:flex; flex-direction:column; justify-content:flex-end; }
    .sign-line { border-top:1px solid #000; text-align:center; font-size:11px; font-weight:700; padding-top:4px; }

    .print-note { text-align:center; font-size:11px; color:#666; margin-top:6px; }
    .powered-by {
        text-align: right;
        font-size: 10px;
        color: #777;
        font-weight: 600;
        margin-top: 2px;
        padding-right: 2px;
        letter-spacing: 0.2px;
        opacity: 0.8;
    }
    .print-spacer { display:none; }

    /* Join adjacent section borders as one continuous form */
    .title-bar + .top-box,
    .box + table.lr-table,
    table.lr-table + .box,
    table.lr-table + .footer-sign {
        margin-top: -1px;
    }

    .no-print { background:#343a40; color:#fff; padding:10px 16px; display:flex; gap:10px; align-items:center; }
    .no-print button { border:none; border-radius:6px; padding:7px 14px; font-size:13px; cursor:pointer; }

    @media print {
        @page { size: A4; margin: 0; }
        .no-print { display:none !important; }
        html, body {
            width: 210mm;
            height: 297mm;
            margin: 0;
            padding: 0;
            overflow: hidden;
            print-color-adjust: exact;
            -webkit-print-color-adjust: exact;
        }
        .page {
            margin: 0;
            min-height: 297mm;
            height: 297mm;
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

<div class="page">
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

    <div class="top-box">
        <div class="top-left">
            <div class="top-cell">
                <div class="inline-pair">
                    <span class="lbl">Consignor Name</span>
                    <span class="val"><%=customerName%></span>
                </div>
                <div class="inline-pair">
                    <span class="lbl">Address / Phone</span>
                    <span class="val"><%= (customerAddress == null ? "" : customerAddress.replace("\r", " ").replace("\n", " ")) %><% if (phone != null && !phone.trim().isEmpty()) { %> / <%=phone%><% } %></span>
                </div>
            </div>
        </div>
        <div class="top-right">
            <div class="top-right-row">
                <div class="lbl-cell">LR No</div>
                <div class="val-cell"><%=lrNo%></div>
            </div>
            <div class="top-right-row">
                <div class="lbl-cell">Date</div>
                <div class="val-cell"><%=lrDate%></div>
            </div>
            <div class="top-right-row">
                <div class="lbl-cell">Truck No</div>
                <div class="val-cell"><%=truckNo%></div>
            </div>
            <div class="top-right-row">
                <div class="lbl-cell">From</div>
                <div class="val-cell"><%=fromLocation%></div>
            </div>
            <div class="top-right-row">
                <div class="lbl-cell">To</div>
                <div class="val-cell"><%=toLocation%></div>
            </div>
        </div>
    </div>

    <div class="box">
        <div class="row">
            <div class="cell w100" style="width:100%;">
                <div class="inline-pair">
                    <span class="lbl">Consignee Name</span>
                    <span class="val"><%=consigneeName%></span>
                </div>
                <div class="inline-pair">
                    <span class="lbl">Consignee Address</span>
                    <span class="val"><%= (consigneeAddress == null ? "" : consigneeAddress.replace("\r", " ").replace("\n", " ")) %></span>
                </div>
            </div>
        </div>
    </div>

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
                        <div class="mode-item"> <%=modePayment1%></div>
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
            <tr>
                <td style="width:30%;"><span class="detail-lbl">In Words</span><div class="detail-val"><%=amountInWords%></div></td>
                <td style="width:30%;"><span class="detail-lbl">D.C No</span><div class="detail-val"><%=dcNo%></div></td>
                <td style="width:20%;"><span class="detail-lbl">Date</span><div class="detail-val"><%=invDate%></div></td>
                <td style="width:20%;"><span class="detail-lbl">Weight (M.T)</span><div class="detail-val"><%=weightMt%></div></td>
            </tr>
            <tr>
                <td colspan="2"><span class="detail-lbl">Declared Value Rs</span><div class="detail-val"><%=declaredValueRs%></div></td>
                <td colspan="2"><span class="detail-lbl">PNL Seal No</span><div class="detail-val"><%=pnlSealNo%></div></td>
            </tr>
            <tr>
                <td colspan="2" rowspan="2"><span class="detail-lbl">Inv No</span><div class="detail-val inv-wrap"><%=invNoDisplay%></div></td>
                <td colspan="2"><span class="detail-lbl">Material Received Date</span><div class="detail-val"><%=materialReceivedDate%></div></td>
            </tr>
            <tr>
                <td colspan="2"><span class="detail-lbl">D.L No</span><div class="detail-val"><%=pnlNo%></div></td>
            </tr>
            <tr>
                <td colspan="2"><span class="detail-lbl">Driver Name</span><div class="detail-val"><%=driverName%></div></td>
                <td colspan="2">
                    <span class="detail-lbl">Type of Vehicle</span>
                    <div class="detail-val"><%=vehicleType%></div>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="padding:0;">
                    <div class="deliver-in-grid" style="margin-top:0; border:0;">
                        <div class="deliver-opt"><span class="tick-mark"><%= isDoorDelivery ? "&#10003;" : "" %></span>Door Delivery</div>
                        <div class="deliver-opt"><span class="tick-mark"><%= isUnloadedByParty ? "&#10003;" : "" %></span>Unloading by Party</div>
                        <div class="deliver-opt"><span class="tick-mark"><%= isByTransporter ? "&#10003;" : "" %></span>By Transporter</div>
                    </div>
                </td>
            </tr>
        </table>
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

    <div class="powered-by">Powered by JASXBILL - 8667214152</div>
</div>

<script>
window.onload = function() { window.print(); };
window.onafterprint = function() { window.close(); };
</script>
</body>
</html>
