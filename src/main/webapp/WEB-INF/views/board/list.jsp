<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.kosta.hsm.dao.BoardDaoImpl"%>
<%@ page import="com.kosta.hsm.dao.BoardDao"%>
<%@ page import="com.kosta.hsm.vo.BoardVo"%>
<%@ page import="com.kosta.hsm.vo.UserVo"%>
<%@page import="java.util.*"%>

<%	
	  request.setCharacterEncoding("UTF-8");
	  
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

	String kwd = "", keyField = "";
	  
	List<BoardVo> vlist = null;
	kwd = String.valueOf(request.getAttribute("kwd"));
	keyField = String.valueOf(request.getAttribute("keyField"));
	
	String st = String.valueOf(request.getAttribute("start"));
	if(st!=null){
		start = Integer.parseInt(st);
	}
	String ed = String.valueOf(request.getAttribute("end"));
	if(ed!=null){
		end = Integer.parseInt(ed);
	}
	String nowPg = String.valueOf(request.getAttribute("nowPage"));
	if(nowPg!=null){
		nowPage = Integer.parseInt(nowPg);
	}
	String totalRc = String.valueOf(request.getAttribute("totalRecord"));
	if(totalRc!=null){
		totalRecord = Integer.parseInt(totalRc);
	}
	
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="/mysite/assets/css/board.css" rel="stylesheet" type="text/css">
<title>Mysite</title>
</head>
<script>
	
	
	function check() {
	     if (document.search_form.kwd.value == "") {
			alert("검색어를 입력하세요.");
			document.search_form.kwd.focus();
			return;
	     }
	  document.search_form.submit();
	 }
	
</script>
<body>
	<div id="container">
		
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>
		
		<div id="content">
			<div id="board">
				<form id="search_form" name="search_form" action="/mysite/board" method="post">
					<input type="hidden" name="a" value="list"/>
					<select name="keyField" size="1" >
	    				<option value="name">글쓴이</option>
	    				<option value="title">제 목</option>
	    				<option value="content">내 용</option>
	    				<option value="reg_date">작성일</option>
	   				</select>
					<input type="text" id="kwd" name="kwd" value="" >
					<input type="hidden" name="nowPage" value="1">
					<input type="submit" value="찾기" onClick="javascript:check()">
				</form>
				<%
				vlist = (List)request.getAttribute("list");
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물 번호
				  if (vlist.isEmpty()) {
					out.println("등록된 게시물이 없습니다.");
				  } else {
				%>
				<table class="tbl-ex">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>&nbsp;</th>
					</tr>		
					<%
						  for (int i = 0;i<numPerPage; i++) {
							if (i == listSize) break;
							BoardVo vo = vlist.get(i);
							int no = vo.getNo();
							String name = vo.getUserName();
							int hit = vo.getHit();
							String title = vo.getTitle();
							String regdate = vo.getRegDate();
							int depth = vo.getDepth();
							int userNo = vo.getUserNo();
					%>		
						<tr>
							<td align="center">
							<%=totalRecord-((nowPage-1)*numPerPage)-i%>
							</td>
							<td>
							<%
							  if(depth>0){
								for(int j=0;j<depth;j++){
									out.println("&nbsp;&nbsp;");
									}
									out.print("ㄴ");
								}
							%>
								<a href="/mysite/board?a=read&no=<%=no%>&nowPage=<%=nowPage%>"><%=title %></a>
							</td>
							<td><%=name %></td>
							<td><%=hit %></td>
							<td><%=regdate %></td>
							<td>
								<% 	UserVo authUser = (UserVo)session.getAttribute("authUser");
									if(authUser!=null){
										int nom = authUser.getNo();
										if(nom == userNo){%>
								
									<a href="/mysite/board?a=delete&no=<%=no %>" class="del">삭제</a>
								<%		}
									}%>
							</td>
						</tr>
						<%}//for%>
				</table><%
 			}//if
 		%>
				<div class="pager">
					<ul>
						
			<!-- 페이징 및 블럭 처리 Start--> 
			<%
   				  int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
   				  int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1; 
   				  //하단 페이지 끝번호
   				  	if(totalPage !=0){
    			  	if (nowPage > 1) {%>
    			  		<%if(kwd ==""||kwd == null){%>
    			  		<a href="/mysite/board?a=list&nowPage=<%=nowPage-1%>">◀</a>&nbsp; 
    			  		<%} else { %>
    			  		<a href="/mysite/board?a=list&nowPage=<%=nowPage-1%>&kwd=<%=kwd%>&keyField=<%=keyField%>">◀</a>
    			  		<%} }%>
    			  		<%for ( ; pageStart < pageEnd; pageStart++){%>
    			  		<%if(kwd ==""||kwd == null){%>
     			     	<a href="/mysite/board?a=list&nowPage=<%=pageStart %>"> 
     					<%if(pageStart==nowPage) {%><font color="blue"> <%}%>
     					[<%=pageStart %>] 
     					<%if(pageStart==nowPage) {%></font> <%}%></a> 
     					<%} else { %>
     					<a href="/mysite/board?a=list&nowPage=<%=pageStart%>&kwd=<%=kwd%>&keyField=<%=keyField%>">
     					<%if(pageStart==nowPage) {%><font color="blue"> <%}%>
     					[<%=pageStart %>] 
     					<%if(pageStart==nowPage) {%></font> <%}%></a> 
     					<%} %>
    					<%}//for%>&nbsp; 
    					<%if (totalPage > nowPage ) {%>
    					<%if(kwd ==""||kwd == null){%>
    					<a href="/mysite/board?a=list&nowPage=<%=nowPage+1%>">▶</a>
    					<%} else { %>
    					<a href="/mysite/board?a=list&nowPage=<%=nowPage+1%>&kwd=<%=kwd%>&keyField=<%=keyField%>">▶</a>
    					<%} %>
    				<%}%>&nbsp;  
   				<%}%>
 				<!-- 페이징 및 블럭 처리 End-->
					</ul>
				</div>				
				<c:if test="${authUser != null }">
					<div class="bottom">
						<a href="/mysite/board?a=writeform" id="new-book">글쓰기</a>
					</div>
				</c:if>				
			</div>
		</div>
		<form name="readFrm" method="get" action="/mysite/board">
			<input type="hidden" name="no"> 
			<input type="hidden" name="a">
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="keyField" value="<%=keyField %>>" > 
			<input type="hidden" name="keyWord" value="<%=kwd%>">
		</form>
		
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		
	</div><!-- /container -->
</body>
</html>		
		
