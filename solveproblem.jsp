<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<!--푼문제 서버  -->
<%
	request.setCharacterEncoding("utf-8");//utf-8인코딩
	String strUrl = "jdbc:mysql://168.131.152.161/javachip?useUnicode=true&characterEncoding=utf-8";
	String strUser = "root";
	String strPassword = "apmsetup";
	Statement statement;
	Statement statement2;
	ResultSet resultset;
	ResultSet resultset2;
	String id = request.getParameter("id"); //유저아이디
	String tmpid = request.getParameter("pid"); // 문제 번호
	int pid = Integer.parseInt(tmpid);
	String check = request.getParameter("check");// 체크한 답
	JSONObject jsonroot = new JSONObject();

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(strUrl, strUser, strPassword);
		statement = connection.createStatement();
		statement2 = connection.createStatement();
		int uid = -1;
		String sql = "select *from user";
		resultset = statement.executeQuery(sql);
		
		while (resultset.next()) {
			if (id.equals(resultset.getString("id")))
				uid = resultset.getInt("uid");
		}
		sql = "select * from problem";
		resultset = statement.executeQuery(sql);
		JSONObject jobject;

		JSONArray jArray = new JSONArray();
		while (resultset.next()) {
			jobject = new JSONObject();
			if (pid == resultset.getInt("pid")) {
				if (check.equals(resultset.getString("panswer"))) {
					jsonroot.put("result", 0);//정답
				} else {
					jsonroot.put("result", 1);//오답
				}
				String sql2 = "inser into solvecheck(uid,pid) values(" + uid + ", " + pid + ")";
				statement2.executeUpdate(sql2);
			}

		}

		PrintWriter pw = response.getWriter();
		pw.print(jsonroot);
		pw.flush();
		pw.close();

		connection.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>