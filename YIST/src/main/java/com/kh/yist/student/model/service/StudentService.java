package com.kh.yist.student.model.service;

import java.util.ArrayList;

import com.kh.yist.common.model.vo.PageInfo;
import com.kh.yist.student.model.vo.Exam;
import com.kh.yist.student.model.vo.Material;
import com.kh.yist.student.model.vo.Notice;
import com.kh.yist.student.model.vo.QnA;
import com.kh.yist.student.model.vo.Task;

public interface StudentService {

	ArrayList<Notice> mainNotice();
	
	ArrayList<Exam> testList();
	

	Exam testDetail(int examNo);
	
	int noticeListCount();
	
	ArrayList<Notice> selectList(PageInfo pi);
	
	Notice selectNotice(int boardNo);
	
	int boardListCount();
	
	ArrayList<Material> boardList(PageInfo pi);
	
	ArrayList<Material> MaterialList();
	
	ArrayList<Task> taskList();
	
	Task selectTask(int taskNo);
	
	Task selectTaskReply(int taskNo);
	
	int deleteTask(int taskNo);
	
	ArrayList<QnA> qnaList();
	
	int taskInsert(Task t);
	

}
