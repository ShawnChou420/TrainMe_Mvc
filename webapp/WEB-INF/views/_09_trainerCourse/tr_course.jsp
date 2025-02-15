<!DOCTYPE html>
<html lang="en">
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>學員-我的課程</title>
<link rel="stylesheet" href="<c:url value='/css/style.css' />">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous" />
<link rel="stylesheet" href="<c:url value='/css/style_nav.css' />">
<link rel="stylesheet" href="<c:url value='/css/style_st_lesson.css' />">
<link rel="stylesheet" href="<c:url value='/css/style_st_info.css' />">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

<!-- 暫時代替側邊選單點擊變色的功能的CSS -->
<style>
.aside ul li:nth-child(3) a {
	color: #21d4a7;
}
</style>
</head>
<body>

	<!-- ============上方導覽列======================================================= -->
	<jsp:include page="/fragment/nav_tr.jsp" />



	<div class="container">

		<!-- ============左側選單======================================================= -->
		<jsp:include page="/fragment/sidebar_tr.jsp" />

		<!-- ============右側網頁======================================================= -->


		<!-- ============個人資料======================================================= -->

		<div class="content">
			<div class="title">
				<h3>我的課程</h3>
			</div>

			<!-- ============即將開始的課程======================================================= -->

			<div class="info_wrap t lesson">

				<ul class="nav nav-tab mb-3" id="pills-tab" role="tablist">
				
					<li class="nav-item mr-4" role="presentation"><a
						class="nav-link li_color active" id="pills-next-tab" data-toggle="pill"
						href="#pills-next" role="tab" aria-controls="pills-next"
						aria-selected="true">已預約的學員</a></li>
						
					<li class="nav-item mr-4" role="presentation"><a
						class="nav-link li_color " id="pills-wait-tab"
						data-toggle="pill" href="#pills-wait" role="tab"
						aria-controls="pills-wait" aria-selected="true">發出預約的學員</a></li>
						
						
					<li class="nav-item " role="presentation"><a
						class="nav-link li_color" id="pills-history-tab"
						data-toggle="pill" href="#pills-history" role="tab"
						aria-controls="pills-history" aria-selected="true">歷史課程的學員 </a></li>
				</ul>

				<div class="tab-content mt-3" id="pills-tabContent">
					<!-- 已預約的學員 -->
					<div class="tab-pane fade show active" id="pills-next"
						role="tabpanel" aria-labelledby="pills-next-tab">
						<table class="table border b_c">
							<thead class="thead">
								<tr>
									<th scope="col" class="class_name">上課學員</th>
									<th scope="col">課程名稱</th>
									<th scope="col">預約課程時段</th>
								</tr>
							</thead>
							<tbody class="tr_height">
								<c:forEach varStatus="i" begin="0"
									end="${StudentCourse.size()-1}">
									<c:if
										test="${StudentCourse.get(i.current).getIs_allowed()== 1 && StudentCourse.get(i.current).getDate()> Now }">
										<tr>
											<td class="class_name">${StudentCourse.get(i.current).getStudentBean_H().getName()}</td>
											<td>${StudentCourse.get(i.current).getTrainerCourseBean_H().getSkillBean_H().getName()}</td>
											<td>${StudentCourse.get(i.current).getDate()}

												${StudentCourse.get(i.current).getTime()}:00 -
												${StudentCourse.get(i.current).getTime() + 1}:00</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- 發出預約的學員 -->
					<div class="tab-pane fade" id="pills-wait" role="tabpanel"
						aria-labelledby="pills-wait-tab">
						<table class="table border">
							<thead class="thead">
								<tr>
									<th scope="col" class="class_name">上課學員</th>
									<th scope="col">課程名稱</th>
									<th scope="col">預約課程時段</th>
									<th scope="col">是否同意</th>
								</tr>
							</thead>
							<tbody class="tr_height">
								<c:forEach varStatus="i" begin="0"
									end="${StudentCourse.size()-1}">
									<c:if
										test="${StudentCourse.get(i.current).getIs_allowed()== 0 && StudentCourse.get(i.current).getIs_delete()==0 &&StudentCourse.get(i.current).getDate()> Now}">
										<tr>
											<td class="class_name">${StudentCourse.get(i.current).getStudentBean_H().getName()}</td>
											<td>${StudentCourse.get(i.current).getTrainerCourseBean_H().getSkillBean_H().getName()}</td>
											<td>${StudentCourse.get(i.current).getDate()}

												${StudentCourse.get(i.current).getTime()}:00 -
												${StudentCourse.get(i.current).getTime() + 1}:00</td>
											<td><a
												href="/TrainMe/AllowStudentCourse/${LoginOK.id}?courseId=${StudentCourse.get(i.current).getId()}&type=comingSoon"
												class="allow" data-type="comingSoon">同意</a> <a
												href="/TrainMe/CancelStudentCourse/${LoginOK.id}?courseId=${StudentCourse.get(i.current).getId()}&type=waitCourse"
												class="cancel" data-type="waitCourse">取消</a></td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- 歷史課程的學員 -->
					<div class="tab-pane fade" id="pills-history" role="tabpanel"
						aria-labelledby="pills-history-tab">
						<table class="table border">
							<thead class="thead">
								<tr>
									<th scope="col" class="class_name">上課學員</th>
									<th scope="col">課程名稱</th>
									<th scope="col">預約課程時段</th>
									<th scope="col">上課日誌</th>
								</tr>
							</thead>
							<tbody class="tr_height">
								<c:forEach varStatus="i" begin="0"
									end="${StudentCourse.size()-1}">
									<c:if
										test="${StudentCourse.get(i.current).getIs_allowed()== 1 && StudentCourse.get(i.current).getDate()< Now  }">
										<tr>
											<td class="class_name">${StudentCourse.get(i.current).getStudentBean_H().getName()}</td>
											<td>${StudentCourse.get(i.current).getTrainerCourseBean_H().getSkillBean_H().getName()}</td>
											<td>${StudentCourse.get(i.current).getDate()}

												${StudentCourse.get(i.current).getTime()}:00 -
												${StudentCourse.get(i.current).getTime() + 1}:00</td>
											<td><a
												href="<c:url value='/st_Course_diary/${StudentCourse.get(i.current).getId()}' />"><i
													class="fas fa-book"></i></a></td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>







			</div>




		</div>
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
			integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
			crossorigin="anonymous"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
			crossorigin="anonymous"></script>
		<script>
	//選單點選變色(待補)
	
	
	var changeTab = null;
	//頁籤


	$('#pills-tab a').on('click', function(event) {
		event.preventDefault()
		console.log(this);
		$(this).tab('show')
	})

	// 確認是否取消通知
	$('.cancel').on('click', function(event) {
		var yes = confirm('是否確定取消課程？');
		if (!yes) {
			event.preventDefault();
		}
		console.log(this.dataset.type);
		changeTab = this.dataset.type;
	})
// 		console.log("${type.equals('comingSoon')}");
	
	// 確認是否同意通知
	$('.allow').on('click', function(event) {
		var yes = confirm('是否確定同意課程？');
		if (!yes) {
			event.preventDefault();
		}
		console.log(this.dataset.type);
		changeTab = this.dataset.type;
	})

	<c:if test="${type.equals('comingSoon')}">
// 				console.log("111111111");
				$('#pills-next-tab').tab('show')	
	</c:if>
	<c:if test="${type.equals('waitCourse')}">
				$('#pills-wait-tab').tab('show')			
	</c:if>
	
</script>
</body>
</html>