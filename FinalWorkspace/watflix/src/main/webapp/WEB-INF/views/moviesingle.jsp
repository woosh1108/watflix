<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<!--[if IE 7]>
<html class="ie ie7 no-js" lang="en-US">
<![endif]-->
<!--[if IE 8]>
<html class="ie ie8 no-js" lang="en-US">
<![endif]-->
<!--[if !(IE 7) | !(IE 8)  ]><!-->
<html lang="en" class="no-js">
<head>
<!-- Basic need -->
<title>Open Pediatrics</title>
<meta charset="UTF-8">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="author" content="">
<link rel="profile" href="#">

<!--Google Font-->
<link rel="stylesheet"
	href='http://fonts.googleapis.com/css?family=Dosis:400,700,500|Nunito:300,400,600' />
<!-- Mobile specific meta -->
<meta name=viewport content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone-no">

<!-- CSS files -->
<link rel="stylesheet" href="/watflix/css/plugins.css">
<link rel="stylesheet" href="/watflix/css/style.css">

<!-- Share script -->
<script type="text/javascript">
	var urllink = "http://localhost:8088/watflix/movie/movie-info?movie_no="
			+ $
	{
		movie.movie_no
	}
	+"&user_no=1";

	function shareToFacebook() {
		alert("facebook");
		var url = encodeURIComponent(urllink);
		var facebookShareUrl = 'https://www.facebook.com/sharer/sharer.php?u='
				+ url;
		window.open(facebookShareUrl, '_blank');
	}

	function shareToTwitter() {
		var url = encodeURIComponent(urllink);
		var twitterShareUrl = 'https://twitter.com/intent/tweet?url=' + url;
		window.open(twitterShareUrl, '_blank');
	}

	function shareToLine() {
		var url = encodeURIComponent(urllink);
		var lineShareUrl = 'https://social-plugins.line.me/lineit/share?url='
		url;
		window.open(lineShareUrl, '_blank');
	}

	function copyToClipboard() {
		var textarea = document.createElement("textarea");
		textarea.value = urllink;
		document.body.appendChild(textarea);
		textarea.select();
		document.execCommand("copy");
		document.body.removeChild(textarea);
	}
</script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	//sign-up 패스워드 체크
	$(document).ready(function() {
		$("#repassword-2").on("keyup", function() {
			const queryData = {
				"pass" : $("#password-2").val(),
				"repass" : $("#repassword-2").val()
			}
			$.ajax({
				url : "/watflix/sign-up/passChk",
				type : "post",
				data : JSON.stringify(queryData),
				contentType : "application/json",
				success : success_run,
				error : error_run
			});
		});
	});
	function success_run(msg) {
		if (msg == "비밀번호가 다릅니다") {
			$("#passChkMsg").text(msg).css('color', 'red');
		} else {
			$("#passChkMsg").text(msg).css('color', 'green');
		}

	}
	function error_run(obj, msg, statusmsg) {
		alert("obj : " + obj + " " + "msg : " + msg + " " + "statusmsg : "
				+ statusmsg);
	}
</script>
<script type="text/javascript">
	//login용
	$(document).ready(function() {
		$(".login-content button").on("click", function() {
			const queryData = {
				"email" : $("#login-email").val(),
				"pass" : $("#login-pass").val()
			}
			$.ajax({
				url : "/watflix/view/login.do",
				type : "post",
				data : JSON.stringify(queryData),
				contentType : "application/json",
				success : success_run,
				error : error_run
			});
		});
	});
	function success_run(msg) {
		if (msg == "아이디/비밀번호가 다릅니다") {
			$("#loginChkMsg").text(msg).css('color', 'red');
		} else {
			window.location.href = "/watflix/main";
		}

	}
	function error_run(obj, msg, statusmsg) {
		alert("obj : " + obj + " " + "msg : " + msg + " " + "statusmsg : "
				+ statusmsg);
	}
