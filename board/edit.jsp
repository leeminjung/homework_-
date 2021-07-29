<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn"%>
<%
	if(session.getAttribute("userid") == null){
%>
	<script>
		alert('로그인 후 이용하세요');
		location.href='../login.jsp';
	</script>
<%
	}else{
%>
	<jsp:useBean id="boardDTO" class="com.koreait.board.BoardDTO"/>
	<jsp:setProperty property="title" param="b_title" name="boardDTO"/>
	<jsp:setProperty property="content" param="b_content" name="boardDTO"/>
	<jsp:setProperty property="file" param="b_file" name="boardDTO"/>
	<jsp:useBean id="boardDAO" class="com.koreait.board.BoardDAO"/>
<%
	boardDTO.setIdx(Integer.parseInt(String.valueOf(request.getParameter("b_idx"))));
    if(boardDAO.edit(boardDTO) == null){
%>
	<script>
    	alert('잘못된 접속입니다');
    	location.href = 'list.jsp';
    </script>
<%
    }else{
    			
%>		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
</head>
<body>
	<h2>글수정</h2>
	<form method="post" action="edit_ok.jsp?b_idx=<%=boardDTO.getIdx()%>" enctype="multipart/form-data">
		<input type="hidden" name="b_idx" value="<%=boardDTO.getIdx()%>">
		<p>작성자 : <%=session.getAttribute("userid")%></p>
		<p><label>제목 : <input type="text" name="b_title" value="<%=boardDTO.getTitle()%>"></label></p>
		<p>내용</p>
		<p><textarea rows="5" cols="40" name="b_content"><%=boardDTO.getContent()%></textarea></p>
		<%
		
			if(boardDTO.getFile() != null && !boardDTO.getFile().equals("")){
				out.println("첨부파일");
				out.println("<img src='../upload/"+boardDTO.getFile()+"' alt='첨부파일' width='150'>");
			}
		%>
		<p><input type="file" name="b_file"></p>
		<p><input type="submit" value="수정"> 
		<input type="reset" value="다시작성"> 
		<input type="button" value="돌아가기" onclick="history.back()"></p>
	</form>
</body>
</html>
<%
	}
}
%> 