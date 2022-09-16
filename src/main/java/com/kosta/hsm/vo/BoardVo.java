package com.kosta.hsm.vo;

public class BoardVo {
	private int no;
	private String title;
	private String content;
	private int hit;
	private String regDate;
	private int userNo;
	private String userName;
	private int depth;
	private int count;  
	private int pos;
	private int ref;
	private String filename1;
	private long filesize1;
	private String filename2;
	private long filesize2;
	private String pass;
	
	
	public BoardVo(int no, String title, String content) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
	}

	public BoardVo() {
		super();
	}

	public BoardVo(String title, String content, int userNo, String filename1, long filesize1, String filename2, long filesize2) {
		this.title = title;
		this.content = content;
		this.userNo = userNo;
		this.filename1 = filename1;
		this.filesize1 = filesize1;
		this.filename2 = filename2;
		this.filesize2 = filesize2;
	}
	

	public BoardVo(int no, String title, String content, int hit, String regDate, int userNo, String userName, int ref, int pos, int depth, String filename1, int filesize1, String filename2, int filesize2, String pass) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.hit = hit;
		this.regDate = regDate;
		this.userNo = userNo;
		this.userName = userName;
		this.ref =ref;
		this.pos =pos;
		this.depth = depth;
		this.filename1 = filename1;
		this.filesize1 = filesize1;
		this.filename2 = filename2;
		this.filesize2 = filesize2;
		this.pass = pass;
	}
	
	

	public BoardVo(int no, String title, int hit, String regDate, int userNo, String userName) {
		super();
		this.no = no;
		this.title = title;
		this.hit = hit;
		this.regDate = regDate;
		this.userNo = userNo;
		this.userName = userName;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPos() {
		return pos;
	}

	public void setPos(int pos) {
		this.pos = pos;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public String getFilename1() {
		return filename1;
	}

	public void setFilename1(String filename1) {
		this.filename1 = filename1;
	}

	public long getFilesize1() {
		return filesize1;
	}

	public void setFilesize1(long filesize1) {
		this.filesize1 = filesize1;
	}

	public String getFilename2() {
		return filename2;
	}

	public void setFilename2(String filename2) {
		this.filename2 = filename2;
	}

	public long getFilesize2() {
		return filesize2;
	}

	public void setFilesize2(long filesize2) {
		this.filesize2 = filesize2;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	@Override
	public String toString() {
		return "BoardVo [no=" + no + ", title=" + title + ", content=" + content + ", hit=" + hit + ", regDate="
				+ regDate + ", userNo=" + userNo + ", userName=" + userName + ", depth=" + depth + ", count=" + count
				+ ", pos=" + pos + ", ref=" + ref + ", filename1=" + filename1 + ", filesize1=" + filesize1 + "]";
	}

	
	
	
}
