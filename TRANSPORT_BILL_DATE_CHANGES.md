# Transport Bill - Bill Date & LR Date Feature

## Summary of Changes

This document describes the changes made to add:
1. **Bill Date** selection option in the UI
2. **LR Date** column in the particulars table

---

## Database Changes

### 1. Add LR Date Column
**File:** `database/add_lr_date_column.sql`

```sql
ALTER TABLE `transport_bill_details`
ADD COLUMN `lr_date` DATE DEFAULT NULL AFTER `lr_no`;
```

**Note:** The `qty` column is already VARCHAR(50), so no conversion was needed.

**Action Required:** Run this SQL script once to update the database schema.

---

## UI Changes

### 1. Bill Date Picker Added
**Location:** Payment panel (right side)
**File:** `billing/logistics/transportBill/page.jsp`

- Added a "Bill Date" input field above the PO No field
- Automatically initializes to today's date when page loads
- Saves to `transport_bill.bill_date` column
- Resets to today's date when the reset button is clicked

### 2. LR Date Column Added to Particulars Table
**Location:** Particulars table inside each LR block (left side)
**File:** `billing/logistics/transportBill/page.jsp`

**New column order:**
- # (Serial)
- LR No
- **LR Date** ← NEW
- Particular
- Qty/Articles
- Rate/Wt
- Amount
- Actions (remove button)

The LR Date column:
- Accepts date input (HTML5 date picker)
- Saves to `transport_bill_details.lr_date` column
- Optional field (can be left empty)

---

## Backend Changes

### 1. saveBill.jsp
**Changes:**
- Accepts `billDate` from the request payload
- Extracts `lrDate` for each particular from the request
- Passes both to the Java bean method

### 2. billingBean.java
**Method Updated:** `saveTransportBill()`

**Changes:**
- Added `billDate` parameter to method signature
- Added `lrDates[]` array parameter
- Uses provided `billDate` instead of `CURDATE()` when saving transport_bill
- Saves `lr_date` for each particular in transport_bill_details

**Signature:**
```java
public String saveTransportBill(
    int customerId, 
    String billDate,           // ← NEW
    String poNo, 
    String sacCode,
    double grandTotal, 
    double paidAmount, 
    double balance,
    int paymentType, 
    int paymentModeInt, 
    String creditDays,
    int[] lrIds, 
    double[] lrTotals, 
    String[] lrNotes, 
    int[] lrPartCounts,
    String[] detailLrNos, 
    String[] lrDates,          // ← NEW
    String[] particulars, 
    String[] quantities, 
    String[] rateWts, 
    double[] amounts,
    int entryUser
) throws Exception
```

---

## Files Modified

1. ✅ `database/add_lr_date_column.sql` - Created (database migration)
2. ✅ `billing/logistics/transportBill/page.jsp` - Modified (UI changes)
3. ✅ `billing/logistics/transportBill/saveBill.jsp` - Modified (backend processing)
4. ✅ `billing/WEB-INF/classes/billing/billingBean.java` - Modified (database save logic)

---

## Testing Checklist

- [ ] Run the database migration script
- [ ] Compile the Java changes (if needed)
- [ ] Restart the application server
- [ ] Test creating a new transport bill:
  - [ ] Verify bill date picker shows today's date by default
  - [ ] Change bill date and verify it saves correctly
  - [ ] Add particulars with LR dates
  - [ ] Leave some LR dates empty (should work fine)
  - [ ] Save and verify data in database
  - [ ] Check if bill prints correctly with the new fields

---

## Database Query to Verify

After creating a bill, verify the data:

```sql
-- Check bill_date in transport_bill
SELECT id, invoice_no, bill_date, customer_id 
FROM transport_bill 
ORDER BY id DESC LIMIT 1;

-- Check lr_date in transport_bill_details
SELECT bd.id, bd.bill_id, bd.lr_no, bd.lr_date, bd.particular, bd.qty
FROM transport_bill_details bd
WHERE bd.bill_id = (SELECT MAX(id) FROM transport_bill)
ORDER BY bd.id;
```

---

## Notes

- **Bill Date:** Defaults to today's date but can be changed to any date (for back-dating bills or future bills)
- **LR Date:** Optional field per particular row; can be left empty
- **Qty Field:** Already VARCHAR(50) in database, no conversion needed
- **Backward Compatibility:** If bill_date is not provided (old calls), it will use CURDATE() as before

---

## Alert Queries

These queries are already included in the `add_lr_date_column.sql` file. No separate alert queries needed as we're using ALTER TABLE ADD COLUMN which is safe and won't affect existing data.

The `qty` field was already VARCHAR(50), so no ALTER was needed for that.
