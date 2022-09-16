<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="/mysite/assets/css/user.css" rel="stylesheet" type="text/css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script>
		$(document).ready(function (){
			// 아이디체크 url : "api/emailCheck.jsp", "/mysite/user",
			$("#btn-checkid").on("click", function(){
				
				//json 형식으로 데이터 set
				var params = { a		: "idcheck"
								,	 email : $("[name=email]").val()}
				$.ajax({
					url: "/mysite/user",
					type: "post",
					data : params,
					dataType : "json",
					success : function(isExist) {
						console.log(isExist);
						if(isExist == false){
							$("#checkid-msg").text("사용할 수 있는 아이디 입니다.");
							$("#checkid-msg").css("color", "green");
						} else {
							$("#checkid-msg").text("다른 아이디로 가입해 주세요.");
							$("#checkid-msg").css("color", "red");
						}
					},
					error : function(XHR, status, error) {
						console.error(status +" : " + error);
					}
				}); // ajax
			}); //#btn-checkid.onclick
		});//ready
	</script>
	<script type="text/javascript">
	function check(){//유효성 검사
		var name = document.getElementById("name");
		var email = document.getElementById("email");
		var agreeProv = document.getElementById("agree-prov");
		var password = document.getElementsByName("password");
		if (name.value == "") {
			alert("이름을 입력해 주세요.");
			name.focus();
			return false;
		};
		if (email.value == "") {
			alert("이메일을 입력해 주세요.");
			email.focus();
			return false;
		};
		
		if(password[0].value == ""){
			alert("비밀번호를 입력해 주세요.");
			password[0].focus();
			return false;
		}
		
		if(agreeProv.checked == false){
			alert("서비스 약관에 동의해 주세요.");
			agreeProv.focus();
			return false;
		};
		
	}
	
	
	
	</script>
	<title>Insert title here</title>
</head>
<body>

	<div id="container">
		
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>
			
		<div id="wrapper">
			<div id="content">
				<div id="user">
	
					<form id="join-form" name="joinForm" method="post" action="/mysite/user" >
						<input type="hidden" name="a" value="join"/>
						<label class="block-label" for="name">이름</label>
						<input id="name" name="name" type="text" value="">
	
						<label class="block-label" for="email">이메일</label>
						<input id="email" name="email" type="text" value="">
						<input type="button" id="btn-checkid" value="id 중복체크">
						<p id="checkid-msg"></p>
						
						<label class="block-label">패스워드</label>
						<input name="password" type="password" value="">
						
						<fieldset>
							<legend>성별</legend>
							<label>여</label> <input type="radio" name="gender" value="female" checked="checked">
							<label>남</label> <input type="radio" name="gender" value="male">
						</fieldset>
						
						<fieldset>
							<legend>약관동의</legend>
							<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
							<label>서비스 약관에 동의합니다.</label>
						</fieldset>
						
						<input type="submit" value="가입하기" onClick="return check();">
						
					</form>
					
				</div><!-- /user -->
			</div><!-- /content -->
		</div><!-- /wrapper -->
		
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		
	</div> <!-- /container -->

</body>
</html>