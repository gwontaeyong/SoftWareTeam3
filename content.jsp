<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<!-- 웹상에서 컴파일  -->
<body>
	<form name=writeform action="compile.jsp" method="post">
		<script>
			function blockKey(item) {
				if (event.keyCode == 9) {  //tab키를 눌렀을때
					item.focus();
					space = "\\t";
					item.selection = document.selection.createRange();
					item.selection.text = space;
					event.returnValue = false;
				}
			}
		</script>
		<textarea rows="10" id="textField" 
			onkeydown="if(event.keyCode===9){var v=this.value,s=this.selectionStart,e=this.selectionEnd;this.value=v.substring(0, s)+'\t'+v.substring(e);this.selectionStart=this.selectionEnd=s+1;return false;}"
			cols="50" name="contents">class Main{<%
			out.println();
		%>	public static void main(String[] args){<%
			out.println();
			out.println();
			out.println();
			out.println();
		%>	}<%
			out.println();
		%>}
		</textarea>
		<br>
		</center>
		<input type="submit" name="login" style="vertical-align: middle"
			value="전송"">
	</form>
</body>
</html>
