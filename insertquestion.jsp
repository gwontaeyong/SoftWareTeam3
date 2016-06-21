<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<!--질문 삽입서버  -->
<%
	request.setCharacterEncoding("utf-8");//utf-8인코딩
	String strUrl = "jdbc:mysql://168.131.152.161/javachip?useUnicode=true&characterEncoding=utf-8";
	String strUser = "root";
	String strPassword = "apmsetup";
	Statement statement;
	ResultSet resultset;

	JSONObject jsonroot = new JSONObject();
	String id = request.getParameter("id"); //id값 전송받기
	String qtitle = request.getParameter("qtitle"); // 질문 제목 전송받기
	String qinfo = request.getParameter("qinfo"); // 질문 내용 전송받기
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(strUrl, strUser, strPassword);
		statement = connection.createStatement();

		String sql = "select * from user"; //db user table 질의문
		resultset = statement.executeQuery(sql);
		int uid = -1;
		while (resultset.next()) {
			if (id.equals(resultset.getString("id"))) //해당 id의
				uid = resultset.getInt("uid"); // uid 변수에 저장
		}
		JSONObject jobject;

		sql = "insert into question(uid,qtitle,qinfo) values(" + uid + ", '" + qtitle + "', '" + qinfo + "' )";
		//질문 삽입 
		statement.executeUpdate(sql);
		
		jsonroot.put("result", 0);
		
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