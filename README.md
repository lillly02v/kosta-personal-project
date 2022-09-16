# mysite 프로젝트
### 초기설정
_
<br>
#### 데이터베이스 설정
_
<
users.sql.홍소미.sql, board.sql.홍소미.sql, guestbook.sql.홍소미.sql dBeaver에서 실행
<br>
#### fileupload 폴더 경로 변경
_
1. 이클립스에서 mysite/src/main/webapp/WEB-INF/views/fileupload 디렉토리 - 마우스 오른쪽 클릭 - properties - 경로 복사<br>
2. Java Resources/src/main/java/com.kosta.hsm.controller/FileUnloadServlet.java 2군데, Java Resources/src/main/java/com.kosta.hsm.controller/BoardServlet.java에서 1군데(
```
else if("download".equals(actionName)){
```
else if문 안의 소스  부분) 복사한 경로로 수정
