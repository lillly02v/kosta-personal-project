<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<% pageContext.setAttribute( "newLine", "\n" ); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="/mysite/assets/css/board.css" rel="stylesheet" type="text/css">
<title>Mysite</title>
</head>
<body>
	<div id="container">
		
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>
		
		<div id="content">
			<div id="board" class="board-form">
				<table class="tbl-ex">
					<tr>
						<th colspan="2">글보기</th>
					</tr>
					<tr>
						<td class="label">제목</td>
						<td>${boardVo.title }</td> <%-- servlet에서 setAttribute한 값 받아오기 --%>
					</tr>
					<tr>
						<td class="label">내용</td>
						<td>
							<div class="view-content">
								${fn:replace(boardVo.content, newLine, "<br>")}
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">첨부파일</td>
						<td>
							<c:choose>
								<c:when test="${not empty boardVo.filename1}"> <%-- empty - 객체의 값이 null 또는 빈값인지 물어보는 연산자 --%>
									<a href="/mysite/board?a=download&filename=${boardVo.filename1 }">${boardVo.filename1 }</a>
									&nbsp;&nbsp;<font color="blue">(${boardVo.filesize1 }KBytes)</font>  
								</c:when>
								<c:otherwise>
  		 							등록된 파일이 없습니다.
  		 						</c:otherwise>
  		 					</c:choose>
						</td>
					</tr>
					<tr>
						<td class="label">첨부파일</td>
						<td>
							<c:choose>
								<c:when test="${not empty boardVo.filename2}">
									<a href="/mysite/board?a=download&filename=${boardVo.filename2 }">${boardVo.filename2 }</a>
									&nbsp;&nbsp;<font color="blue">(${boardVo.filesize2 }KBytes)</font> 
								</c:when>
								<c:otherwise>
  		 							등록된 파일이 없습니다.
  		 						</c:otherwise>
  		 					</c:choose>
						</td>
					</tr>
				</table>
				<div class="bottom">
					<a href="/mysite/board">글목록</a>
					
					<c:if test="${authUser.no == boardVo.userNo }"> <%-- 로그인한 사용자와 게시판 글쓴 사람이 같으면 글수정 버튼 보이기 --%>
						<a href="/mysite/board?a=modifyform&no=${boardVo.no }&nowPage=${param.nowPage}&pass=${boardVo.pass}">글수정</a>
					</c:if>
					<c:if test="${authUser.no != null}"> <%-- 로그인한 유저가 있다면 답변 버튼 보이기 --%>
						<a href="/mysite/board?a=reply&nowPage=${param.nowPage}&ref=${boardVo.ref}&depth=${boardVo.depth}&pos=${boardVo.pos}&userNo=${boardVo.userNo}" >답 변</a>
					</c:if>
				</div>
			</div>
		</div>

		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		
	</div><!-- /container -->
</body>
</html>		
		
