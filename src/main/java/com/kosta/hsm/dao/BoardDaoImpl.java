package com.kosta.hsm.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import java.util.*;

import com.kosta.hsm.vo.BoardVo;



public class BoardDaoImpl implements BoardDao {
	
  private Connection getConnection() throws SQLException {
    Connection conn = null;
    try {
      Class.forName("oracle.jdbc.driver.OracleDriver");
      String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
      conn = DriverManager.getConnection(dburl, "webdb", "1234");
    } catch (ClassNotFoundException e) {
      System.err.println("JDBC 드라이버 로드 실패!");
    }
    return conn;
  }
  
	public Vector<BoardVo> getList(String keyField, String kwd,
			int start, int end) {

		// 0. import java.sql.*;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<BoardVo> vlist = new Vector<BoardVo>();

		try {
			conn = getConnection();

			// 3. SQL문 준비 / 바인딩 / 실행
			if (kwd.equals("null") || kwd.equals("")) {
				String query = "SELECT * \r\n" + 
					      "        FROM(\r\n" + 
					      "              SELECT ROWNUM AS RNUM, A.*\r\n" + 
					      "                  FROM ( select b.no, b.title, b.hit, to_char(b.reg_date,'YYYY-MM-DD HH24:MI') as reg_date, b.user_no, b.depth,  b.pos, b.ref, u.name from board b, users u where b.user_no = u.no order by ref desc, pos asc ) A\r\n" + 
					      "               WHERE ROWNUM <= ?+?\r\n" + 
					      "            )\r\n" + 
					      "       WHERE RNUM > ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				pstmt.setInt(3, start);
			} else {
				String query = " SELECT * \r\n" + 
			              " FROM(\r\n" + 
			              "   SELECT ROWNUM AS RNUM, A.*\r\n" + 
			              "   FROM ( select b.no, b.title, b.hit, to_char(b.reg_date,'YYYY-MM-DD HH24:MI') as reg_date, b.user_no, b.depth,  b.pos, b.ref, u.name from board b, users u where b.user_no = u.no and " + keyField + " like ?  order by ref desc, pos asc ) A\r\n" + 
			              "   WHERE ROWNUM <= ?+?\r\n" + 
			              "   )\r\n" + 
			              " WHERE RNUM > ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + kwd + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				pstmt.setInt(4, start);
				
				
			}

			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardVo vo = new BoardVo();
				vo.setNo(rs.getInt("no"));
				vo.setUserName(rs.getString("name"));
				vo.setTitle(rs.getString("title"));
				vo.setPos(rs.getInt("pos"));//답변위치값
				vo.setRef(rs.getInt("ref"));//답변
				vo.setDepth(rs.getInt("depth"));
				vo.setHit(rs.getInt("hit"));
				vo.setUserNo(rs.getInt("user_no"));
				vo.setRegDate(rs.getString("reg_date"));
				vlist.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			// 5. 자원정리
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}

		}
		
