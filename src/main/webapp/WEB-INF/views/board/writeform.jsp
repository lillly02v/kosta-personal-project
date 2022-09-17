<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
			<div id="board">
				<form class="board-form" method="post" action="/mysite/upload" enctype="multipart/form-data"> <!-- enctype는 폼 데이터가 서버로 제출될 때 해당 데이터가 인코딩되는 방법. method가 post인 경우에만 사용가능. multipart/form-data 파일이나 이미지를 서버로 전송  -->
					<table class="tbl-ex">
						<tr>
							<th colspan="2">글쓰기</th>
						</tr>
						<tr>
							<td class="label">제목</td>
							<td><input type="text" name="title" id="title" value=""></td>
						</tr>
						<tr>
							<td class="label">내용</td>
							<td>
								<textarea id="content" name="content"></textarea>
							</td>
						</tr>
						<tr>
     						<td>파일찾기</td> 
     						<td><input type="file" name="filename1" size="50" maxlength="50"></td>
    					</tr>
    					<tr>
     						<td>파일찾기</td> 
     						<td><input type="file" name="filename2" size="50" maxlength="50"></td>
    					</tr>
					</table>
					<div class="bottom">
						<a href="/mysite/board">취소</a>
						<input type="submit" value="등록">
					</div>
				</form>				
			</div>
		</div>

		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		
	</div><!-- /container -->
</body>
</html>		
		
