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
// [2] parts:  bill_lr_id, particular, qty, rate_wt, amount
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
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: Arial, Helvetica, sans-serif; font-size: 13px; color: #000; background: #fff; }

    .page { width: 210mm; margin: 0 auto; padding: 10mm 12mm; }

    /* ── Header ── */
    .print-header {
        background: linear-gradient(135deg, #0a1f44 0%, #163172 60%, #1a3a8a 100%);
        border-radius: 6px 6px 0 0;
        padding: 18px 20px 16px;
        display: flex;
        align-items: center;
        gap: 18px;
        margin-bottom: 0;
        position: relative;
    }
    .logo-wrap img { width: 100px; height: 100px; object-fit: contain; border-radius: 4px; background:#fff; padding:4px; }
    .logo-wrap .no-logo {
        width: 100px; height: 100px; display:flex; align-items:center; justify-content:center;
        background: rgba(255,255,255,.15); border: 1.5px solid rgba(255,255,255,.3);
        font-size:11px; color:rgba(255,255,255,.7); border-radius:4px;
    }
    .co-name {
        font-size: 32px; font-weight: 900; letter-spacing: 1px;
        text-transform: uppercase; color: #fff;
        text-shadow: 0 1px 4px rgba(0,0,0,.35);
    }
    .co-sub  { font-size: 13px; color: #ffffff; margin-top: 4px; white-space: pre-wrap; }
    .co-gstin-badge {
        position: absolute; top: 12px; right: 16px;
        background: rgba(255,255,255,.15);
        border: 1px solid rgba(255,255,255,.35);
        border-radius: 4px; padding: 4px 12px;
        font-size: 12px; font-weight: 700; color: #fff;
        letter-spacing: 0.5px;
    }
    .header-divider {
        height: 5px;
        background: linear-gradient(90deg, #f5a623 0%, #f0c040 50%, #f5a623 100%);
        margin-bottom: 6px;
        border-radius: 0 0 3px 3px;
    }

    <!-- ── Title bar ── -->
    .title-bar {
        text-align: center; font-size: 28px; font-weight: 900;
        background: #f0f4ff; border: 1px solid #b8c8f0;
        padding: 10px 5px; margin: 0 0 6px; letter-spacing: 4px;
        text-transform: uppercase; color: #0a1f44;
    }
    .original-tag { text-align: right; font-size: 11px; font-style: italic; color: #555; margin-bottom: 4px; }

    /* ── Two-column info section ── */
    .info-grid { display: flex; gap: 0; border: 1px solid #000; margin-bottom: 6px; }
    .info-left { flex: 1; padding: 6px 8px; border-right: 1px solid #000; }
    .info-right { width: 260px; padding: 6px 8px; }
    .info-label { font-size: 11px; color: #555; }
    .info-val { font-size: 13px; font-weight: 600; }
    .info-row { margin-bottom: 3px; }
    .billed-title { font-size: 11px; font-weight: 700; text-transform: uppercase; margin-bottom: 4px; border-bottom: 1px solid #ddd; padding-bottom: 2px; }
    .inv-row { display: flex; gap: 4px; margin-bottom: 2px; }
    .inv-lbl { font-size: 11px; color: #555; min-width: 90px; }
    .inv-val { font-size: 12px; font-weight: 700; }

    /* ── GST notice ── */
    .gst-notice { border: 1px solid #000; border-top: none; padding: 3px 8px; font-size: 11px; font-weight: 700; text-align: center; margin-bottom: 0; }

    /* ── Bill table ── */
    .bill-table { width: 100%; border-collapse: collapse; margin-bottom: 0; }
    .bill-table th, .bill-table td { border: 1px solid #000; padding: 4px 6px; vertical-align: top; }
    .bill-table thead th { background: #f5f5f5; font-size: 12px; font-weight: 700; text-align: center; white-space: nowrap; }
    .bill-table td { font-size: 12px; }
    .td-lr-no  { font-weight: 700; white-space: nowrap; }
    .td-date   { white-space: nowrap; }
    .td-amount { text-align: right; font-weight: 600; white-space: nowrap; }
    .td-qty    { text-align: center; }
    .td-rate   { text-align: center; }
    .lr-note-row td { font-size: 11px; color: #555; font-style: italic; padding: 1px 6px 3px; border-top: none; }
    .total-row td  { font-weight: 700; font-size: 13px; background: #f9f9f9; border-top: 2px solid #000; }
    .subtotal-row td { font-weight: 600; font-size: 12px; background: #fafafa; color: #333; }
    .total-lr-count { font-size: 11px; font-weight: 400; color: #555; margin-top: 2px; }

    /* ── Footer ── */
    .footer-row { display: flex; margin-top: 0; border: 1px solid #000; border-top: none; }
    .footer-bank { flex: 1; padding: 6px 8px; border-right: 1px solid #000; }
    .footer-bank .fb-title { font-size: 11px; font-weight: 700; text-transform: uppercase; margin-bottom: 4px; }
    .footer-bank .fb-row { display: flex; gap: 4px; margin-bottom: 2px; }
    .footer-bank .fb-lbl { font-size: 11px; color: #444; min-width: 70px; }
    .footer-bank .fb-val { font-size: 11px; font-weight: 700; }
    .footer-sign { width: 200px; padding: 6px 8px; text-align: center; }
    .footer-sign .sign-title { font-size: 12px; font-weight: 700; margin-bottom: 28px; }
    .footer-sign .sign-line { border-top: 1px solid #000; font-size: 11px; font-weight: 700; padding-top: 3px; }

    .words-row { border: 1px solid #000; border-top: none; padding: 4px 8px; font-size: 12px; font-weight: 600; }
    .print-note { text-align: center; font-size: 11px; color: #666; border: 1px solid #000; border-top: none; padding: 3px; }

    @media print {
        @page { size: A4; margin: 10mm; }
        body { print-color-adjust: exact; -webkit-print-color-adjust: exact; }
        .no-print { display: none !important; }
        .page { width: 100%; padding: 0; }
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
    <div class="original-tag">Original</div>

    <!-- ── Header ── -->
    <div class="print-header">
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
        <div style="flex:1;">
            <div class="co-name"><%= co.get(0) %></div>
            <div class="co-sub"><%= co.get(1) %></div>
        </div>
        <% if (!co.get(2).toString().isEmpty()) { %>
        <div class="co-gstin-badge">GSTIN: <%= co.get(2) %></div>
        <% } %>
    </div>
    <div class="header-divider"></div>

    <!-- ── Title ── -->
    <div style="text-align:center !important;font-size:16px !important;font-weight:900 !important;
                background:#f0f4ff;border:1px solid #b8c8f0;padding:6px 5px;margin:0 0 6px;
                letter-spacing:0;text-transform:uppercase;color:#0a1f44;width:100%;box-sizing:border-box;">
        Transportation Bill
    </div>

    <!-- ── Info grid ── -->
    <div class="info-grid">
        <!-- Left: Billed To -->
        <div class="info-left">
            <div class="billed-title">Details of Receiver (Billed to),</div>
            <div class="info-val" style="font-size:12px;"><%= hdr.get(10) %></div>
            <% if (!hdr.get(11).toString().isEmpty()) { %>
            <div style="font-size:10px;margin-top:2px;white-space:pre-wrap;"><%= hdr.get(11) %></div>
            <% } %>
            <% if (!hdr.get(12).toString().isEmpty()) { %>
            <div style="font-size:10px;">Ph: <%= hdr.get(12) %></div>
            <% } %>
            <% if (!hdr.get(13).toString().isEmpty()) { %>
            <div style="font-size:10px;font-weight:600;margin-top:3px;">GST NO: <%= hdr.get(13) %></div>
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
                <span class="inv-lbl">PO No</span>
                <span class="inv-val">: <%= hdr.get(2).toString().isEmpty() ? "-" : hdr.get(2) %></span>
            </div>
            <div class="inv-row">
                <span class="inv-lbl">SAC Code</span>
                <span class="inv-val">: <%= hdr.get(3).toString().isEmpty() ? "-" : hdr.get(3) %></span>
            </div>
            <div class="inv-row">
                <span class="inv-lbl">Mode of Payment</span>
                <span class="inv-val">: <%= hdr.get(7) %></span>
            </div>
            <% if (!hdr.get(8).toString().isEmpty() && !"0".equals(hdr.get(8).toString())) { %>
            <div class="inv-row">
                <span class="inv-lbl">Credit Days</span>
                <span class="inv-val">: <%= hdr.get(8) %> Days</span>
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
                String particular = p.get(1).toString();
                String qty        = p.get(2).toString();
                String rateWt     = p.get(3).toString();
                double amount     = Double.parseDouble(p.get(4).toString());
        %>
            <tr>
                <td class="td-lr-no"><% if (firstRow) { %><%= lrNo %><% } %></td>
                <td class="td-date"><% if (firstRow) { %><%= lrDate %><% } %></td>
                <td><%= particular %></td>
                <td class="td-qty"><%= qty %></td>
                <td class="td-rate"><%= rateWt %></td>
                <td class="td-amount"><%= amount > 0 ? nf.format(amount) : "" %></td>
            </tr>
        <%
                firstRow = false;
            }
            // LR sub-total row (only if more than 1 LR)
            if (lrList.size() > 1) {
        %>
            <tr class="subtotal-row">
                <td colspan="5" style="text-align:right;font-size:9.5px;padding-right:8px;">LR Sub-Total</td>
                <td class="td-amount"><%= nf.format(lrTotal) %></td>
            </tr>
        <%  } %>
            <%-- Notes row --%>
        <% if (!lrNotes.isEmpty()) { %>
            <tr class="lr-note-row">
                <td></td><td></td>
                <td colspan="4">(Note: <%= lrNotes %>)</td>
            </tr>
        <% } %>
        <% } %>

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

    <!-- ── Footer ── -->
    <div class="footer-row">
        <div class="footer-bank">
            <div class="fb-title">Bank Details</div>
            <% if (!co.get(3).toString().isEmpty()) { %>
            <div style="font-size:9.5px;font-weight:600;white-space:pre-wrap;"><%= co.get(3) %></div>
            <% } %>
        </div>
        <div class="footer-sign">
            <div class="sign-title">For <%= co.get(0) %></div>
            <div class="sign-line">Authorised Signatory</div>
        </div>
    </div>

    <div class="print-note">This is a Computer Generated Invoice. Signature Not Required</div>

    <div style="text-align:right;font-size:8px;color:#999;margin-top:3px;padding-right:4px;">
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
