<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<!--질문  서버  -->
<%
	request.setCharacterEncoding("utf-8");//utf-8인코딩
	String strUrl = "jdbc:mysql://168.131.152.161/javachip?useUnicode=true&characterEncoding=utf-8";
	String strUser = "root";
	String strPassword = "apmsetup";
	Statement statement;
	ResultSet resultset;
	ResultSet resultset2;
	Statement statement2;
	JSONObject jsonroot = new JSONObject();

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(strUrl, strUser, strPassword);
		statement = connection.createStatement();
		statement2 = connection.createStatement();
		String sql = "select * from question"; //질문 db table 질의문
		resultset = statement.executeQuery(sql);
		int count2 = 0;

		JSONObject jobject;
		JSONArray jArray = new JSONArray();
		int count = 0;
		while (resultset.next()) {
			jobject = new JSONObject();
			String sql2 = "select * from user"; //user db table질의문
			resultset2 = statement2.executeQuery(sql2);
			String id = null;
			while (resultset2.next()) {
				if (resultset.getInt("uid") == resultset2.getInt("uid")) // 해당 uid 와 일치하는
 					id = resultset2.getString("id"); //id삽입
			}
			jobject.put("id", id);
			jobject.put("qid", resultset.getString("qid"));
			jobject.put("qtitle", resultset.getString("qtitle"));
			jobject.put("qinfo", resultset.getString("qinfo"));
			jArray.add(count++, jobject);
		}

		jsonroot.put("result", jArray);

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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>