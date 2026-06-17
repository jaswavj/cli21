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
// [2] parts:  bill_lr_id, lr_no, particular, qty, rate_wt, amount
Vector parts  = (Vector) result.get(2);
// [3] company: shop_name, address, gstin, bank_details
Vector co     = (Vector) result.get(3);

// Helper: safe string get
java.text.NumberFormat nf = java.text.NumberFormat.getInstance(new java.util.Locale("en","IN"));
nf.setMinimumFractionDigits(2); nf.setMaximumFractionDigits(2);

String contextPath = request.getContextPath();
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
    }
    .header-main {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    .logo-wrap img {
        width: 146px;
        height: 86px;
        object-fit: contain;
        border-radius: 2px;
        filter: brightness(0) invert(1);
    }
    .logo-wrap .no-logo {
        width: 146px; height: 86px; display:flex; align-items:center; justify-content:center;
        background: rgba(255,255,255,.15); border: 1.5px solid rgba(255,255,255,.3);
        font-size:11px; color:rgba(255,255,255,.7); border-radius:4px;
    }
    .co-block {
        flex: 1;
        min-width: 0;
    }
    .co-name {
        font-size: 31px; font-weight: 800; letter-spacing: .5px;
        text-transform: uppercase; color: #fff;
        text-shadow: 0 1px 4px rgba(0,0,0,.35);
        line-height: 1.05;
        word-break: break-word;
        text-align: center;
    }
    .co-sub  {
        font-size: 14px;
        color: #ffffff;
        margin-top: 4px;
        white-space: pre-wrap;
        text-align: center;
        line-height: 1.25;
    }
    .co-gstin-row {
        display: grid;
        grid-template-columns: auto 1fr auto;
        align-items: center;
        margin-bottom: 4px;
    }
    .co-devotion {
        grid-column: 1 / 3;
        display: flex;
        align-items: center;
        justify-content: flex-start;
        gap: 6px;
        padding-left: 290px;
    }
    .co-gstin-right {
        grid-column: 3;
        justify-self: end;
        font-size: 10px;
        font-weight: 600;
        color: #fff;
        letter-spacing: .15px;
        white-space: nowrap;
    }
    .co-gstin-pill {
        background: rgba(255,255,255,.15);
        border: 1px solid rgba(255,255,255,.35);
        border-radius: 4px; padding: 2px 8px;
        font-size: 10px; font-weight: 700; color: #fff;
        letter-spacing: 0.3px;
    }
    .dev-trident {
        width: 14px;
        height: 20px;
        display: inline-block;
        vertical-align: middle;
        margin-right: 2px;
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
        letter-spacing: 0;
        line-height: 1;
    }
    .dev-win {
        color: #ffffff;
        font-size: 11px;
        font-weight: 500;
        letter-spacing: 0;
        line-height: 1;
    }
    .header-divider {
        height: 3px;
        background: linear-gradient(90deg, #f5a623 0%, #f0c040 50%, #f5a623 100%);
        margin-bottom: 10px;
        border-radius: 0 0 3px 3px;
    }

    /* ── Title bar ── */
    .title-bar {
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
    .original-tag { text-align: right; font-size: 12px; font-style: italic; color: #555; margin-bottom: 4px; }

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
    .footer-bank { flex: 1; padding: 12px 10px; border-right: 1px solid #000; }
    .footer-bank .fb-title { font-size: 12px; font-weight: 700; text-transform: uppercase; margin-bottom: 4px; }
    .footer-bank .fb-row { display: flex; gap: 4px; margin-bottom: 2px; }
    .footer-bank .fb-lbl { font-size: 12px; color: #444; min-width: 70px; }
    .footer-bank .fb-val { font-size: 12px; font-weight: 700; }
    .footer-sign { width: 200px; padding: 12px 10px; text-align: center; }
    .footer-sign .sign-title { font-size: 13px; font-weight: 700; margin-bottom: 46px; }
    .footer-sign .sign-line { border-top: 1px solid #000; font-size: 12px; font-weight: 700; padding-top: 3px; }

    .words-row { border: 1px solid #000; border-top: none; padding: 6px 10px; font-size: 13px; font-weight: 600; margin-bottom: 0; }
    .print-spacer {
        display: none;
    }
    .print-note { text-align: center; font-size: 12px; color: #666; border: 1px solid #000; border-top: none; padding: 3px; margin-top: 0; }

    @media print {
        @page { size: A4; margin: 10mm; }
        body { print-color-adjust: exact; -webkit-print-color-adjust: exact; }
        .no-print { display: none !important; }
        .page {
            width: 100%;
            padding: 0;
            min-height: calc(297mm - 20mm);
            display: flex;
            flex-direction: column;
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

    <!-- ── ORIGINAL tag ── -->
    <!--div class="original-tag">Original</div-->

    <!-- ── Header ── -->
    <div class="print-header">
        <div class="co-gstin-row">
            <div class="co-devotion">
                <svg class="dev-trident" viewBox="0 0 28 40" aria-hidden="true">
                    <path d="M13 2h2v12h4l2-6h2v9h-7v20h-4V17H5V8h2l2 6h4z" fill="#e10606"/>
                </svg>
                <span class="dev-swastik">&#x5350;</span>
                <span class="dev-text">GOD'S GRACE</span>
                <span class="dev-swastik">&#x5350;</span>
                <span class="dev-win">WIN WIN</span>
            </div>
            <% if (!co.get(2).toString().isEmpty()) { %>
            <div class="co-gstin-right">GSTIN: <%= co.get(2) %></div>
            <% } %>
        </div>
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
        <div class="co-block">
            <div class="co-name"><%= co.get(0) %></div>
            <div class="co-sub"><%= co.get(1) %></div>
        </div>
        </div>
    </div>
    <div class="header-divider"></div>

    <!-- ── Title ── -->
    <div class="title-bar">
        Transportation Bill
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
                <span class="inv-lbl">Date</span>
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
                String particular = p.get(2).toString();
                String qty        = p.get(3).toString();
                String rateWt     = p.get(4).toString();
                double amount     = Double.parseDouble(p.get(5).toString());
        %>
            <tr>
                <td class="td-lr-no"><%= rowLrNo.isEmpty() ? (firstRow ? lrNo : "") : rowLrNo %></td>
                <td class="td-date"><% if (firstRow) { %><%= lrDate %><% } %></td>
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
                <div class="total-lr-count">TOTAL LR's = <%= String.format("%02d", lrList.size()) %> No's ONLY.</div>
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
