<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
    <center>
        <h2>답변글 입력하기</h2>
 
        <form action="/mysite/board" method="post">
        	<input type="hidden" name="a" value="replyform"/>
            <!-- 답변글 처리 페이지로 자료를 전달 -->
            <table width="600" border="1" bordercolor="gray" bgcolor="#EEE" style="border-collapse:collapse">
 
                <tr height="40">
                    <td width="150" align="center">제목</td>
                    <td width="450">
                    	<input type="text" name="title" value="[답변]${sessionScope.vo.title}" size="60"> <%-- (BoardVo)session.getAttribute("vo").getTitle() --%>
                    </td>
                </tr>
 
                <tr height="40">
                    <td width="150" align="center">비밀번호</td>
                    <td width="450">
                    	<input type="password" name="pass"size="60">
                    </td>
                </tr>
 
                <tr height="40">
                    <td width="150" align="center">글내용</td>
                    <td width="450">
                    	<textarea rows="10" cols="60" name="content">${sessionScope.vo.content}
========답변 글을 쓰세요.=======
                    	</textarea>
                    </td>
                </tr>
                <%-- form에서 사용자로부터 입력 받지 않고 데이터를 넘김 --%>
                <tr height="40">
                    <%-- 각 데이터에 맞는 버튼을 만들어준다. --%>
                    <td align="center" colspan="2">
                        <input type="submit" value="답글쓰기완료">
                        &nbsp;&nbsp; 
                        <input type="reset" value="다시쓰기"> &nbsp;&nbsp;
                        <input type="button" onclick="location.href='/mysite/board'"value="전체글보기">
                    </td>
                    <%-- 리스트 화면으로 돌아가는 버튼 --%>
                </tr>
 
            </table>
            <input type="hidden" name="nowPage" value="${nowPage}"> <%-- (String)request.getAttribute("nowPage") servlet에서 jsp로 값 전달받기 --%>
        	<input type="hidden" name="ref" value="${ref}">        
        	<input type="hidden" name="pos" value="${pos}">       
        	<input type="hidden" name="depth" value="${depth}">
        	<input type="hidden" name="userNo" value="${sessionScope.authUser.no}"> <%-- (UserVo)session.getAttribute("authUser").getNo() --%>
        </form>
    </center>
</body>
</html>
