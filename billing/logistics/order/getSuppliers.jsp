<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.setStatus(401);
        out.print("[]");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    String term = request.getParameter("term");
    if (term == null) term = "";
    term = term.trim();

    StringBuilder json = new StringBuilder("[");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        con = util.DBConnectionManager.getConnectionFromPool();
        ps = con.prepareStatement(
            "SELECT id, name FROM prod_supplier WHERE is_active = 1 AND name LIKE ? ORDER BY name LIMIT 20");
        ps.setString(1, "%" + term + "%");
        rs = ps.executeQuery();
        boolean first = true;
        while (rs.next()) {
            if (!first) json.append(",");
            first = false;
            String name = rs.getString(2).replace("\\", "\\\\").replace("\"", "\\\"");
            json.append("{\"id\":").append(rs.getInt(1))
                .append(",\"label\":\"").append(name).append("\"}");
        }
    } catch (Exception e) {
        // return empty array on error
    } finally {
        if (rs  != null) try { rs.close();  } catch (Exception e) {}
        if (ps  != null) try { ps.close();  } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
    json.append("]");
    out.print(json.toString());
%>
