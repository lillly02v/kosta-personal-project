package com.kosta.hsm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kosta.hsm.dao.BoardDao;
import com.kosta.hsm.dao.BoardDaoImpl;
import com.kosta.hsm.util.WebUtil;
import com.kosta.hsm.vo.BoardVo;
import com.kosta.hsm.vo.UserVo;

@WebServlet("/board")
@MultipartConfig()
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String actionName = request.getParameter("a");
		System.out.println("board:" + actionName);

		if ("list".equals(actionName)) {
			// 리스트 가져오기
			BoardDao dao = new BoardDaoImpl();
			int totalRecord=0; //전체레코드수
			int numPerPage=3; // 페이지당 레코드 수 
			int pagePerBlock=5; //블럭당 페이지수 
			
			int totalPage=0; //전체 페이지 수
			int totalBlock=0;  //전체 블럭수 

			int nowPage=1; // 현재페이지
			int nowBlock=1;  //현재블럭
			  
			int start=0; //디비의 select 시작번호
			int end=10; //시작번호로 부터 가져올 select 갯수
			
			int listSize=0; //현재 읽어온 게시물의 수
			  
			List<BoardVo> vlist = null;
			
			String kwd = "", keyField = "";
			if (request.getParameter("kwd")!=null) {
				kwd = request.getParameter("kwd");
				keyField = request.getParameter("keyField");
			}
			
			if (request.getParameter("nowPage") != null) {
				nowPage = Integer.parseInt(request.getParameter("nowPage"));
				System.out.println("page: "+nowPage);
			}
			
			start = (nowPage * numPerPage)-numPerPage;
			end = numPerPage;
			Vector<BoardVo> list = dao.getList(keyField,kwd,start,end);
			totalRecord = dao.getTotalCount(keyField, kwd);
			System.out.println(list.toString());
			System.out.println("totalRecord:"+totalRecord);
			System.out.println("stat:"+start);
			System.out.println("end:"+end);
			
			totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
			nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
			totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
			
			listSize = list.size();//브라우저 화면에 보여질 게시물 번호
			
			int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
			int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1;//하단 페이지 끝번호 

			// 리스트 화면에 보내기
			request.setAttribute("start", start);
			request.setAttribute("end", end);
			request.setAttribute("totalRecord", totalRecord);
			request.setAttribute("nowPage", nowPage);
			request.setAttribute("list", list);
			request.setAttribute("kwd", kwd);
			request.setAttribute("keyField", keyField);
			request.setAttribute("numPerPage", numPerPage);
			request.setAttribute("listSize", listSize);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("pageStart", pageStart);
			request.setAttribute("pageEnd", pageEnd);
			
			//WebUtil.forward(request, response, "/WEB-INF/views/board/list.jsp");
			
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/board/list.jsp");
			rd.forward(request, response);
	    
		} else if ("read".equals(actionName)) {
			// 게시물 가져오기
			int no = Integer.parseInt(request.getParameter("no"));
			BoardDao dao = new BoardDaoImpl();
		
			BoardVo boardVo = dao.getBoard(no);
			dao.hitIncrease(boardVo);
			
			System.out.println(boardVo.toString());
			HttpSession session = request.getSession();
			session.setAttribute("vo", boardVo);
			// 게시물 화면에 보내기
			request.setAttribute("boardVo", boardVo);
			WebUtil.forward(request, response, "/WEB-INF/views/board/read.jsp");
		} else if ("modifyform".equals(actionName)) {
			// 게시물 가져오기
			int no = Integer.parseInt(request.getParameter("no"));
			BoardDao dao = new BoardDaoImpl();
			BoardVo boardVo = dao.getBoard(no);

			// 게시물 화면에 보내기
			request.setAttribute("boardVo", boardVo);
			WebUtil.forward(request, response, "/WEB-INF/views/board/modify.jsp");
		} else if ("modify".equals(actionName)) {
			// 게시물 가져오기
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			int no = Integer.parseInt(request.getParameter("no"));
			
			BoardVo vo = new BoardVo(no, title, content);
			BoardDao dao = new BoardDaoImpl();
			
			dao.update(vo);
			
			WebUtil.redirect(request, response, "/mysite/board?a=list");
		} else if ("writeform".equals(actionName)) {
			// 로그인 여부체크
			UserVo authUser = getAuthUser(request);
			if (authUser != null) { // 로그인했으면 작성페이지로
				WebUtil.forward(request, response, "/WEB-INF/views/board/writeform.jsp");
			} else { // 로그인 안했으면 리스트로
				WebUtil.forward(request, response, "/mysite/board?a=list");
			}
		} else if ("delete".equals(actionName)) {
			int no = Integer.parseInt(request.getParameter("no"));

			BoardDao dao = new BoardDaoImpl();
			dao.delete(no);

			WebUtil.redirect(request, response, "/mysite/board?a=list");
		} else if ("download".equals(actionName)) {
			 String fileName = request.getParameter("filename");
	         
	         // 서버에 올라간 경로를 가져옴
	         ServletContext context = getServletContext();
	         String uploadFilePath = "C:\\Users\\apf_temp_admin\\eclipse-workspace\\mysite\\src\\main\\webapp\\WEB-INF\\views\\fileupload";
	         String filePath = uploadFilePath + File.separator + fileName;
	         
	         System.out.println(" LOG [업로드된 파일 경로] :: " + uploadFilePath);
	         System.out.println(" LOG [파일 전체 경로] :: " + filePath);
	         
	         byte[] b = new byte[4096];
	         FileInputStream fileInputStream = new FileInputStream(filePath);
	         
	         String mimeType = getServletContext().getMimeType(filePath);
	         if(mimeType == null) {
	            mimeType = "application/octet-stream";
	         }
	         response.setContentType(mimeType);
	         
	           // 파일명 UTF-8로 인코딩(한글일 경우를 대비)
	           String sEncoding = new String(fileName.getBytes("UTF-8"),"ISO-8859-1");
	           
	           response.setHeader("Content-Disposition", "attachment; filename=\"" + sEncoding);
	           
	           // 파일 쓰기 OutputStream
	           ServletOutputStream servletOutStream = response.getOutputStream();
	           
	           int read;
	           while((read = fileInputStream.read(b,0,b.length))!= -1){
	               servletOutStream.write(b,0,read);            
	           }
	           
	           servletOutStream.flush();
	           servletOutStream.close();
	           fileInputStream.close();
		} else if ("reply".equals(actionName)) {
			String nowPage = request.getParameter("nowPage");
			request.setAttribute("nowPage", nowPage);
			String ref = request.getParameter("ref");
			request.setAttribute("ref", ref);
			String pos = request.getParameter("pos");
			request.setAttribute("pos", pos);
			String depth = request.getParameter("depth");
			request.setAttribute("depth", depth);
			String userNo = request.getParameter("userNo");
			request.setAttribute("userNo", userNo);
			System.out.println("depth:"+depth);
			WebUtil.forward(request, response, "/WEB-INF/views/board/reply.jsp");
		} else if ("replyform".equals(actionName)) {
			BoardDao dao = new BoardDaoImpl();
	        BoardVo vo = new BoardVo();
	        //1. 답변글에 대한 내용 전달 받아 저장(vo에 폼으로부터 전달되는 내용 저장)
	        vo.setTitle(request.getParameter("title"));
	        vo.setContent(request.getParameter("content"));
	        vo.setRef(Integer.parseInt(request.getParameter("ref")));
	        vo.setPos(Integer.parseInt(request.getParameter("pos")));
	        vo.setDepth(Integer.parseInt(request.getParameter("depth")));
	        vo.setUserNo(Integer.parseInt(request.getParameter("userNo")));
	        vo.setPass(request.getParameter("pass"));
	        
	        
	        //2. 답변글의 위치값 증가(이미 등록되어진 답변글의 상대위치(post)를 1씩 증가
	        dao.replyUpBoard(vo.getRef(), vo.getPos());
	        
	        //3. 답변글을 등록
	        dao.replyBoard(vo);
	        
	        //4. 현재 보고 있는 페이지로 이동
	        WebUtil.redirect(request, response, "/mysite/board?a=list");
		} else {
			WebUtil.redirect(request, response, "/mysite/board?a=list");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
		
	}

	// 로그인 되어 있는 정보를 가져온다.
	protected UserVo getAuthUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVo authUser = (UserVo) session.getAttribute("authUser");
		

		return authUser;
	}

}
