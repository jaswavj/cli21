<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}

String billIdParam = request.getParameter("billId");
if (billIdParam == null || billIdParam.trim().isEmpty()) {
    out.print("<h3 style='padding:40px;'>Invalid bill ID.</h3>"); return;
}

int billId = 0;
try { billId = Integer.parseInt(billIdParam.trim()); } catch (Exception e) {
    out.print("<h3 style='padding:40px;'>Invalid bill ID.</h3>"); return;
}

Vector result = bill.getTransportBillForPrint(billId);
if (result.size() < 4) {
    out.print("<h3 style='padding:40px;'>Bill not found.</h3>"); return;
}

// [0] header: invoice_no, bill_date, po_no, sac_code, grand_total, paid_amount,
//             balance, payment_mode, credit_days, due_date,
//             cust_name, cust_address, cust_phone, cust_gstin
Vector hdr    = (Vector) result.get(0);
// [1] lrList: bill_lr_id, logistics_id, lr_no, lr_date, notes, lr_total
Vector lrList = (Vector) result.get(1);
// [2] parts:  bill_lr_id, lr_no, lr_date, particular, qty, rate_wt, amount
Vector parts  = (Vector) result.get(2);
// [3] company: shop_name, address, gstin, bank_details
Vector co     = (Vector) result.get(3);

// Helper: safe string get
java.text.NumberFormat nf = java.text.NumberFormat.getInstance(new java.util.Locale("en","IN"));
nf.setMinimumFractionDigits(2); nf.setMaximumFractionDigits(2);

