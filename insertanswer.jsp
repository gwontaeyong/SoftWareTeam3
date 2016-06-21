<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<!--답변삽입서버  -->
<%
	request.setCharacterEncoding("utf-8");//utf-8인코딩
	String strUrl = "jdbc:mysql://168.131.152.161/javachip?useUnicode=true&characterEncoding=utf-8";
	String strUser = "root";
	String strPassword = "apmsetup";
	Statement statement;
	ResultSet resultset;

	JSONObject jsonroot = new JSONObject();
	String tmpqid = request.getParameter("qid");//질문 번호 값 전송받기
	String id = request.getParameter("id"); // id값 전송받기
	String ainfo = request.getParameter("ainfo"); // 답변 내용 전송받기
	int qid = Integer.parseInt(tmpqid); //질문번호 형 변환

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(strUrl, strUser, strPassword);
		statement = connection.createStatement();
		String sql = "select * from user"; //db user table 질의문
		resultset = statement.executeQuery(sql);
		int uid = -1;
		while (resultset.next()) {
			if (id.equals(resultset.getString("id")))
				uid = resultset.getInt("uid");
		}
		JSONObject jobject;
		JSONArray jArray = new JSONArray();
		sql = "insert into answer(uid,qid,ainfo) values(" + uid + ", " + qid + ", '" + ainfo + "')";
		//답변 추가 
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>