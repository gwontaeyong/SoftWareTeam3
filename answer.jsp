<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<!--답변 서버  -->
<%
	request.setCharacterEncoding("utf-8"); //utf-8인코딩
	String strUrl = "jdbc:mysql://168.131.152.161/javachip?useUnicode=true&characterEncoding=utf-8";
	String strUser = "root";
	String strPassword = "apmsetup";
	Statement statement;
	Statement statement2;
	ResultSet resultset;
	ResultSet resultset2;

	JSONObject jsonroot = new JSONObject(); // jsonobject객체 생성 최종으로 넘겨줄 json객체
	String tmpqid = request.getParameter("qid");//질문번호를 받아옴

	int qid = Integer.parseInt(tmpqid); // 받아온값 형변환

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(strUrl, strUser, strPassword);
		statement = connection.createStatement();

		String sql = "select * from answer"; // answer table 질의문 작성
		resultset = statement.executeQuery(sql);
		JSONObject jobject; // 값을 넣을 jsonObject객체 생성

		JSONArray jArray = new JSONArray(); 
		int count = 0;
		while (resultset.next()) {
			if (qid == resultset.getInt("qid")) { // qid와 일치하는  attribute 가져오기
				jobject = new JSONObject();
				jobject.put("aid", Integer.toString(resultset.getInt("aid")));//질문번호 삽입
				statement2 = connection.createStatement();
				String sql2 = "select * from user"; //user table 질의문 작성
				resultset2 = statement2.executeQuery(sql2);
				String id = null;
				while (resultset2.next()) {
					if (resultset.getInt("uid") == resultset2.getInt("uid")) //user 의 해당 uid에 일치하는 정보 삽입
						id = resultset2.getString("id"); // uid에 일치하는 id꺼내오기
				}
				jobject.put("id", id); // id삽입
				jobject.put("qid", Integer.toString(resultset.getInt("qid"))); // qid삽입
				jobject.put("ainfo", resultset.getString("ainfo")); // 답변 내용 삽입
				jArray.add(count++, jobject); //해당 답변 개수만큼 추가
			}
		}

		jsonroot.put("result", jArray); // json값 보내기

		PrintWriter pw = response.getWriter();
		pw.print(jsonroot);//웹서버에서 확인
		pw.flush(); // flush
		pw.close();

		connection.close();//connection 종료
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