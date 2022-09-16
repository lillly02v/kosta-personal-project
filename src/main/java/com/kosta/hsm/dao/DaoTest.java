package com.kosta.hsm.dao;

import java.util.List;

import com.kosta.hsm.vo.BoardVo;

public class DaoTest {

	public static void main(String[] args) {
		BoardDao dao = new BoardDaoImpl();
		
		//삽입insert
		BoardVo vo = new BoardVo();
		vo.setNo(0);
		vo.setTitle("테스트");
		vo.setContent("테스트입니다");
		vo.setUserNo(1);
		vo.setFilename1("1");
		vo.setFilesize1(0);
		vo.setFilename2("2");
		vo.setFilesize2(0);
		
		int count = dao.insert(vo);
		System.out.println(count + "건 insert 완료");
	    System.out.println(dao.getList("","",0,3));
	    
	    //삭제 delete
	    count = dao.delete(70);
	    System.out.println(count + "건 delete 완료");
	    System.out.println(dao.getList("","",0,3));
	    
	    //수정 update
	    vo.setNo(69);
	    vo.setTitle("수정테스트");
	    vo.setContent("수정테스트 입니다.");
	    count =dao.update(vo);
	    System.out.println(count + "건 update 완료");
	    System.out.println(dao.getList("","",0,3));
		
		//검색 search
		List<BoardVo> list = dao.getList("name","홍",1,8);
	    System.out.println(list.toString());
	    
	}

}
