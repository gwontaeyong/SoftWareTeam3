<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<!--회원가입서버 -->
<%
	request.setCharacterEncoding("utf-8");//utf-8인코딩
	String strUrl = "jdbc:mysql://168.131.152.161/javachip?useUnicode=true&characterEncoding=utf-8";
	String strUser = "root";
	String strPassword = "apmsetup";
	String id = request.getParameter("id"); // id전송받기
	String password = request.getParameter("password"); // password전송받기
	String name = request.getParameter("name"); // 이름 전송받기
	String gender = request.getParameter("gender"); //성별 전송받기
	String email = request.getParameter("email"); // email 전송받기
	Statement statement;
	ResultSet resultset;
	JSONObject jsonroot = new JSONObject();

	int gen = -1;
	if (gender.equals("men")) //남자일때
		gen = 0;
	else if (gender.equals("women")) // 여자일때
		gen = 1;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(strUrl, strUser, strPassword);
		statement = connection.createStatement();

		String sql2 = "select *from user"; // db user table 질의문
		resultset = statement.executeQuery(sql2);
		int i = 0;
		while (resultset.next()) {
			if (resultset.getString("id").equals(id)) { // 해당 id에 중복이되면 i에 1대입
				i = 1;
				break;
			}
		}
		if (i == 1) {
			jsonroot.put("result", 1);//실패(중복)
		} else if (i == 0) { // 중복되는 값이 없을때
			String sql = "insert into user(id,pw,name,gender,email) values ('" + id + "', '" + password + "', '"
					+ name + "', '" + gen + "', '" + email + "')";
			//회원가입 
			statement.executeUpdate(sql);
			jsonroot.put("result", 0);//성공
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