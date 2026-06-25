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
String invDate2 = lr.get(21).toString();
String declaredValueRs = lr.get(22).toString();
String pnlSealNo = lr.get(23).toString();
String materialReceivedDate = lr.get(24).toString();
String pnlNo = lr.get(25).toString();
String driverName = lr.get(26).toString();
String vehicleType = lr.get(27).toString();
String deliverIn = lr.get(28).toString();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>LR Copy - <%=lrNo%></title>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800;900&display=swap');
    * { box-sizing: border-box; }
    body { margin:0; font-family: Arial, Helvetica, sans-serif; color:#111; font-size:12px; }
    .page {
        width: 210mm;
        min-height: 297mm;
        height: 297mm;
        margin: 0 auto;
        padding: 10mm 12mm;
        display: flex;
        flex-direction: column;
    }

    .print-header {
        font-family: 'Poppins', Arial, Helvetica, sans-serif;
        background: linear-gradient(135deg, #030d24 0%, #0a1d47 55%, #143272 100%);
        padding: 9px 14px 11px;
        margin-bottom: 4px;
        border-top: 2px solid rgba(255,255,255,.8);
        position: relative;
        overflow: hidden;
    }
    .print-header::after {
        content: '';
        position: absolute;
        top: -14px;
        bottom: -14px;
        left: calc(20% + 10px);
        width: 4px;
        background: linear-gradient(to bottom, #2e7d32 0%, #66bb6a 50%, #2e7d32 100%);
        transform: rotate(-18deg);
        z-index: 3;
    }
    .header-corner-decor { position:absolute; top:0; right:0; height:100%; width:150px; z-index:1; }
    .header-corner-decor .ct1 { position:absolute; top:0; right:0; height:100%; width:150px; background:#1a5e1a; clip-path: polygon(100% 0%, 100% 100%, 50% 100%); }
    .header-corner-decor .ct2 { position:absolute; top:0; right:12px; height:100%; width:115px; background:#2e7d32; clip-path: polygon(100% 0%, 100% 100%, 65% 100%); }

    .header-main { display:flex; position:relative; z-index:2; }
    .logo-wrap { width:20%; display:flex; align-items:center; justify-content:center; padding-right:12px; }
    .logo-wrap img { width:100%; max-width:146px; filter: brightness(0) invert(1); }
    .logo-wrap .no-logo { width:100%; max-width:146px; aspect-ratio:1.7; display:flex; align-items:center; justify-content:center; color:#fff; border:1px solid rgba(255,255,255,.4); }
    .header-content { width:80%; display:flex; align-items:center; padding-left:20px; }
    .co-block { width:100%; text-align:center; color:#fff; }
    .co-name { font-size:28px; font-weight:800; letter-spacing:2px; text-transform:uppercase; line-height:1.05; }
    .co-sub { font-size:13px; margin-top:2px; white-space:pre-wrap; }
    .co-devotion { display:flex; justify-content:center; align-items:center; gap:6px; font-size:11px; margin-bottom:2px; white-space:nowrap; }
    .dev-soolam-wrap { width:24px; height:42px; display:inline-flex; align-items:flex-start; justify-content:center; overflow:hidden; margin-right:4px; }
    .dev-soolam { width:34px; height:34px; object-fit:cover; object-position:center 8%; transform:scale(1.9); transform-origin:center top; }
    .header-divider { height:3px; background: linear-gradient(90deg, #f5a623 0%, #f0c040 50%, #f5a623 100%); margin-bottom: 8px; }

    .title-bar { border:1px solid #b8c8f0; background:#f0f4ff; text-align:center; font-weight:900; color:#0a1f44; padding:7px; margin-bottom:10px; font-size:19px; }

    .box { border:1px solid #000; margin-bottom:6px; }
    .top-box { display:flex; border:1px solid #000; margin-bottom:6px; }
    .top-left { width:58%; border-right:1px solid #000; }
    .top-right { width:42%; }
    .top-cell { border-bottom:1px solid #000; padding:6px 8px; }
    .top-left .top-cell:last-child, .top-right .top-cell:last-child { border-bottom:none; }
    .top-right-row { display:flex; border-bottom:1px solid #000; }
    .top-right-row:last-child { border-bottom:none; }
    .top-right-row .lbl-cell { width:42%; border-right:1px solid #000; padding:8px 9px; font-size:11px; text-transform:uppercase; color:#555; font-weight:700; }
    .top-right-row .val-cell { width:58%; padding:8px 9px; font-size:14px; font-weight:700; }
    .row { display:flex; }
    .cell { border-right:1px solid #000; border-bottom:1px solid #000; padding:6px 8px; font-size:12px; }
    .cell:last-child { border-right:none; }
    .row:last-child .cell { border-bottom:none; }
    .lbl {
        font-size:11px;
        color:#555;
        text-transform:uppercase;
        font-weight:700;
        display:block;
        margin-bottom:4px;
        line-height:1.1;
    }
    .val {
        font-size:14px;
        font-weight:700;
        min-height:20px;
        white-space:pre-wrap;
        line-height:1.25;
        margin-top:1px;
    }

    .w40 { width:40%; } .w60 { width:60%; } .w25 { width:25%; } .w20 { width:20%; } .w15 { width:15%; } .w35 { width:35%; } .w50 { width:50%; }

    table.lr-table { width:100%; border-collapse:collapse; margin-top:4px; }
    .lr-table th, .lr-table td { border:1px solid #000; padding:6px 8px; font-size:12px; vertical-align:top; }
    .lr-table th { background:#f4f4f4; text-transform:uppercase; font-size:11px; }

    .mode-grid { display:grid; grid-template-columns: 1fr; gap:2px; }
    .mode-item { border:1px solid #777; padding:5px 7px; font-size:11px; }

    .footer-sign { margin-top:10px; border:1px solid #000; padding:12px; min-height:78px; }
    .print-note { text-align:center; font-size:11px; color:#666; margin-top:6px; }
    .powered-by {
        text-align: right;
        font-size: 10px;
        color: #7e8896;
        font-weight: 600;
        margin-top: 2px;
        padding-right: 2px;
        letter-spacing: 0.2px;
        opacity: 0.8;
        filter: blur(0.35px);
        -webkit-filter: blur(0.35px);
    }
    .print-spacer { flex: 1; min-height: 10mm; }

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
                    <div class="co-devotion">
                        <span class="dev-soolam-wrap">
                            <img class="dev-soolam" src="<%=contextPath%>/logistics/transportBill/soolam2.png" alt="Soolam" onerror="this.onerror=null;this.src='<%=contextPath%>/logistics/transportBill/soolam1.png';">
                        </span>
                        <span>&#x5350;</span><span>GOD'S GRACE</span><span>&#x5350;</span>
                        <% if (!co.get(2).toString().isEmpty()) { %>
                        <span style="margin-left:14px;font-weight:700;">GSTIN: <%=co.get(2)%></span>
                        <% } %>
                    </div>
                    <div class="co-name"><%=co.get(0)%></div>
                    <div class="co-sub"><%=co.get(1)%></div>
                </div>
            </div>
        </div>
        <div class="header-corner-decor"><div class="ct1"></div><div class="ct2"></div></div>
    </div>
    <div class="header-divider"></div>

    <div class="title-bar"><%=copyTitle%></div>

    <div class="top-box">
        <div class="top-left">
            <div class="top-cell">
                <div class="lbl">Consignor Name</div>
                <div class="val"><%=customerName%></div>
            </div>
            <div class="top-cell">
                <div class="lbl">Address / Phone</div>
                <div class="val"><%=customerAddress%><% if (phone != null && !phone.trim().isEmpty()) { %><br><%=phone%><% } %></div>
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
            <div class="cell w100" style="width:100%;"><div class="lbl">Consignee Name</div><div class="val"><%=consigneeName%></div></div>
        </div>
        <div class="row">
            <div class="cell w100" style="width:100%;"><div class="lbl">Consignee Address</div><div class="val"><%=consigneeAddress%></div></div>
        </div>
    </div>

    <table class="lr-table">
        <thead>
            <tr>
                <th style="width:12%;">No of Articles</th>
                <th style="width:38%;">Description (Said to contain)</th>
                <th style="width:12%;">Weight (M.T)</th>
                <th style="width:38%;">Mode of Payment</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><%=noOfArticles%></td>
                <td><%=descriptionText%></td>
                <td><%=weightMt%></td>
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

    <div class="box" style="margin-top:6px;">
        <div class="row">
            <div class="cell w25"><div class="lbl">DC No</div><div class="val"><%=dcNo%></div></div>
            <div class="cell w25"><div class="lbl">Inv Date</div><div class="val"><%=invDate%></div></div>
            <div class="cell w25"><div class="lbl">Inv No</div><div class="val"><%=invNo%></div></div>
            <div class="cell w25"><div class="lbl">Inv Date 2</div><div class="val"><%=invDate2%></div></div>
        </div>
        <div class="row">
            <div class="cell w25"><div class="lbl">Declared Value Rs</div><div class="val"><%=declaredValueRs%></div></div>
            <div class="cell w25"><div class="lbl">PNL Seal No</div><div class="val"><%=pnlSealNo%></div></div>
            <div class="cell w25"><div class="lbl">Material Received Date</div><div class="val"><%=materialReceivedDate%></div></div>
            <div class="cell w25"><div class="lbl">PNL No</div><div class="val"><%=pnlNo%></div></div>
        </div>
        <div class="row">
            <div class="cell w35"><div class="lbl">Driver Name</div><div class="val"><%=driverName%></div></div>
            <div class="cell w35"><div class="lbl">Type of Vehicle</div><div class="val"><%=vehicleType%></div></div>
            <div class="cell w30" style="width:30%;"><div class="lbl">Deliver In</div><div class="val"><%=deliverIn%></div></div>
        </div>
        <div class="row">
            <div class="cell" style="width:100%;"><div class="lbl">In Words</div><div class="val"><%=amountInWords%></div></div>
        </div>
    </div>

    <div class="print-spacer"></div>

    <div class="footer-sign">
        <div style="display:flex; justify-content:space-between; margin-top:36px;">
            <div style="width:45%; text-align:center; border-top:1px solid #000; padding-top:4px; font-size:12px; font-weight:700;">Receiver Sign, Seal and Unloading Date</div>
            <div style="width:45%; text-align:center; border-top:1px solid #000; padding-top:4px; font-size:12px; font-weight:700;">Signature of Booking Clerk and Date</div>
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
