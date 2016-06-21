<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<!--강의 서버  -->
<%
	request.setCharacterEncoding("utf-8");//utf-8인코딩
	String strUrl = "jdbc:mysql://168.131.152.161/javachip?useUnicode=true&characterEncoding=utf-8";
	String strUser = "root";
	String strPassword = "apmsetup";
	Statement statement;
	ResultSet resultset;
	String tmpcid = request.getParameter("cid"); // 개념 번호 전송받기
	int cid = Integer.parseInt(tmpcid); // 형변환
	JSONObject jsonroot = new JSONObject();

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(strUrl, strUser, strPassword);
		statement = connection.createStatement();

		String sql = "select * from lecture"; //개념 db table 질의문
		resultset = statement.executeQuery(sql);
		JSONObject jobject;

		JSONArray jArray = new JSONArray();
		while (resultset.next()) {
			jobject = new JSONObject();
			if (cid == resultset.getInt("cid")) { // 개념에 해당하는 
				jobject.put("url", resultset.getString("url")); //url 값 삽입 
				jArray.add(0, jobject);
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
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>