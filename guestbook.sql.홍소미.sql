drop TABLE GUESTBOOK;
drop sequence seq_guestbook_no;

CREATE TABLE guestbook (
  no		NUMBER,
  name		VARCHAR2(80),
  password	VARCHAR2(20),
  content	VARCHAR(2000),
  reg_date	date,
  PRIMARY KEY(no)	
);


CREATE SEQUENCE seq_guestbook_no
INCREMENT BY 1 
START WITH 1 ;

insert into guestbook
values (seq_guestbook_no.nextval, '정종욱', '1234', '첫번째 내용' , '2022-09-01');

insert into guestbook
values (seq_guestbook_no.nextval, '이효리', '1234', '두번째 내용' , '2022-09-02');

insert into guestbook
values (seq_guestbook_no.nextval, '홍소미', '1234', '세번째 내용' , '2022-09-03');