String contextPath = request.getContextPath();
String source = request.getParameter("source");
String referer = request.getHeader("Referer");
String copyLabel = "Original";
if (source != null && source.equalsIgnoreCase("orderList")) {
    copyLabel = "Original";
} else if (source == null || source.trim().isEmpty()) {
    if (referer != null && referer.contains("/logistics/orderList/")) {
        copyLabel = "Original";
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Transportation Bill — <%= hdr.get(0) %></title>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800;900&display=swap');

    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: #000; background: #fff; line-height: 1.35; }

    .page { width: 210mm; margin: 0 auto; padding: 9mm 11mm; }

    /* ── Header ── */
    .print-header {
        font-family: 'Poppins', Arial, Helvetica, sans-serif;
        background: linear-gradient(135deg, #030d24 0%, #0a1d47 55%, #143272 100%);
        border-radius: 0;
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
        transform-origin: center center;
        box-shadow: 0 0 6px rgba(46,125,50,0.7), 0 0 2px rgba(46,125,50,0.9);
        pointer-events: none;
        z-index: 3;
    }
    /* ── Green corner triangles (top-right) ── */
    .header-corner-decor {
        position: absolute;
        top: 0;
        right: 0;
        height: 100%;
        width: 150px;
        pointer-events: none;
        z-index: 1;
    }
    .header-corner-decor .ct1 {
        position: absolute;
        top: 0;
        right: 0;
        height: 100%;
        width: 150px;
        background: #1a5e1a;
        clip-path: polygon(100% 0%, 100% 100%, 50% 100%);
    }
    .header-corner-decor .ct2 {
        position: absolute;
        top: 0;
        right: 12px;
        height: 100%;
        width: 115px;
        background: #2e7d32;
        clip-path: polygon(100% 0%, 100% 100%, 65% 100%);
    }
    .header-main {
        display: flex;
        align-items: center;
        gap: 0;
        width: 100%;
        position: relative;
        overflow: hidden;
        z-index: 2;
    }
    
    .logo-wrap {
        width: 20%;
        display: flex;
        align-items: center;
        justify-content: center;
        padding-right: 12px;
    }
    .logo-wrap img {
        width: 100%;
        max-width: 146px;
        height: auto;
        object-fit: contain;
        border-radius: 2px;
        filter: brightness(0) invert(1);
    }
    .logo-wrap .no-logo {
        width: 100%; max-width: 146px; aspect-ratio: 1.7;
        display:flex; align-items:center; justify-content:center;
        background: rgba(255,255,255,.15); border: 1.5px solid rgba(255,255,255,.3);
        font-size:11px; color:rgba(255,255,255,.7); border-radius:4px;
    }
    .header-content {
        flex: 1;
        width: 80%;
        display: flex;
        align-items: center;
        gap: 0;
        padding-left: 20px;
    }
    .co-block {
        flex: 1;
        min-width: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    .co-name {
        font-size: 28px; font-weight: 800; letter-spacing: 2px;
        text-transform: uppercase; color: #fff;
        text-shadow: 0 1px 4px rgba(0,0,0,.35);
        line-height: 1.05;
        word-break: break-word;
        text-align: center;
    }
    .co-sub  {
        font-size: 13px;
        color: #ffffff;
        margin-top: 2px;
        letter-spacing: 1px;
        white-space: pre-wrap;
        text-align: center;
        line-height: 1.2;
    }
    .co-gstin-row {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: flex-start;
        letter-spacing: .7px;
        width: 100%;
        padding: 2px 8px;
        margin-bottom: 1px;
        gap: 12px;
    }
    .co-devotion {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        flex-wrap: nowrap;
        white-space: nowrap;
        flex-shrink: 0;
        min-width: 0;
        margin-bottom: 2px;
    }
    .co-gstin-right {
        font-size: 10px;
        font-weight: 600;
        color: #fff;
        letter-spacing: .25px;
        white-space: nowrap;
        flex-shrink: 0;
    }
    .co-gstin-pill {
        background: rgba(255,255,255,.15);
        border: 1px solid rgba(255,255,255,.35);
        border-radius: 4px; padding: 2px 8px;
        font-size: 10px; font-weight: 700; color: #fff;
        letter-spacing: 0.3px;
    }
    .dev-soolam-wrap {
        width: 24px;
        height: 42px;
        display: inline-flex;
        align-items: flex-start;
        justify-content: center;
        overflow: hidden;
        margin-right: 4px;
        flex-shrink: 0;
    }
    .dev-soolam {
        width: 34px;
        height: 34px;
        display: inline-block;
        vertical-align: middle;
        object-fit: cover;
        object-position: center 8%;
        transform: scale(1.9);
        transform-origin: center top;
    }
    .dev-swastik {
        color: #2d8f2d;
        font-size: 12px;
        line-height: 1;
        font-weight: 700;
    }
    .dev-text {
        color: #ffffff;
        font-size: 11px;
        font-weight: 500;
        letter-spacing: .7px;
        line-height: 1;
        white-space: nowrap;
    }
    .dev-win {
        color: #ffffff;
        font-size: 11px;
        font-weight: 500;
        letter-spacing: .7px;
        line-height: 1;
        white-space: nowrap;
    }
    .header-divider {
        height: 3px;
        background: linear-gradient(90deg, #f5a623 0%, #f0c040 50%, #f5a623 100%);
        margin-bottom: 10px;
        border-radius: 0 0 3px 3px;
    }

    /* ── Title bar ── */
    .title-bar {
        position: relative;
        text-align: center;
        font-size: 16px;
        font-weight: 900;
        background: #f0f4ff; border: 1px solid #b8c8f0;
        padding: 7px 8px;
        margin: 0 0 10px;
        letter-spacing: 0;
        text-transform: uppercase; color: #0a1f44;
        width: 100%;
    }
    .title-copy-tag {
        position: absolute;
        right: 8px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 12px;
        font-style: italic;
        font-weight: 600;
        color: #555;
        text-transform: none;
    }

    /* ── Two-column info section ── */
    .info-grid { display: flex; gap: 0; border: 1px solid #000; margin-bottom: 0; }
    .info-left { flex: 1; padding: 7px 10px; border-right: 1px solid #000; }
    .info-right { width: 260px; padding: 7px 10px; }
    .info-label { font-size: 12px; color: #555; }
    .info-val { font-size: 15px; font-weight: 600; }
    .info-row { margin-bottom: 3px; }
    .billed-title { font-size: 12px; font-weight: 700; text-transform: uppercase; margin-bottom: 4px; border-bottom: 1px solid #ddd; padding-bottom: 2px; }
    .inv-row { display: flex; gap: 4px; margin-bottom: 3px; }
    .inv-lbl { font-size: 12px; color: #555; min-width: 90px; }
    .inv-val { font-size: 13px; font-weight: 700; }

    /* ── GST notice ── */
    .gst-notice { border: 1px solid #000; border-top: none; padding: 4px 8px; font-size: 12px; font-weight: 700; text-align: center; margin-bottom: 0; }

    /* ── Bill table ── */
    .bill-table { width: 100%; border-collapse: collapse; margin-bottom: 0; }
    .bill-table th, .bill-table td { border: 1px solid #000; padding: 5px 7px; vertical-align: top; }
    .bill-table thead th { background: #f5f5f5; font-size: 13px; font-weight: 700; text-align: center; white-space: nowrap; }
    .bill-table tbody td { border-top: none; border-bottom: none; }
    .bill-table td { font-size: 13px; }
    .td-lr-no  { font-weight: 700; white-space: pre-line; line-height: 1.2; text-align: center; }
    .td-date   { white-space: nowrap; }
    .td-amount { text-align: right; font-weight: 600; white-space: nowrap; }
    .td-qty    { text-align: center; }
    .td-rate   { text-align: center; }
    .lr-note-row td { font-size: 12px; color: #555; padding: 1px 6px 3px; border-top: none; }
    .lr-note-text { font-style: italic; }
    .bill-table tbody .total-row td  {
        font-weight: 700;
        font-size: 14px;
        background: #f9f9f9;
        border-top: 2px solid #000 !important;
        border-bottom: 1px solid #000 !important;
    }
    .bill-table tbody .subtotal-row td {
        font-weight: 600;
        font-size: 13px;
        background: #fafafa;
        color: #333;
        border-top: 1px solid #000 !important;
        border-bottom: 1px solid #000 !important;
    }
    .total-lr-count { font-size: 12px; font-weight: 400; color: #555; margin-top: 2px; }

    /* ── Footer ── */
    .footer-row { display: flex; margin-top: 0; border: 1px solid #000; }
    .footer-bank { flex: 0 0 60%; width: 60%; padding: 12px 10px; border-right: 1px solid #000; }
    .footer-bank .fb-title { font-size: 12px; font-weight: 700; text-transform: uppercase; margin-bottom: 4px; }
    .footer-bank .fb-row { display: flex; gap: 4px; margin-bottom: 2px; }
    .footer-bank .fb-lbl { font-size: 12px; color: #444; min-width: 70px; }
    .footer-bank .fb-val { font-size: 12px; font-weight: 700; }
    .footer-sign { flex: 0 0 40%; width: 40%; padding: 12px 10px; text-align: center; }
    .footer-sign .sign-title { font-size: 13px; font-weight: 700; margin-bottom: 46px; }
    .footer-sign .sign-line { border-top: 1px solid #000; font-size: 12px; font-weight: 700; padding-top: 3px; }

    .words-row { border: 1px solid #000; border-top: none; padding: 6px 10px; font-size: 13px; font-weight: 600; margin-bottom: 0; }
    .print-spacer {
        display: none;
    }
    .print-note { text-align: center; font-size: 12px; color: #666; border: 1px solid #000; border-top: none; padding: 3px; margin-top: 0; }

    @media print {
        @page { size: A4; margin: 0; }
        html, body {
            margin: 0;
            padding: 0;
            print-color-adjust: exact;
            -webkit-print-color-adjust: exact;
        }
        .no-print { display: none !important; }
        .page {
            width: 100%;
            margin: 0;
            padding: 0 10mm 3mm;
            min-height: calc(297mm - 3mm);
            display: flex;
            flex-direction: column;
        }
        .print-header,
        .header-divider {
            margin-left: -10mm;
            margin-right: -10mm;
        }
        .print-spacer {
            display: block;
            flex: 1;
            border-left: 1px solid #000;
            border-right: 1px solid #000;
        }
        .footer-row { margin-top: 0; }
    }
</style>
</head>
<body>

<!-- Print Button (hidden when printing) -->
<div class="no-print" style="padding:10px 20px;background:#343a40;display:flex;align-items:center;gap:12px;">
    <span style="color:#fff;font-weight:600;font-size:14px;">Transportation Bill — <%= hdr.get(0) %></span>
    <button onclick="window.print()" style="background:#198754;color:#fff;border:none;border-radius:6px;padding:7px 18px;font-size:13px;font-weight:600;cursor:pointer;">
        &#128424; Print
    </button>
    <button onclick="window.close()" style="background:#6c757d;color:#fff;border:none;border-radius:6px;padding:7px 14px;font-size:13px;cursor:pointer;">
        &#10005; Close
    </button>
</div>

<div class="page">

    <!-- ── Header ── -->
    <div class="print-header">
        <div class="header-main">
            <div class="logo-wrap">
                <%
                String logoPath = application.getRealPath("/logistics/transportBill/logo.png");
                java.io.File logoFile = new java.io.File(logoPath);
                if (logoFile.exists()) { %>
                    <img src="<%= contextPath %>/logistics/transportBill/logo.png" alt="Logo">
                <% } else { %>
                    <div class="no-logo">LOGO</div>
                <% } %>
            </div>
            <div class="header-content">
                <div class="co-block">
                    <div class="co-devotion">
                        <span class="dev-soolam-wrap">
                            <img class="dev-soolam" src="soolam2.png" alt="Soolam" onerror="this.onerror=null;this.src='<%= contextPath %>/logistics/transportBill/soolam1.png';">
                        </span>
                        <span class="dev-swastik">&#x5350;</span>
                        <span class="dev-text">GOD'S GRACE</span>
                        <span class="dev-swastik">&#x5350;</span>
                        <span class="dev-win">WIN WIN &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        <% if (!co.get(2).toString().isEmpty()) { %>
                        <span class="co-gstin-right" style="margin-left:14px;">GSTIN: <%= co.get(2) %></span>
                        <% } %>
                    </div>
                    <div class="co-name"><%= co.get(0) %></div>
                    <div class="co-sub"><%= co.get(1) %></div>
                </div>
            </div>
        </div>
        <div class="header-corner-decor">
            <div class="ct1"></div>
            <div class="ct2"></div>
        </div>
    </div>
    <div class="header-divider"></div>
    <!-- ── Title ── -->
    <div class="title-bar">
        Transportation Bill
        <span class="title-copy-tag"><%= copyLabel %></span>
    </div>

    <!-- ── Info grid ── -->
    <div class="info-grid">
        <!-- Left: Billed To -->
        <div class="info-left">
            <div class="billed-title">Details of Receiver (Billed to),</div>
            <div class="info-val" style="font-size:14px;"><%= hdr.get(10) %></div>
            <% if (!hdr.get(11).toString().isEmpty()) { %>
            <div style="font-size:12px;margin-top:2px;white-space:pre-wrap;"><%= hdr.get(11) %></div>
            <% } %>
            <% if (!hdr.get(12).toString().isEmpty()) { %>
            <div style="font-size:12px;">Ph: <%= hdr.get(12) %></div>
            <% } %>
            <% if (!hdr.get(13).toString().isEmpty()) { %>
            <div style="font-size:12px;font-weight:600;margin-top:3px;">GST NO: <%= hdr.get(13) %></div>
            <% } %>
        </div>
        <!-- Right: Invoice details -->
        <div class="info-right">
            <div class="inv-row">
                <span class="inv-lbl">Invoice No</span>
                <span class="inv-val">: <%= hdr.get(0) %></span>
            </div>
            <div class="inv-row">
                <span class="inv-lbl">Bill Date</span>
                <span class="inv-val">: <%= hdr.get(1) %></span>
            </div>
            <div class="inv-row">
                <span class="inv-lbl">PO No/Job No</span>
                <span class="inv-val">: <%= hdr.get(2).toString().isEmpty() ? "-" : hdr.get(2) %></span>
            </div>
            <div class="inv-row">
                <span class="inv-lbl">SAC Code</span>
                <span class="inv-val">: <%= hdr.get(3).toString().isEmpty() ? "-" : hdr.get(3) %></span>
            </div>
            <% String creditTerms = hdr.get(8).toString().trim(); %>
            <% if (!creditTerms.isEmpty() && !"0".equals(creditTerms)) { %>
            <div class="inv-row">
                <span class="inv-lbl">Terms of Payment</span>
                <span class="inv-val">: <%= creditTerms.matches("\\\\d+") ? (creditTerms + " Days") : creditTerms %></span>
            </div>
            <% } %>
        </div>
    </div>

    <!-- ── GST notice ── -->
    <div class="gst-notice">GST PAID BY SERVICE RECEIVER BY REVERSE CHARGE MECHANISM</div>

    <!-- ── Bill Table ── -->
    <table class="bill-table">
        <thead>
            <tr>
                <th style="width:80px;">LR No / Trip<br>Sheet No</th>
                <th style="width:70px;">Date</th>
                <th>Particulars</th>
                <th style="width:70px;">Qty /<br>Articles</th>
                <th style="width:70px;">Rate / Wt</th>
                <th style="width:80px;">Amount</th>
            </tr>
        </thead>
        <tbody>
        <%
        double runningTotal = 0;
        for (int li = 0; li < lrList.size(); li++) {
            Vector lr = (Vector) lrList.get(li);
            String billLrId  = lr.get(0).toString();  // 0 = bill_lr_id
            String lrNo      = lr.get(2).toString();  // 2 = lr_no
            String lrDate    = lr.get(3).toString();  // 3 = lr_date
            String lrNotes   = lr.get(4).toString();  // 4 = notes
            double lrTotal   = Double.parseDouble(lr.get(5).toString()); // 5 = lr_total
            runningTotal    += lrTotal;

            boolean firstRow = true;
            for (int pi = 0; pi < parts.size(); pi++) {
                Vector p = (Vector) parts.get(pi);
                if (!p.get(0).toString().equals(billLrId)) continue;
                String rowLrNo    = p.get(1).toString();
                String rowLrDate  = p.get(2).toString();  // lr_date from transport_bill_details
                String particular = p.get(3).toString();
                String qty        = p.get(4).toString();
                String rateWt     = p.get(5).toString();
                double amount     = Double.parseDouble(p.get(6).toString());
        %>
            <tr>
                <td class="td-lr-no"><%= rowLrNo.isEmpty() ? (firstRow ? lrNo : "") : rowLrNo %></td>
                <td class="td-date"><%= rowLrDate.isEmpty() ? (firstRow ? lrDate : "") : rowLrDate %></td>
                <td><%= particular %></td>
                <td class="td-qty"><%= qty %></td>
                <td class="td-rate"><%= rateWt %></td>
                <td class="td-amount"><%= amount > 0 ? nf.format(amount) : "" %></td>
            </tr>
        <%
                firstRow = false;
            }

            if (!lrNotes.isEmpty()) {
        %>
            <tr class="lr-note-row">
                <td></td>
                <td></td>
                <td class="lr-note-text">(Note: <%= lrNotes.replace("\r\n", "<br>").replace("\n", "<br>").replace("\r", "<br>") %>)</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        <%
            }

            if (lrList.size() > 1) {
        %>
            <tr class="subtotal-row">
                <td colspan="5" style="text-align:right;font-size:11px;padding-right:8px;">LR Sub-Total</td>
                <td class="td-amount"><%= nf.format(lrTotal) %></td>
            </tr>
        <%
            }
        }
        %>

        <!-- Grand Total row -->
        <tr class="total-row">
            <td colspan="5" style="text-align:right;padding-right:8px;">
                Total
                
            </td>
            <td class="td-amount"><%= nf.format(runningTotal) %></td>
        </tr>
        </tbody>
    </table>

    <!-- ── Amount in words ── -->
    <%
    // Simple number-to-words in Indian format
    long rupees = (long) runningTotal;
    String inWords = amountToWords(rupees) + " Only.";
    %>
    <div class="words-row">Rupees <%= inWords %></div>
    <div class="print-spacer"></div>

    <!-- ── Footer ── -->
    <div class="footer-row">
        <div class="footer-bank">
            <div class="fb-title">Bank Details</div>
            <% if (!co.get(3).toString().isEmpty()) { %>
            <div style="font-size:11px;font-weight:600;white-space:pre-wrap;"><%= co.get(3) %></div>
            <% } %>
        </div>
        <div class="footer-sign">
            <div class="sign-title">For <%= co.get(0) %></div>
            <div class="sign-line">Authorised Signatory</div>
        </div>
    </div>

    <div class="print-note">This is a Computer Generated Invoice. Signature Not Required</div>

    <div style="text-align:right;font-size:9px;color:#999;margin-top:3px;padding-right:4px;">
        Powered by JASXBILL &nbsp;|&nbsp; 8667214152
    </div>

</div><!-- /page -->

<%!
// ── Amount-to-words helper ─────────────────────────────────────
static final String[] ones = {"","One","Two","Three","Four","Five","Six","Seven","Eight","Nine",
    "Ten","Eleven","Twelve","Thirteen","Fourteen","Fifteen","Sixteen","Seventeen","Eighteen","Nineteen"};
static final String[] tens = {"","","Twenty","Thirty","Forty","Fifty","Sixty","Seventy","Eighty","Ninety"};

static String amountToWords(long n) {
    if (n == 0) return "Zero";
    if (n < 0)  return "Minus " + amountToWords(-n);
    StringBuilder sb = new StringBuilder();
    if (n >= 10000000) { sb.append(amountToWords(n / 10000000)).append(" Crore "); n %= 10000000; }
    if (n >= 100000)   { sb.append(amountToWords(n / 100000)).append(" Lakh ");   n %= 100000;   }
    if (n >= 1000)     { sb.append(amountToWords(n / 1000)).append(" Thousand "); n %= 1000;     }
    if (n >= 100)      { sb.append(ones[(int)(n / 100)]).append(" Hundred ");     n %= 100;      }
    if (n >= 20)       { sb.append(tens[(int)(n / 10)]); if (n % 10 != 0) sb.append(" "); n %= 10; }
    if (n > 0)         { sb.append(ones[(int) n]); }
    return sb.toString().trim();
}
%>
<script>
window.onload = function() {
    window.print();
};
window.onafterprint = function() {
    window.close();
};
</script>
</body>
</html>
