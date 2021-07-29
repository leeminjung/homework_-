<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>


<jsp:useBean id="boardDTO" class="com.koreait.board.BoardDTO"/>
	<jsp:setProperty property="title" param="b_title" name="boardDTO"/>
	<jsp:setProperty property="content" param="b_content" name="boardDTO"/>
	<jsp:setProperty property="file" param="b_file" name="boardDTO"/>
	<jsp:setProperty property="idx" param="b_idx" name="boardDTO"/>
	<jsp:useBean id="boardDAO" class="com.koreait.board.BoardDAO"/>
<%
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("userid") == null){
%>
	<script>
		alert('로그인 후 이용하세요');
		location.href='../login.jsp';
	</script>
<%
	}else{
		try{
			String uploadPath = request.getRealPath("upload");// 물리적인 실제 경로임. (이클립스에서만.)
            System.out.println(uploadPath);
            int size = 1024*1024*10;
            MultipartRequest  multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy()); 
            boardDTO.setIdx(Integer.parseInt(String.valueOf(request.getParameter("b_idx"))));
			boardDTO.setTitle((String)multi.getParameter("b_title"));
			boardDTO.setFile((String)multi.getParameter("b_file"));
			boardDTO.setContent((String)multi.getParameter("b_content"));
			if(boardDAO.editOk(boardDTO)==1){
%>
			<script>
				alert('수정되었습니다');
				location.href='view.jsp?b_idx=<%=boardDTO.getIdx()%>';
			</script>
<%
			}else{
%>
			<script>
				alert('수정에 실패하였습니다.');
				history.back();
			</script>
<%
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%> 
