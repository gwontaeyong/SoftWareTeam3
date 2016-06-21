<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<!--메모 서버  -->
<%
	request.setCharacterEncoding("utf-8");//utf-8인코딩
	String strUrl = "jdbc:mysql://168.131.152.161/javachip?useUnicode=true&characterEncoding=utf-8";
	String strUser = "root";
	String strPassword = "apmsetup";
	String id = request.getParameter("id"); // id값 전송받기
	Statement statement;
	ResultSet resultset;
	JSONObject jsonroot = new JSONObject();
	JSONObject jsontmp = null;
	int uid = -1; 
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(strUrl, strUser, strPassword);
		statement = connection.createStatement();
		String sql = "select * from user"; //db user table 질의문
		resultset = statement.executeQuery(sql);
		JSONObject jobject;
		JSONArray jArray = new JSONArray();

		while (resultset.next()) {
			if (id.equals(resultset.getString("id"))) //해당 id와 일치하는
				uid = resultset.getInt("uid"); //uid 값 대입
		}
		sql = "select * from memo"; //memo table질의문 생성
		resultset = statement.executeQuery(sql);
		int count = 0;
		while (resultset.next()) {
			if (resultset.getInt("uid") == uid) {//해당  uid 에 일치하는 
				jobject = new JSONObject();
				jobject.put("mid", Integer.toString(resultset.getInt("mid"))); //mid삽입
 				jobject.put("minfo", resultset.getString("minfo")); //메모 내용 삽입
				jArray.add(count++, jobject); // 메모 개수 만큼 대입
			}
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