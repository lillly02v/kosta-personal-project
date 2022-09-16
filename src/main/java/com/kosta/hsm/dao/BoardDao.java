package com.kosta.hsm.dao;

import java.util.*;


import com.kosta.hsm.vo.BoardVo;

public interface BoardDao {
	public Vector<BoardVo> getList(String keyField, String keyWord,int start, int end);  // 게시물 전체 목록 조회
	public BoardVo getBoard(int no); // 게시물 상세 조회
	public int insert(BoardVo vo);   // 게시물 등록
	public int delete(int no);       // 게시물 삭제
	public int update(BoardVo vo);   // 게시물 수정
	public void hitIncrease(BoardVo boardVo);
	public int getTotalCount(String keyField, String keyWord);
	public List<BoardVo> search(String kwd);
	public void replyUpBoard(int ref, int pos);
	public void replyBoard(BoardVo rebean);
}