		return vlist;

	}

	
	public BoardVo getBoard(int no) {

		// 0. import java.sql.*;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardVo boardVo = null;
		
		try {
		  conn = getConnection();

			// 3. SQL문 준비 / 바인딩 / 실행
			String query = "select b.no, b.title, b.content, b.hit, b.reg_date, b.user_no,b.ref,b.pos,b.depth, b.filename1, b.filesize1, b.filename2, b.filesize2,b.pass, u.name "
					     + "from board b, users u "
					     + "where b.user_no = u.no "
					     + "and b.no = ?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			// 4.결과처리
			while (rs.next()) {
				String title = rs.getString("title");
				String content = rs.getString("content");
				int hit = rs.getInt("hit");
				String regDate = rs.getString("reg_date");
				int userNo = rs.getInt("user_no");
				String filename1 = rs.getString("filename1");
				int filesize1 = rs.getInt("filesize1");
				String filename2 = rs.getString("filename2");
				int filesize2 = rs.getInt("filesize2");
				String userName = rs.getString("name");
				int ref = rs.getInt("ref");
				int pos = rs.getInt("pos");
				int depth = rs.getInt("depth");
				String pass = rs.getString("pass");
				
				boardVo = new BoardVo(no, title, content, hit, regDate, userNo, userName, ref, pos, depth, filename1, filesize1, filename2, filesize2, pass);
			}
			
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			// 5. 자원정리
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}

		}
		System.out.println(boardVo);
		return boardVo;

	}
	
	public int insert(BoardVo vo) {
		// 0. import java.sql.*;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		
		
		String query = null;
		int ref = 0;
        int pos = 0;// 새글이기에
        int depth = 0;//

		try {
		  conn = getConnection();
		  
		  System.out.println("vo.userNo : ["+vo.getUserNo()+"]");
		  System.out.println("vo.title : ["+vo.getTitle()+"]");
		  System.out.println("vo.content : ["+vo.getContent()+"]");
		  
		  String refsql = "select max(ref) from board";
          pstmt = conn.prepareStatement(refsql);
          // 쿼리 실행후 결과를 리턴
          rs = pstmt.executeQuery();
          if (rs.next()) {
              ref = rs.getInt(1) + 1; // ref가장 큰 값에 1을 더해줌
              // 최신글은 글번호가 가장 크기 때문에 원래 있던 글에서 1을 더해줌

          }
		  
		  
      
			// 3. SQL문 준비 / 바인딩 / 실행
			query = "insert into board (no, title, content, hit, reg_date, user_no, depth, pos, ref, filename1, filesize1, filename2, filesize2)"
					+ " values (seq_board_no.nextval, ?, ?, 0, sysdate, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(query);

			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3, vo.getUserNo());
			pstmt.setInt(4, depth);
			pstmt.setInt(5, pos);
			pstmt.setInt(6, ref);
			pstmt.setString(7, vo.getFilename1());
			pstmt.setLong(8, vo.getFilesize1());
			pstmt.setString(9, vo.getFilename2());
			pstmt.setLong(10, vo.getFilesize2());
			
			
      
			count = pstmt.executeUpdate();

			// 4.결과처리
			System.out.println(count + "건 등록");

		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			// 5. 자원정리
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}

		}

		return count;
	}
	
	
	
	
	public int delete(int no) {
		// 0. import java.sql.*;
		Connection conn = null;
		PreparedStatement pstmt = null;
		int count = 0;

		try {
		  conn = getConnection();

			// 3. SQL문 준비 / 바인딩 / 실행
			String query = "delete from board where no = ?";
			pstmt = conn.prepareStatement(query);

			pstmt.setInt(1, no);

			count = pstmt.executeUpdate();

			// 4.결과처리
			System.out.println(count + "건 삭제");

		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			// 5. 자원정리
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}

		}

		return count;
	}
	
	
	public int update(BoardVo vo) {
		// 0. import java.sql.*;
		Connection conn = null;
		PreparedStatement pstmt = null;
		int count = 0;

		try {
		  conn = getConnection();

			// 3. SQL문 준비 / 바인딩 / 실행
			String query = "update board set title = ?, content = ? where no = ? ";
			pstmt = conn.prepareStatement(query);

			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3, vo.getNo());

			count = pstmt.executeUpdate();

			// 4.결과처리
			System.out.println(count + "건 수정");

		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			// 5. 자원정리
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}

		}

		return count;
	}

	@Override
	public void hitIncrease(BoardVo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int count = 0;

		try {
		  conn = getConnection();

			// 3. SQL문 준비 / 바인딩 / 실행
			String query = "update board set hit=? where no = ? ";
			pstmt = conn.prepareStatement(query);

			pstmt.setInt(1, vo.getHit()+1);
			pstmt.setInt(2, vo.getNo());

			count = pstmt.executeUpdate();

			// 4.결과처리
			System.out.println(count + "건 조회수 수정");

		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			// 5. 자원정리
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}

		}

		
	}
	
	public int getTotalCount(String keyField, String kwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		int totalCount = 0;
		try {
			conn = getConnection();

			if (kwd.equals("null") || kwd.equals("")) {
				query = "select count(no) from board";
				pstmt = conn.prepareStatement(query);
			} else {
				query = "select count(*) from board b, users u "
						+ "where b.user_no = u.no and " + keyField + " like ? ";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + kwd + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 5. 자원정리
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
		}
		return totalCount;
	}

	@Override
	public List<BoardVo> search(String kwd) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardVo> list = new ArrayList<BoardVo>();

		try {
			conn = getConnection();

			// 3. SQL문 준비 / 바인딩 / 실행
			String query = "select b.no, b.title, b.hit, to_char(b.reg_date,'YYYY-MM-DD HH24:MI') as reg_date, b.user_no, u.name \r\n"
					+ " from board b, users u \r\n"
					+ " where (b.user_no = u.NO)\r\n"
					+ " and (u.name LIKE '%"+kwd+"%'\r\n"
					+ " OR b.reg_date LIKE '%"+kwd+"%'\r\n"
					+ " OR b.title LIKE '%"+kwd+"%'\r\n"
					+ " OR b.content LIKE '%"+kwd+"%')\r\n"
					+ " order by no DESC";
			
			pstmt = conn.prepareStatement(query);

			rs = pstmt.executeQuery();
			// 4.결과처리
			while (rs.next()) {
				int no = rs.getInt("no");
				String title = rs.getString("title");
				int hit = rs.getInt("hit");
				String regDate = rs.getString("reg_date");
				int userNo = rs.getInt("user_no");
				String userName = rs.getString("name");
				
				BoardVo vo = new BoardVo(no, title, hit, regDate, userNo, userName);
				list.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			// 5. 자원정리
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}

		}
		
		return list;
		
		
	}
	
	public void replyUpBoard(int ref, int pos) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
        
            String sql = "update Board set pos = pos + 1 where ref = ? and pos > ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ref);
            pstmt.setInt(2, pos);
            pstmt.executeUpdate();
            
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			// 5. 자원정리
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}

		}
	}
	
	public void replyBoard(BoardVo vo) {
		Connection conn=null;
        PreparedStatement pstmt = null;
        String sql=null;
        
        try {
			conn = getConnection();
            sql="insert into board(no,user_no,content,title,ref,pos,depth,reg_date,pass)";
            sql+=" values(seq_board_no.nextval,?,?,?,?,?,?,sysdate,?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, vo.getUserNo());
            pstmt.setString(2, vo.getContent());
            pstmt.setString(3, vo.getTitle());
            pstmt.setInt(4, vo.getRef());
            //pos(pos 1증가)
            pstmt.setInt(5, vo.getPos()+1);
            
            //depth(부모글로부터의 level)
            pstmt.setInt(6, vo.getDepth()+1);
            pstmt.setString(7, vo.getPass());
            pstmt.executeUpdate();
        } catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			// 5. 자원정리
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}

		}
	}
	
}
