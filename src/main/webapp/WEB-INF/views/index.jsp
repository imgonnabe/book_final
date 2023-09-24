<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--  
    Document Title
    =============================================
    -->
<title>우리동네 | 동네북</title>
<!--  
    Favicons
    =============================================
    -->
<link rel="apple-touch-icon" sizes="57x57"
	href="assets/images/favicons/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60"
	href="assets/images/favicons/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72"
	href="assets/images/favicons/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76"
	href="assets/images/favicons/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114"
	href="assets/images/favicons/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120"
	href="assets/images/favicons/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144"
	href="assets/images/favicons/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152"
	href="assets/images/favicons/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180"
	href="assets/images/favicons/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"
	href="assets/images/favicons/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="assets/images/favicons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="assets/images/favicons/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="assets/images/favicons/favicon-16x16.png">
<link rel="manifest" href="assets/images/favicons/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage"
	content="assets/images/favicons/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">
<!--  
    Stylesheets
    =============================================
    -->
<!-- Default stylesheets-->
<link href="assets/lib/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Template specific stylesheets-->
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Volkhov:400i"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800"
	rel="stylesheet">
<link href="assets/lib/animate.css/animate.css" rel="stylesheet">
<link href="assets/lib/components-font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="assets/lib/et-line-font/et-line-font.css" rel="stylesheet">
<link href="assets/lib/flexslider/flexslider.css" rel="stylesheet">
<link href="assets/lib/owl.carousel/dist/assets/owl.carousel.min.css"
	rel="stylesheet">
<link
	href="assets/lib/owl.carousel/dist/assets/owl.theme.default.min.css"
	rel="stylesheet">
<link href="assets/lib/magnific-popup/dist/magnific-popup.css"
	rel="stylesheet">
<link href="assets/lib/simple-text-rotator/simpletextrotator.css"
	rel="stylesheet">
<!-- Main stylesheet and color file-->
<link href="assets/css/style.css" rel="stylesheet">
<link id="color-scheme" href="assets/css/colors/default.css" rel="stylesheet">

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="./js//jquery-3.7.0.min.js"></script>
<script type="text/javascript">

function kakaoLogout(){
	location.href="https://kauth.kakao.com/oauth/logout?client_id=3ecca13d973c6d11e752a114a1e14922&logout_redirect_uri=http://localhost/logout/kakao";
	window.location.href = "/logout";
}
function naverLogout(){
	let Npopup = window.open("https://nid.naver.com/nidlogin.logout", "_blank", "width=500, height=500");
	
	Npopup.addEventListener("load", function() {
	    
		// 팝업 창의 현재 URL 확인
	    let currentUrl = Npopup.location.href;
	    
	    // 원하는 URL 조건에 따라 팝업 창을 닫음
	    if (currentUrl.includes("www.naver.com")) {
	        Npopup.close();
	    }
	});

	// 팝업 창을 닫는 함수 실행
	setTimeout(function() {
	    if (Npopup) {
	        Npopup.close();
	    }
	}, 3000);
	
	window.location.href = "/logout";
}


	$(function(){
	
		let sid = getCookie("SuserID");
		let setS = getCookie("setS");
		let setY = getCookie("setY");
		
		// 로그아웃버튼 클릭
		$("#logoutbtn").click(function(){
			Logout();
		});
		
		// 자동로그인 해제버튼 클릭
		$("#outauto").click(function(){
			autoLogout();
		});
		
		// 쿠키 삭제
		function delCookie(cookieName){
			let expireDate = new Date();
			expireDate.setDate(expireDate.getDate() - 1);
			document.cookie = cookieName +"="+ "; expires="+ expireDate.toUTCString()
		}
		
		// 쿠키가져오기
		function getCookie(cookieName){
			let cname, cvalue;
			let val = document.cookie.split(";");
			for(let i = 0; i < val.length; i++){
				cname = val[i].substr(0, val[i].indexOf("="));
				cvalue = val[i].substr(val[i].indexOf("=")+1);
				cname = cname.trim();
				
				if(cname == cookieName){
					return cvalue;
				}
			}
		}
		
		// 로그아웃 진행
		function Logout(){
			
			if(${sessionScope.withN eq 2}){	// 네이버로그아웃 이후 로그아웃실행 
				alert("네이버로그아웃하자");
				naverLogout();
			} else if(${sessionScope.withK eq 1}){ // 카카오로그아웃 이후 로그아웃실행 
				kakaoLogout();
			} 
				window.location.href = "/logout";	// 일반로그아웃
			
		}
		
		// 자동로그인 해제 진행
		function autoLogout(){

			// auto가 1이라면 0으로 변경
			$.ajax({
				url : "./autologout",
				type : "post",
				data : {sid : sid},
					dataType : "json",
					success : function(data) {
						if(data.result == 1){
							alert("자동로그인이 해제되었습니다.")
							delCookie("SuserID");
							delCookie("setS");
							Logout();
						}
					},
					error : function(error) {
						alert("에러발생");
						}
				});
		}
		
		
	});

</script>


<!-- --------------------------------------------------- 상단 ---------------------------------------------------------------- -->

