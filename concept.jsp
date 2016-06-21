<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<!--개념 서버  -->
<%
	request.setCharacterEncoding("utf-8");//utf-8인코딩
	String strUrl = "jdbc:mysql://168.131.152.161/javachip?useUnicode=true&characterEncoding=utf-8";
	String strUser = "root";
	String strPassword = "apmsetup";
	Statement statement;
	ResultSet resultset;
	JSONObject jsonroot = new JSONObject();
	String id = request.getParameter("id"); // id로 파라미터 받아오기
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(strUrl, strUser, strPassword);
		statement = connection.createStatement();
		int uid = -1;
		String sql = "select * from user"; //DB user Table로 부터 값 전송받기
		resultset = statement.executeQuery(sql);
		while (resultset.next()) {
			if (id.equals(resultset.getString("id"))) // 해당 id와 일치 여부 파악
				uid = resultset.getInt("uid"); // id에 대응하는 uid삽입
		}
		double percent = -1; // 강의 진행여부 percent변수
		int solvecount = 0; // 푼문제수 count 변수
		int total = 0; // 총문제수 
		sql = "select count(*) from solvecheck where uid=" + uid;//푼 문제 수
		resultset = statement.executeQuery(sql);
		while (resultset.next()) {
			solvecount = resultset.getInt(1); // 푼문제 개수 변수 값 대입
		}
		sql = "select count(*) from problem"; //전체 문제수
		resultset = statement.executeQuery(sql);
		while (resultset.next()) {
			total = resultset.getInt(1);
		}

		percent = solvecount / (double) total; //percent 값 삽입

		sql = "select * from concept"; // 개념 table값 가져오기
		resultset = statement.executeQuery(sql);
		JSONObject jobject;

		JSONArray jArray = new JSONArray();
		int count = 0;
		while (resultset.next()) {
			jobject = new JSONObject();
			jobject.put("percent", percent); //percent 값 삽입
			jobject.put("cid", Integer.toString(resultset.getInt("cid"))); //cid 값 삽입
			jobject.put("ctitle", resultset.getString("ctitle")); // ctitle 값 삽입
			jobject.put("cinfo", resultset.getString("cinfo")); // 개념 내용 삽입
			jArray.add(count++, jobject); // 개념 개수만큼 값 삽입
		}

		jsonroot.put("result", jArray); // json 형식으로 값 전송
		PrintWriter pw = response.getWriter();
		pw.print(jsonroot); // web상에 출력
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