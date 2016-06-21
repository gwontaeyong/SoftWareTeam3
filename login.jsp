<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<!--로그인 서버  -->
<%
	request.setCharacterEncoding("utf-8");//utf-8인코딩
	String strUrl = "jdbc:mysql://168.131.152.161/javachip?useUnicode=true&characterEncoding=utf-8";
	String strUser = "root";
	String strPassword = "apmsetup";
	String id = request.getParameter("id"); // id를 전송받기
	String password = request.getParameter("password"); //password전송받기
	Statement statement;
	ResultSet resultset;
	JSONObject jsonroot = new JSONObject();

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(strUrl, strUser, strPassword);
		statement = connection.createStatement();
		String sql = "select *from user"; //user table 질의문 
		resultset = statement.executeQuery(sql);
		int i = 0;
		while (resultset.next()) {
			if (resultset.getString("id").equals(id) && resultset.getString("pw").equals(password))
				i = 1; // id와 pass가 일치하면  1대입
		}
		if (i == 1) {
			jsonroot.put("result", 1); // 성공 전송
		} else {
			jsonroot.put("result", 0); // 싧패 전송
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>