</script>
</head>
<body>
	<!--preloading-->
	<div id="preloader">
		<img class="logo" src="/watflix/images/logo1.png" alt="" width="119"
			height="58">
		<div id="status">
			<span></span> <span></span>
		</div>
	</div>
	<!--end of preloading-->
	<!--login form popup-->
	<div class="login-wrapper" id="login-content">
		<div class="login-content">
			<a href="#" class="close">x</a>
			<h3>Login</h3>

			<div class="row">
				<label for="email"> EMAIL: <input type="email" name="email"
					id="login-email" placeholder="hugh@email.com" required="required" />
				</label>
			</div>

			<div class="row">
				<!-- 비번 input태그에 추가할것pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" -->
				<label for="pass"> Password: <input type="password"
					name="pass" id="login-pass" placeholder="******"
					required="required" />
				</label>
				<div id="loginChkMsg"></div>

			</div>
			<div class="row">
				<div class="remember">
					<div>
						<input type="checkbox" name="remember" value="Remember me"><span>Remember
							me</span>
					</div>
					<a href="#">Forget password ?</a>
				</div>
			</div>
			<div class="row">
				<button type="submit">Login</button>
			</div>
			<div class="row">
				<p>Or via social</p>
				<div class="social-btn-2">
					<a class="fb" href="#"><i class="ion-social-facebook"></i>Facebook</a>
					<a class="tw" href="#"><i class="ion-social-twitter"></i>twitter</a>
				</div>
			</div>
		</div>
	</div>
	<!--end of login form popup-->
	<!--signup form popup-->
	<div class="login-wrapper" id="signup-content">
		<div class="login-content">
			<a href="#" class="close">x</a>
			<h3>sign up</h3>
			<form method="post" action="/watflix/view/register.do">
				<div class="row">
					<label for="username-2"> Username: <input type="text"
						name="username" id="username-2" placeholder="Hugh Jackman"
						required="required" />
					</label>
				</div>

				<div class="row">
					<label for="email-2"> your email: <input type="email"
						name="email" id="email-2" placeholder="" required="required" />
					</label>
				</div>
				<div class="row">
					<label for="password-2"> Password: <input type="password"
						name="pass" id="password-2" placeholder="" required="required" />
					</label>
				</div>
				<div class="row">
					<label for="repassword-2"> re-type Password: <input
						type="password" name="password" id="repassword-2" placeholder=""
						required="required" />
						<div id="passChkMsg">></div>
					</label>
				</div>
				<div class="row">
					<button type="submit">sign up</button>
				</div>
			</form>
		</div>
	</div>
	<!--end of signup form popup-->

	<!-- BEGIN | Header -->

	<header class="ht-header">
		<div class="container">
			<nav class="navbar navbar-default navbar-custom">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header logo">
					<div class="navbar-toggle" data-toggle="collapse"
						data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<div id="nav-icon1">
							<span></span> <span></span> <span></span>
						</div>
					</div>
					<a href="index_light.html"><img class="logo"
						src="/watflix/images/logo1.png" alt="" width="119" height="58"></a>
				</div>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse flex-parent"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav flex-child-menu menu-left">
						<li class="hidden"><a href="#page-top"></a></li>
						<li class="dropdown first"><a
							class="btn btn-default dropdown-toggle lv1"
							data-toggle="dropdown"> Home <i class="fa fa-angle-down"
								aria-hidden="true"></i>
						</a>
							<ul class="dropdown-menu level1">
								<li><a href="index_light.html">Home 01</a></li>
							</ul></li>
						<li class="dropdown first"><a
							class="btn btn-default dropdown-toggle lv1"
							data-toggle="dropdown" data-hover="dropdown"> movies<i
								class="fa fa-angle-down" aria-hidden="true"></i>
						</a>
							<ul class="dropdown-menu level1">
								<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown">Movie grid<i
										class="ion-ios-arrow-forward"></i></a></li>
							</ul></li>


						<li class="dropdown first"><a
							class="btn btn-default dropdown-toggle lv1"
							data-toggle="dropdown" data-hover="dropdown"> community <i
								class="fa fa-angle-down" aria-hidden="true"></i>
						</a>
							<ul class="dropdown-menu level1">
								<li><a
									href="/watflix/user/my-favorite?user_no=${sessionScope.loginuser.user_no }">user
										favorite grid</a></li>
								<li><c:choose>
										<c:when test="${sessionScope.loginuser != null }">
											<a href="/watflix/user/user-profile">user profile</a></li>
								</c:when>
								<c:otherwise>
									<a class="moveToProfile">user profile</a></li>
						<script type="text/javascript">
							$(document)
									.ready(
											function() {
												var moveToProfile = $(".moveToProfile");
												var loginct = $("#login-content");
												var loginWrap = $(".login-wrapper");
												var overlay = $(".overlay");
												moveToProfile
														.on(
																'click',
																function(event) {
																	event
																			.preventDefault();
																	loginct
																			.parents(
																					overlay)
																			.addClass(
																					"openform");
																	$(document)
																			.on(
																					'click',
																					function(
																							e) {
																						var target = $(e.target);
																						if ($(
																								target)
																								.hasClass(
																										"overlay")) {
																							$(
																									target)
																									.find(
																											loginct)
																									.each(
																											function() {
																												$(
																														this)
																														.removeClass(
																																"openform");
																											});
																							setTimeout(
																									function() {
																										$(
																												target)
																												.removeClass(
																														"openform");
																									},
																									350);
																						}
																					});
																});
											})
						</script>
						</c:otherwise>
						</c:choose>

						<li class="it-last"><a
							href="/watflix/user/my-reviewed?user_no=${sessionScope.loginuser.user_no }">user
								rate</a></li>
					</ul>
					</li>
					</ul>
					<ul class="nav navbar-nav flex-child-menu menu-right">

						<li><a href="#">Help</a></li>
						<c:choose>
							<c:when test="${sessionScope.loginuser == null}">
								<li class="loginLink"><a href="#">LOG IN</a></li>
								<li class="btn signupLink"><a href="#">sign up</a></li>
							</c:when>
							<c:otherwise>
								<li class="logout"><a href="/watflix/user/logout.do">LOG
										OUT</a></li>
							</c:otherwise>

						</c:choose>

					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</nav>

			<!-- top search form -->

			<div class="top-search">
				<input type="text" name="search"
					placeholder="Search for a movie, TV Show or celebrity that you are looking for">
			</div>
			<script type="text/javascript">
				const input = document.querySelector('input[name="search"]');
				input
						.addEventListener(
								'keydown',
								function(event) {
									if (event.keyCode === 13) { // enter key
										const keyword = event.target.value;
										window.location.href = '/watflix/search-result?keyword='
												+ keyword;
									}
								});
			</script>
		</div>
	</header>
	<!-- END | Header -->

	<div class="buster-light">
		<div class="hero mv-single-hero">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<!-- <h1> movie listing - list</h1>
            <ul class="breadcumb">
               <li class="active"><a href="#">Home</a></li>
               <li> <span class="ion-ios-arrow-right"></span> movie listing</li>
            </ul> -->
					</div>
				</div>
			</div>
		</div>
		<div class="page-single movie-single movie_single">
			<div class="container">
				<div class="row ipad-width2">
					<div class="col-md-4 col-sm-12 col-xs-12">
						<div class="movie-img sticky-sb">
							<img src="${movie.movie_image}" alt="">
							<div class="movie-btn">
								<div class="btn-transform transform-vertical red">
									<div>
										<a href="#" class="item item-1 redbtn"> <i
											class="ion-play"></i> Watch Trailer
										</a>
									</div>
									<div>
										<a href="https://www.youtube.com/embed/o-0hcF97wy0"
											class="item item-2 redbtn fancybox-media hvr-grow"><i
											class="ion-play"></i></a>
									</div>
								</div>
								<div class="btn-transform transform-vertical">
									<div>
										<a href="#" class="item item-1 yellowbtn"> <i
											class="ion-card"></i> Buy ticket
										</a>
									</div>
									<div>
										<a href="#" class="item item-2 yellowbtn"><i
											class="ion-card"></i></a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-8 col-sm-12 col-xs-12">
						<div class="movie-single-ct main-content">
							<h1 class="bd-hd">${movie.movie_title}<span>${fn:substring(movie.release_date,0,4)}</span>
							</h1>
							<div class="social-btn">

								<c:choose>
									<c:when test="${not empty dibs}">
										<a
											href="/watflix/dibs/delete?movie_no=${movie.movie_no}&user_no=1"
											class="parent-btn"><i class="ion-heart"></i> delete to
											Favorite</a>

									</c:when>
									<c:otherwise>
										<a
											href="/watflix/dibs/insert?movie_no=${movie.movie_no}&user_no=1"
											class="parent-btn"><i class="ion-heart"></i> Add to
											Favorite</a>


									</c:otherwise>
								</c:choose>
								<div class="hover-bnt">
									<a href="#" class="parent-btn"><i
										class="ion-android-share-alt"></i>share</a>
									<div class="hvr-item">
										<a href="#" class="hvr-grow" onclick="shareToFacebook()">
											<i class="ion-social-facebook"></i>
										</a> <a href="#" class="hvr-grow" onclick="shareToTwitter()">
											<i class="ion-social-twitter"></i>
										</a> <a href="#" class="hvr-grow" onclick="shareToLine()"> <i
											class="ion-social-googleplus"></i>
										</a> <a href="#" class="hvr-grow" onclick="copyToClipboard()">
											<i class="ion-social-youtube"></i>
										</a>
									</div>
								</div>

							</div>
							<div class="movie-rate">
								<div class="rate">
									<i class="ion-android-star"></i>
									<p>
										<span>${reviewAvg}</span> /5<br> <span class="rv">56
											Reviews</span>
									</p>
								</div>
								<div class="rate-star">
									<p>Rate This Movie:</p>
									<c:set var="reviewAvg" value="${reviewAvg}"></c:set>
									<c:set var="score" value="${Math.floor(reviewAvg)}"></c:set>
									<c:forEach begin="1" end="5" varStatus="loop">
										<c:choose>
											<c:when test="${loop.index <= score}">
												<i class="ion-ios-star"></i>
											</c:when>
											<c:otherwise>
												<i class="ion-ios-star-outline"></i>
											</c:otherwise>
										</c:choose>
									</c:forEach>

								</div>
							</div>
							<div class="movie-tabs">
								<div class="tabs">
									<ul class="tab-links tabs-mv">
										<li class="active"><a href="#overview">Overview</a></li>
										<li><a href="#reviews"> Reviews</a></li>
										<li><a href="#cast"> Cast & Crew </a></li>
										<li><a href="#media"> Media</a></li>
									</ul>
									<div class="tab-content">
										<div id="overview" class="tab active">
											<div class="row">
												<div class="col-md-8 col-sm-12 col-xs-12">
													<p>${movie.movie_summary}</p>
													<div class="title-hd-sm">
														<h4>Videos & Photos</h4>
													</div>
													<div class="mvsingle-item ov-item">
														<c:forEach var="stillcut" items="${stillcutlist}">
															<a class="img-lightbox" data-fancybox-group="gallery"
																href="${stillcut.stillcut_image}"><img
																src="${stillcut.stillcut_image}" alt=""></a>
														</c:forEach>

													</div>
													<div class="title-hd-sm">
														<h4>cast</h4>
													</div>
													<!-- movie cast -->
													<c:forEach var="casting" items="${castinglist}">
														<div class="mvcast-item">
															<div class="cast-it">
																<div class="cast-left">
																	<img src="${casting.casting_image}" alt="" width="40px"
																		height="40px"> <a href="#">${casting.casting_name}</a>
																	<p>${casting.casting_job}</p>
																</div>
															</div>
														</div>
													</c:forEach>
													<div class="title-hd-sm">
														<h4>User reviews</h4>
													</div>
													<!-- movie user review -->
													<div class="mv-user-review-item">
														<h3>${myReviewList[0].review_title}</h3>
														<div class="no-star">
															<c:set var="rating" value="${myReviewList[0].rating}"></c:set>
															<c:set var="score" value="${Math.floor(rating)}"></c:set>
															<c:forEach begin="1" end="5" varStatus="loop">
																<c:choose>
																	<c:when test="${loop.index <= score}">
																		<i class="ion-android-star"></i>
																	</c:when>
																	<c:otherwise>
																		<i class="ion-android-star last"></i>
																	</c:otherwise>
																</c:choose>
															</c:forEach>

														</div>
														<p class="time">${myReviewList[0].review_date}by
															${myReviewList[0].user.email }</p>
														<p>${myReviewList[0].review_content }</p>
													</div>
												</div>
												<div class="col-md-4 col-xs-12 col-sm-12">
													<div class="sb-it">
														<h6>Run Time:</h6>
														<p>
															<a href="#">${movie.runningtime}</a>
														</p>
													</div>
													<div class="sb-it">
														<h6>Viewing Age:</h6>
														<p>
															<a href="#">${movie.age}</a>
														</p>
													</div>
													<div class="sb-it">
														<h6>Release Date:</h6>
														<p>
															<a href="#">${fn:substring(movie.release_date,0,10)}</a>
														</p>
													</div>
													<div class="sb-it">
														<h6>Country:</h6>
														<p>
															<a href="#">${movie.country}</a>
														</p>
													</div>
													<div class="sb-it">
														<h6>Genres:</h6>
														<p class="tags">
															<span class="time"><a href="#">${movie.genre}</a></span>
														</p>
													</div>
												</div>
											</div>
										</div>
										<div id="reviews" class="tab review">
											<div class="row">
												<div class="rv-hd">
													<div class="div">
														<h3>Related Movies To</h3>
														<h2>${movie.movie_title}</h2>
													</div>
													<a
														href="/watflix/review/write?movie_no=${movie.movie_no}&user_no=${sessionScope.loginuser.user_no}"
														class="redbtn">Write Review</a>
												</div>
												<c:forEach var="review" items="${reviewlist}">
													<div class="mv-user-review-item">
														<div class="user-infor">
															<img src="/watflix/images/uploads/userava1.jpg" alt="">
															<div>
																<h3>${review.review_title}</h3>
																<div class="no-star">
																	<c:set var="rating" value="${review.rating}"></c:set>
																	<c:set var="score" value="${Math.floor(rating)}"></c:set>
																	<c:forEach begin="1" end="5" varStatus="loop">
																		<c:choose>
																			<c:when test="${loop.index <= score}">
																				<i class="ion-android-star"></i>
																			</c:when>
																			<c:otherwise>
																				<i class="ion-android-star last"></i>
																			</c:otherwise>
																		</c:choose>
																	</c:forEach>
																</div>
																<p class="time">${review.review_date}by
																	${review.user.email}</p>
															</div>
														</div>
														<p>${review.review_content}</p>
													</div>
												</c:forEach>

											</div>
										</div>
										<div id="cast" class="tab">
											<div class="row">
												<h3>Cast & Crew of</h3>
												<h2>${movie.movie_title}</h2>
												<!-- //== -->
												<div class="title-hd-sm">
													<h4>Cast</h4>
												</div>
												<div class="mvcast-item">
													<c:forEach var="casting" items="${castinglist}">
														<div class="cast-it">
															<div class="cast-left">
																<img src="${casting.casting_image}" alt="" width="40px"
																	height="40px"> <a href="#">${casting.casting_name}</a>
															</div>
															<p>${casting.casting_job}</p>
														</div>
													</c:forEach>
												</div>
											</div>
										</div>
										<div id="media" class="tab">
											<div class="row">
												<div class="rv-hd">
													<div>
														<h3>Videos & Photos of</h3>
														<h2>${movie.movie_title}</h2>
													</div>
												</div>
												<div class="title-hd-sm">
													<h4>Photos</h4>
												</div>
												<div class="mvsingle-item">
													<c:forEach var="stillcut" items="${stillcutlist}">
														<a class="img-lightbox" data-fancybox-group="gallery"
															href="${stillcut.stillcut_image}"><img
															src="${stillcut.stillcut_image}" alt=""></a>
													</c:forEach>
												</div>
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer section-->
	<footer class="ht-footer">
		<div class="container">
			<div class="flex-parent-ft">
				<div class="flex-child-ft item1">
					<a href="index.html"><img class="logo"
						src="/watflix/images/logo1.png" alt=""></a>
					<p>
						5th Avenue st, manhattan<br> New York, NY 10001
					</p>
					<p>
						Call us: <a href="#">(+01) 202 342 6789</a>
					</p>
				</div>
				<div class="flex-child-ft item2">
					<h4>Resources</h4>
					<ul>
						<li><a href="#">About</a></li>
						<li><a href="#">Blockbuster</a></li>
						<li><a href="#">Contact Us</a></li>
						<li><a href="#">Forums</a></li>
						<li><a href="#">Blog</a></li>
						<li><a href="#">Help Center</a></li>
					</ul>
				</div>
				<div class="flex-child-ft item3">
					<h4>Legal</h4>
					<ul>
						<li><a href="#">Terms of Use</a></li>
						<li><a href="#">Privacy Policy</a></li>
						<li><a href="#">Security</a></li>
					</ul>
				</div>
				<div class="flex-child-ft item4">
					<h4>Account</h4>
					<ul>
						<li><a href="#">My Account</a></li>
						<li><a href="#">Watchlist</a></li>
						<li><a href="#">Collections</a></li>
						<li><a href="#">User Guide</a></li>
					</ul>
				</div>
				<div class="flex-child-ft item5">
					<h4>Newsletter</h4>
					<p>
						Subscribe to our newsletter system now <br> to get latest
						news from us.
					</p>
					<form action="#">
						<input type="text" placeholder="Enter your email...">
					</form>
					<a href="#" class="btn">Subscribe now <i
						class="ion-ios-arrow-forward"></i></a>
				</div>
			</div>
		</div>
		<div class="ft-copyright">
			<div class="ft-left">
				<p>© 2017 Blockbuster. All Rights Reserved. Designed by leehari.</p>
			</div>
			<div class="backtotop">
				<p>
					<a href="#" id="back-to-top">Back to top <i
						class="ion-ios-arrow-thin-up"></i></a>
				</p>
			</div>
		</div>
	</footer>
	<!-- end of footer section-->

	<script src="/watflix/js/jquery.js"></script>
	<script src="/watflix/js/plugins.js"></script>
	<script src="/watflix/js/plugins2.js"></script>
	<script src="/watflix/js/custom.js"></script>
</body>
</html>