<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    table {
    border-collapse: collapse;
    width: 100%;
    margin: 13px 0 37px 0;
    text-align: center;
  }
  
  caption {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
    text-align: center;
  }
  
  th,
  td {
    height: 50px;
    padding: 10px;
    border: 1px solid #c4c4c4;
  }

  th {
    background-color: #eee;
    font-weight: bold;
    font-size: 18px;
  }
  
  td {
    font-size: 15px;
  }

form {
  display: flex;
  justify-content: center;
}

select, input{
  text-align: center;
  padding: 5px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

button {
  background-color: #9cd3f4;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

</style>
</head>
<body>

	<jsp:include page="common/header.jsp"/>
	
	<div class="container">
	    <div class="sub08_title">
	      <ul style="text-align: center; margin-top: 40px">
	        <li class="title"><h2 class="text-uppercase mt-15" style="font-size: 30px; font-weight: bold;">Q & A</h2></li>
	        <li class="class"><p class="lead" style="margin-bottom: 0%;">자바(JAVA)기반 공공데이터 융합 개발자 양성과정A</p></li>
	        <li class="classroom"><p class="mb-15">2022. 10. 18 ~ 2023. 05. 19 09:00~15:30 (김시연 강사)</p></li>
	      </ul>
	    </div> 
	   <c:if test="${not empty loginUser.id and loginUser.id eq q.boardWriter }">
	    <div align="right">
	      <!-- 수정하기, 삭제하기 버튼은 이글이 본인글일 경우만 보여져야됨 -->
	        <a class="btn btn-primary" onclick="">수정하기</a> <!-- 요기에 href="" 를 작성하면 get방식이기 떄문에 노출된다. -->
	        <a class="btn btn-danger" onclick="">삭제하기</a>
	    </div>
	   </c:if>
	    <div class="entry-content">
	      <table id="contentArea" align="center" class="table" style="margin-top: 10px;">
	        <tr>
	            <th style="text-align: center;">제목</th>
	            <td colspan="3" style="text-align: left;">${ q.boardTitle }</td>
	        </tr>
	        <tr>
	            <th width="10%" style="text-align: center;">작성자</th>
	            <td width="40%" style="text-align: left;">${ q.boardWriter }</td>
	            <th width="10%" style="text-align: center;">작성일</th>
	            <td width="40%" style="text-align: left;">${ q.createDate }</td>
	        </tr>
	        <tr>
	            <td colspan="4">
	              <div style="padding: 50px; font-size: 18px; line-height: 2;">
	                <p style="height:auto">${ q.boardContent }</p>
	              </div>
	            </td>
	        </tr>
	    </table>
	    
	    <table id="replyArea" class="table" align="center" style="margin: 0; border-top: 1px solid #dae0e9;">
	      <thead>
	        <tr>
	          <th colspan="3" style="font-size: 10px; text-align: left; height: 10px;">
	            등록통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글은 관리자에 의해 사전 통보없이 삭제될 수 있습니다.
	          </th>
	        </tr>
	        <tr>
	            <th colspan="2">
	                <textarea class="form-control" name="" id="content" cols="55" rows="2" style="resize:none; width:100%"></textarea>
	            </th>
	            <th style="vertical-align: middle; text-align: center;">
	              <button type="button" class="btn btn-default" style="height: 100%; width: 100%; background-color: #e6f4fd;" onclick="addReply();">등록하기</button>
	            </th>
	        </tr>
	      </thead>
	      <tbody>
	      </tbody>
	     </table>
	     <div style="text-align: center; margin: 50px;">
	      <a href="boardList.st" class="btn btn-gray btn-theme-colored btn-circled"><i class="fa fa-home"></i> 목록으로</a>
	    </div> 
    </div>       
  </div>
  
  
  	<!-- 댓글 -->
  	<script>
    	$(function() {
			selectReplyList(); // 화면이 랜더링 되자마다 댓글 조회를 하겠다
		})
		
		function addReply() { // 댓글작성용 ajax
			if ($("#content").val().trim().length != 0) { // 유효한 댓글 작성시 => insert ajax 요청
				
				$.ajax({
					url: "rinsert.bo",
					data: {
						boardNo: ${ q.boardNo},
						replyContent: $("#content").val(),
						replyWriter: '${ loginUser.id }' // 문자열은 이렇게 묶어야함
					}, 
					success: function(status) {
						if (status == "success") {
							selectReplyList(); // 등록 버튼 클릭시 리스트 조회
							$("#content").val(""); // 댓글창에 작성한 댓글 초기화
						}
					},
					error: function() {
						console.log("댓글 작성용 ajax 통신 실패!");
					}
				})
			} else {
				alertify.alert("댓글 작성 후 등록 요청해주세요!");
			} 
		}
		
		function selectReplyList() { // 해당 게시글에 달린 댓글리스트 조회용 ajax
			$.ajax({
				url: "rlist.bo",
				data: {qno: ${ q.boardNo }},
				success: function(list) {
					console.log(list);
					
					let value = "";
					
					for ( let i in list) {
						value += "<tr>"
							   + "<th style='text-align: center; width: 15%'>" + list[i].replyWriter + "</th>"
							   + "<td style='text-align: left;'>" + list[i].replyContent + "</td>"
							   + "<td>" + list[i].replyDate + "</td>"
							   + "</tr>";
					}
					
					$("#replyArea tbody").html(value);
				},
				error: function() {
					console.log("댓글 리스트 조회용 ajax 통신 실패!");
				}
			});
		}
    </script>
  <jsp:include page="common/footer.jsp"/>
</body>
</html>