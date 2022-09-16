<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

		<div id="header">
			<h1>MySite</h1>
			<ul>
				<c:choose><!-- jstl문법. if, else와 같다 -->
					<c:when test="${authUser == null }"> <!-- session에 저장된 변수authUser를 가져와서 null과 비교.(el의 기본객체는 requestScope,sessionScope등이 있는데, scope.변수에서 scope를 생략하면 작은 영역순으로 변수를 찾는다(request에서 찾고 없으면 session, 없으면 application순으로)) -->
						<!-- 로그인 전 -->
						<li><a href="/mysite/user?a=loginform">로그인</a></li> <!-- UserServlet에 actionName이 loginform인 if로 이동 -->
						<li><a href="/mysite/user?a=joinform">회원가입</a></li>
					</c:when>
					<c:otherwise>
						<!-- 로그인 후 -->
						<li><a href="/mysite/user?a=modifyform">회원정보수정</a></li>
						<li><a href="/mysite/user?a=logout">로그아웃</a></li> 
						<li> ${authUser.name }님 안녕하세요^^;</li>
					</c:otherwise>
				</c:choose>
				
			</ul>
		</div> <!-- /header -->