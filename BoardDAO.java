package com.koreait.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;

import com.koreait.db.Dbconn;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "";
	
	//게시판 삭제 delete.jsp
	public int delete(BoardDTO board) {
	      try{
	         conn = Dbconn.getConnection();
	         if(conn != null){
	            sql = "delete from tb_board where b_idx=?";
	            pstmt  = conn.prepareStatement(sql);
	            pstmt.setLong(1, board.getIdx());
	            if(pstmt.executeUpdate() >= 1) {
	               return 1;
	            }
	         }
	      }catch(Exception e) {
	            e.printStackTrace();
	      }return 0;
	   }
	
	//수정 edit.jsp
	 public BoardDTO edit(BoardDTO board) {
		   try{
			    conn = Dbconn.getConnection();
			    sql = "select b_title, b_content, b_file from tb_board where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, board.getIdx());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					board.setTitle(rs.getString("b_title"));
					board.setContent(rs.getString("b_content"));
					board.setFile(rs.getString("b_file"));
					return board;
				}
		      }catch(Exception e) {
		            e.printStackTrace();
		      }return null;
	 		}

	 // 수정 edit_ok.jsp
	 
	   public int editOk(BoardDTO board) {
		   try {
			   conn = Dbconn.getConnection();		  
		         if(conn != null){
		        	 if(board.getFile() != null && !board.getFile().equals("")){
							sql = "update tb_board set b_title=?, b_content=?, b_file=? where b_idx=?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, board.getTitle());
							pstmt.setString(2, board.getContent());
							pstmt.setString(3, board.getFile());
							pstmt.setLong(4, board.getIdx());
						}else{
							sql = "update tb_board set b_title=?, b_content=? where b_idx=?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, board.getTitle());
							pstmt.setString(2, board.getContent());
							pstmt.setLong(3, board.getIdx());
						}
		            if(pstmt.executeUpdate() >= 1) {
		               return 1;
		            }
		         }
		      }catch(Exception e) {
		            e.printStackTrace();
		      }return 0;
	 
	   		}
	   
	   //좋아요 like_ok.jsp
	   
	   public int likeOk(BoardDTO board) {
		   int b_like = 0;
		   try {
			   conn = Dbconn.getConnection();
		        	if(conn != null){
		 				sql = "update tb_board set b_like = b_like + 1 where b_idx=?";
		 				pstmt  = conn.prepareStatement(sql);
		 				pstmt.setLong(1, board.getIdx());
		 				pstmt.executeUpdate();

		 				sql = "select b_like from tb_board where b_idx=?";
		 				pstmt  = conn.prepareStatement(sql);
		 				pstmt.setLong(1, board.getIdx());
		 				rs = pstmt.executeQuery();

		 				if(rs.next()){
							b_like = rs.getInt("b_like");
							return b_like;
						}
		         }
		     }catch(Exception e) {
		            e.printStackTrace();
		   }return 0;
	   }
	   
	   
	   
//	   public int write(BoardDTO board) {
//		  
//		   try {
//			   conn= Dbconn.getConnection();
//			   if(conn != null) { //연결되었다면
//				   
//			   }
//		   }catch(Exception e){
//			   e.printStackTrace();
//		   }
//		   
//	   }
//	   
}
	   
	   
	   
	   
	   



