<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
				<c:choose>
					<c:when test="${empty requestScope.list}">
						등록된 게시물이 없습니다.
					</c:when>
					<c:otherwise>
						<table class="tbl-ex">
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>글쓴이</th>
								<th>조회수</th>
								<th>작성일</th>
								<th>&nbsp;</th>
							</tr>		
							<c:set var="done_loop" value="false" />
							<c:forEach items="${requestScope.list}" begin="0" end="${requestScope.numPerPage -1}" varStatus="status">
								<c:if test="${not done_loop}">
									<c:if test="${status.index eq requstScope.listSize}">
										<c:set var="done_loop" value="true"/>
									</c:if>
									<tr>
										<td align="center">
											<c:set var="total" value="${requestScope.nowPage-1}"/>
											<c:set var="multiply" value="${total * requestScope.numPerPage}"/>
											${requestScope.totalRecord-multiply-status.index}
										</td>
										<td>
											<c:if test="${requestScope.list[status.index].depth>0}">
												<c:forEach var="j" begin="0" end="${requestScope.list[status.index].depth}">
													&nbsp;&nbsp;
												</c:forEach>
												ㄴ
											</c:if>
											<a href="/mysite/board?a=read&no=${requestScope.list[status.index].no}&nowPage=${requestScope.nowPage}">${requestScope.list[status.index].title}</a>
										</td>
										<td>${requestScope.list[status.index].userName}</td>
										<td>${requestScope.list[status.index].hit}</td>
										<td>${requestScope.list[status.index].regDate}</td>
										<td>
											<c:if test="${sessionScope.authUser ne null}">
												<c:if test="${sessionScope.authUser.no eq  requestScope.list[status.index].userNo}">
													<a href="/mysite/board?a=delete&no=${requestScope.list[status.index].no}" class="del">삭제</a>
												</c:if>
											</c:if>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</table>
					</c:otherwise>
				</c:choose>
				
				<%-- 페이징 및 블럭 처리 Start--%> 
				
				<div class="pager">
					<ul>
						
						<c:if test="${requestScope.totalPage ne 0}">
							<c:if test="${requestScope.nowPage > 1}">
								<c:choose>
									<c:when test="${empty requestScope.kwd}">						
										<a href="/mysite/board?a=list&nowPage=${requestScope.nowPage-1}">◀</a>&nbsp; 
    			  					</c:when>
    			  					<c:otherwise>
    			  						<a href="/mysite/board?a=list&nowPage=${requestScope.nowPage-1}&kwd=${requestScope.kwd}&keyField=${requestScope.keyField}">◀</a>
    			  					</c:otherwise>
    			  				</c:choose>
    			  			</c:if>
    			  			
    			  			
    			  			
   			  				<c:set var="doneLoop" value="false" />
   			  				<c:set var="pageStart" value="${requestScope.pageStart}" />
   			  				<c:forEach var="k" begin="0" end="${requestScope.pageEnd}" step="1">
   			  					<c:if test="${not doneLoop}">
   			  						<c:choose>
	   			  						<c:when test="${empty requestScope.kwd}">
	   			  							<a href="/mysite/board?a=list&nowPage=${pageStart}">
	   			  								<c:if test="${pageStart eq requestScope.nowPage}">
	   			  									 <font color="blue">
	   			  								</c:if>
	   			  								[${pageStart}]
	   			  								<c:if test="${pageStart eq requestScope.nowPage}">
	   			  									 </font>
	   			  								</c:if>
	   			  							</a>
	   			  						</c:when>
	   			  						<c:otherwise>
	   			  							<a href="/mysite/board?a=list&nowPage=${pageStart}&kwd=${requestScope.kwd}&keyField=${requestScope.keyField}">
	   			  								<c:if test="${pageStart eq requestScope.nowPage}">
	   			  									<font color="blue">
	   			  								</c:if>
	   			  								[${pageStart}]
	   			  								<c:if test="${pageStart eq requestScope.nowPage}">
	   			  									 </font>
	   			  								</c:if>
	   			  							</a>
	   			  						</c:otherwise>
   			  						</c:choose>
   			  									 	
   			  						<c:if test="${pageStart ge requestScope.pageEnd}">
   			  							<c:set var="doneLoop" value="true"/>
   			  						</c:if>
   			  						<c:set var="pageStart" value="${pageStart+1}"/>
   			  					</c:if>
   			  				</c:forEach>
    			  						
    			  						
    			  						
		    			  		<c:if test="${requestScope.totalPage >  requestScope.nowPage}">
									<c:choose>
										<c:when test="${empty requestScope.kwd}">				    			  							
		    								<a href="/mysite/board?a=list&nowPage=${requestScope.nowPage+1}">▶</a>
		    							</c:when>
		    							<c:otherwise>
		    								<a href="/mysite/board?a=list&nowPage=${requestScope.nowPage+1}&kwd=${requestScope.kwd}&keyField=${requestScope.keyField}">▶</a>
		    							</c:otherwise>
		    						</c:choose>
		    					</c:if>
		    			</c:if>
	 				
					</ul>
				</div>	
				<%-- 페이징 및 블럭 처리 End--%>			
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
			<input type="hidden" name="nowPage" value="${requestScope.nowPage}"> 
			<input type="hidden" name="keyField" value="${requestScope.keyField}>" > 
			<input type="hidden" name="keyWord" value="${requestScope.kwd}>">
		</form>
		
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		
	</div><%-- /container --%>
</body>
</html>		
		
