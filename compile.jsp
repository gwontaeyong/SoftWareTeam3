<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>

<!--컴파일 서버  -->
<%

	request.setCharacterEncoding("UTF-8");//utf-8인코딩

	String str = request.getParameter("contents"); // 코드 내용 전송받기
	try {
		BufferedWriter writer = new BufferedWriter(
				new FileWriter("C:\\Users\\Park\\Desktop\\eclipse\\Main.java")); // Main.java파일 생성
		writer.write(str); // Main.java에 코드 삽입
		writer.close(); 

	} catch (Exception e) {
		out.println("읽기 실패");
	}
	JSONObject jsonroot = new JSONObject();
	JSONObject jsontmp = null;

	try {
		Process p = Runtime.getRuntime().exec("javac Main.java"); // Main.class파일 생성
		BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
		String line = null;
		while ((line = br.readLine()) != null) {
			out.println(line); // 생성후 process에서 전송값 웹에 출력
		}
	} catch (Exception e) {
		out.println(e.toString());
	}

	try {
		Process p2 = Runtime.getRuntime().exec("java -classpath %javapath%\\bin; Main"); // Main.class파일 컴파일
		BufferedReader br = new BufferedReader(new InputStreamReader(p2.getInputStream()));
		String line = null;
		ArrayList<Map<String, String>> selectlist = new ArrayList<Map<String, String>>(); //HashMap이용해서 값전달
		JSONArray jsonList = new JSONArray(); // JSONArray의 객체
		Map<String, String> dbmap = null; // HashMap의 temp가 되는 값
 		
		while ((line = br.readLine()) != null) {
			dbmap = new HashMap<String, String>();
			dbmap.put("result", line); // 결과값 추가
			selectlist.add(dbmap);
		}
		for (Map<String, String> selectone : selectlist) {
			Set<String> key = selectone.keySet();
			//MAP의 KEY/VALUE를 통하여 JSON임시객체에 담아준후 
			for (Iterator<String> iterator = key.iterator(); iterator.hasNext();) {
				String tmpekey = (String) iterator.next();
				String tmpvalue = (String) selectone.get(tmpekey);
				jsontmp = new JSONObject();
				jsontmp.put(tmpekey, tmpvalue);
			}
			//JSON배열목록에 추가
			jsonList.add(jsontmp);
		}
		//db목록 json set
		jsonroot.put("result", jsonList);
		//성공여부
		jsonroot.put("success", true);
		PrintWriter pw=response.getWriter();
		pw.print(jsonroot);
		pw.flush();
		pw.close();
	} catch (Exception e) {
		out.println(e.toString());
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