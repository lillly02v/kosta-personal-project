drop table BOARD;
drop sequence seq_board_no;

CREATE TABLE board (
  no	    NUMBER,
  title 	VARCHAR2(500),
  content   VARCHAR2(4000),
  hit       NUMBER,
  reg_date  DATE,
  user_no   NUMBER,
  depth NUMBER,
  pos NUMBER,
  ref NUMBER,
  filename1 varchar(500),
  filesize1 NUMBER,
  filename2 varchar(500),
  filesize2 NUMBER,
  pass varchar(15),
  PRIMARY KEY(no),
  CONSTRAINT c_board_fk FOREIGN KEY (user_no) 
  REFERENCES users(no)
);

CREATE SEQUENCE seq_board_no
INCREMENT BY 1 
START WITH 1 ;

insert into board
values (seq_board_no.nextval, '첫번째 제목', '첫번째 내용', 0 , '2022-09-01', 1, 0, 0, 1, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '두번째 제목', '두번째 내용', 0 , '2022-09-01', 1, 0, 0, 2, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '세번째 제목', '세번째 내용', 0 , '2022-09-01', 1, 0, 0, 3, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '네번째 제목', '네번째 내용', 0 , '2022-09-01', 2, 0, 0, 4, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '다섯번째 제목', '다섯번째 내용', 0 , '2022-09-02', 2, 0, 0, 5, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '여섯번째 제목', '여섯번째 내용', 0 , '2022-09-02', 2, 0, 0, 6, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '일곱번째 제목', '일곱번째 내용', 0 , '2022-09-02', 2, 0, 0, 7, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '여덟번째 제목', '여덟번째 내용', 0 , '2022-09-02', 2, 0, 0, 8, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '아홉번째 제목', '아홉번째 내용', 0 , '2022-09-02', 2, 0, 0, 9, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '열번째 제목', '열번째 내용', 0 , '2022-09-02', 2, 0, 0, 10, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '열한번째 제목', '열한번째 내용', 0 , '2022-09-03', 3, 0, 0, 11, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '열두번째 제목', '열두번째 내용', 0 , '2022-09-03', 3, 0, 0, 12, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '열세번째 제목', '열세번째 내용', 0 , '2022-09-03', 3, 0, 0, 13, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '열네번째 제목', '열네번째 내용', 0 , '2022-09-03', 3, 0, 0, 14, NULL, NULL, NULL, NULL, null);

insert into board
values (seq_board_no.nextval, '열다섯번째 제목', '열다섯번째 내용', 0 , '2022-09-03', 3, 0, 0, 15, NULL, NULL, NULL, NULL, null);