</head>
<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<%@ include file="menu.jsp"%>
	<main>
	
	<div class="main">
       <hr class="divider-w">
        <section class="module-small">
          <div class="container">

          </div>
        </section>
          <div class="container">
           <h1>첫 화면</h1>
              
          </div>
        <hr class="divider-w">
        
        
        <hr class="divider-w">
        
        <section class="module">
        <div class="container">
        	<div>
			<button type="button" id="logoutbtn">
				로그아웃
			</button>
			<span>id가 세션에 있음 떠라 : ${sessionScope.mid}</span>
		</div>
		
	  	<div>
         	<c:choose>
           		<c:when test="${sessionScope.mid ne null}"> id : ${sessionScope.mid} _ 로그인완</c:when>
            	<c:otherwise>로그아웃상태 </c:otherwise>
         	</c:choose>
      	</div>
      	
      <!-- 마이페이지에 들어갈 예정 -->
      	<div>
      		<button type="button" id="outauto">자동로그인 해제</button>
      	</div>
          
          </div>
        </section>
	
	
	
	
			


			<!-- --------------------------------------------------- 하단 풋---------------------------------------------------------------- -->
			<div class="module-small bg-dark">
				<div class="container">
					<div class="row">
						<div class="col-sm-3">
							<div class="widget">
								<h5 class="widget-title font-alt">About Titan</h5>
								<p>The languages only differ in their grammar, their
									pronunciation and their most common words.</p>
								<p>Phone: +1 234 567 89 10</p>
								Fax: +1 234 567 89 10
								<p>
									Email:<a href="#">somecompany@example.com</a>
								</p>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="widget">
								<h5 class="widget-title font-alt">Recent Comments</h5>
								<ul class="icon-list">
									<li>Maria on <a href="#">Designer Desk Essentials</a></li>
									<li>John on <a href="#">Realistic Business Card Mockup</a></li>
									<li>Andy on <a href="#">Eco bag Mockup</a></li>
									<li>Jack on <a href="#">Bottle Mockup</a></li>
									<li>Mark on <a href="#">Our trip to the Alps</a></li>
								</ul>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="widget">
								<h5 class="widget-title font-alt">Blog Categories</h5>
								<ul class="icon-list">
									<li><a href="#">Photography - 7</a></li>
									<li><a href="#">Web Design - 3</a></li>
									<li><a href="#">Illustration - 12</a></li>
									<li><a href="#">Marketing - 1</a></li>
									<li><a href="#">Wordpress - 16</a></li>
								</ul>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="widget">
								<h5 class="widget-title font-alt">Popular Posts</h5>
								<ul class="widget-posts">
									<li class="clearfix">
										<div class="widget-posts-image">
											<a href="#"><img src="assets/images/rp-1.jpg"
												alt="Post Thumbnail" /></a>
										</div>
										<div class="widget-posts-body">
											<div class="widget-posts-title">
												<a href="#">Designer Desk Essentials</a>
											</div>
											<div class="widget-posts-meta">23 january</div>
										</div>
									</li>
									<li class="clearfix">
										<div class="widget-posts-image">
											<a href="#"><img src="assets/images/rp-2.jpg"
												alt="Post Thumbnail" /></a>
										</div>
										<div class="widget-posts-body">
											<div class="widget-posts-title">
												<a href="#">Realistic Business Card Mockup</a>
											</div>
											<div class="widget-posts-meta">15 February</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<hr class="divider-d">
			<footer class="footer bg-dark">
				<div class="container">
					<div class="row">
						<div class="col-sm-6">
							<p class="copyright font-alt">
								&copy; 2017&nbsp;<a href="index.html">TitaN</a>, All Rights
								Reserved
							</p>
						</div>
						<div class="col-sm-6">
							<div class="footer-social-links">
								<a href="#"><i class="fa fa-facebook"></i></a><a href="#"><i
									class="fa fa-twitter"></i></a><a href="#"><i
									class="fa fa-dribbble"></i></a><a href="#"><i
									class="fa fa-skype"></i></a>
							</div>
						</div>
					</div>
				</div>
			</footer>
		</div>
		<div class="scroll-up">
			<a href="#totop"><i class="fa  fa-chevron-up"></i></a>
		</div>
	</main>
	<!--  
    JavaScripts
    =============================================
    -->
	<script src="../assets/lib/jquery/dist/jquery.js"></script>
	<script src="../assets/lib/bootstrap/dist/js/bootstrap.min.js"></script>
	<script src="../assets/lib/wow/dist/wow.js"></script>
	<script
		src="../assets/lib/jquery.mb.ytplayer/dist/jquery.mb.YTPlayer.js"></script>
	<script src="../assets/lib/isotope/dist/isotope.pkgd.js"></script>
	<script src="../assets/lib/imagesloaded/imagesloaded.pkgd.js"></script>
	<script src="../assets/lib/flexslider/jquery.flexslider.js"></script>
	<script src="../assets/lib/owl.carousel/dist/owl.carousel.min.js"></script>
	<script src="../assets/lib/smoothscroll.js"></script>
	<script
		src="../assets/lib/magnific-popup/dist/jquery.magnific-popup.js"></script>
	<script
		src="../assets/lib/simple-text-rotator/jquery.simple-text-rotator.min.js"></script>
	<script src="../assets/js/plugins.js"></script>
	<script src="../assets/js/main.js"></script>
</body>
</html>