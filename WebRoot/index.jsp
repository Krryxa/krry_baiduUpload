<%@ page import="com.krry.dao.BaiduDao"%>
<%@ page import="com.krry.entity.FileList"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	List<FileList> fl = BaiduDao.getFiles();
	request.setAttribute("files", fl);
%>
<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title>云盘上传系统 --krry</title>
		<meta name="keywords" content="关键词,关键词">
		<meta name="description" content="">
		
		<link type="text/css" rel="stylesheet" href="js/upload/upload.css"/>
		<link type="text/css" rel="stylesheet" href="js/sg/css/sg.css" />
		<style type="text/css">
			*{margin:0;padding:0;}
			body{font-size:12px;font-family:"微软雅黑";color:#666;}
			img{border:none;display:block;}

			/*top start*/
			.top{width:100%; min-width: 1200px;height:70px;background:#252525;box-shadow: 0px 0px 15px 3px #000;}
			.top .t_header{width:95%;height:70px;margin:0 auto;}
			.top .t_header .t_logo{float:left;}
			.top .t_header .t_desc{float:right;font-size:20px;line-height:70px;}
			/*end top*/

			/*tools start*/
			.tools{width:95%;height:40px;margin:30px auto 20px;}
			.tools .t_upload{width:120px;height:36px;display:block;background:#69F;font-size:14px;text-align:center;line-height:36px;color:#fff;cursor: pointer;border-radius:3px;}
			.tools .t_upload:hover{background:#66F;}
			/*end tools*/
			
			/*files start*/
			.files{min-height: 334px;width:95%;margin:0px auto 70px;}
			.files table{width:100%;border-collapse:collapse;}
			.files table thead tr .filelook{width:15%;}
			.files table thead tr .filename{width:35%;}
			.files table thead tr .filesize{width:15%;}
			.files table thead tr .filestime{width:20%;}
			.files table thead tr .filesfunc{width:15%;}
			.files table thead tr td{line-height:40px;background:#D9D9D9;border-bottom:1px solid #E3E3E3;font-size:14px;font-weight:bold;padding-left:10px;}
			.files table tbody tr td{line-height:45px;border-bottom:1px solid #E3E3E3;padding-left:10px;}
			.files table tbody tr:hover{background:#F3F3F3;}
			
			.f_item a{text-decoration:none;transition:.4s;}
			.f_item a:hover{color:#ff1d1d;transition:.4s;}
			/*end files*/
			
			.footer{background: #313131;border-top: 1px solid #111;position:relative;bottom:0;min-width:1200px;margin-top:50px;height:139px; width: 100%;}
			.footer .content{width:960px;height:67px;margin:36px auto;line-height:23px;text-align:center;color:#656363;font-size:13px;}
			.footer .content .footerate{color:#656363;}
			.footer .content .footerate:hover{color:#fff;}
			
			.blamnc{margin:70px;display:none;}
			.blamnc .blanks{line-height:87px;color:#ef5f5f;text-align:center;font-size:36px;font-family: fantasy;}
		</style>
	
	</head>
<body>
	
	<!--top start-->
	<div class="top">
		<div class="t_header">
			<div class="t_logo">
				<a href="#"><img src="images/logo.png" alt="logo" height="70" /></a>
			</div>
			<div class="t_desc">云盘系统</div>
		</div>
	</div>
	<!--end top-->

	<!--tools start-->
	<div class="tools">
		<span class="t_upload" id="upload_btn">上传文件</span>
	</div>
	<!--end tools-->

	<!--files start-->
	<div class="files">
		<table>
			<thead>
				<tr>
					<td class="filelook">文件预览</td>
					<td class="filename">文件名</td>
					<td class="filesize">大小</td>
					<td class="filestime">上传时间</td>
					<td class="filesfunc">操作</td>
				</tr>
			</thead>
			<tbody id="f_tbody">
				<c:forEach items="${requestScope.files}" var="file">
					<tr class="f_item">
						<td><img src='${file.src}' data-url="${file.src}" alt='预览图像' width='35' height='35' /></td>
						<td>${file.name}</td>
						<td>${file.size}</td>
						<td>${file.date}</td>
						<td>
							<a href="${file.src}" download="${file.name}">下载</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0);" onclick="mydel(this)">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="blamnc">
			<p class="blanks">亲爱哒，还没上传任何文件哦~~~</p>
			<p class="blanks">快快点击上传吧</p>
		</div>
	</div>
	<!--end files-->
	<div class="footer">
		<div class="content">艾涵 - WeChat ID：xiaoyue942698320<br/><br/>粤ICP备17095018号 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a target="_blank" class="footerate" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=44081102000036" style="display:inline-block;text-decoration:none;height:16px;line-height:20px;"><img src="images/备案图标.png" style="float:left;"/><p style="float:left;height:20px;line-height:20px;margin: 0px 0px 0px 5px;">粤公网安备 44081102000036号</p></a>
		</div>
	</div>

<!-- 引入jQuery官方类库 -->
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="js/upload/tz_upload.js"></script>
<script type="text/javascript" src="js/sg/tz_util.js"></script>
<script type="text/javascript" src="js/sg/sg.js"></script>

<script type="text/javascript">
	
	loading("我爱你！",5);
	//图片损坏的处理方案
	$("img").on("error",function(){
		$(this).attr("src","images/noimg.png");
	});
	
	if($("#f_tbody").children().length == 0){
		$(".blamnc").show();
	}
	
	$.tmUpload({
		btnId:"upload_btn",
		url:"/krry_baiduUpload/data.jsp",
		limitSize:"1000 MB",
		fileTypes:"",   //指定某些文件使用"*.jpg,*.png"
		multiple : true,
		callback:function(serverData,file){
			var jsonData = eval("("+serverData+")");//eval函数里面必须是个小括号，能把String类型转变成json对象

			$("#f_tbody").append("<tr class='f_item'>"+
								"<td><img src='"+jsonData.url+"' data-url='"+jsonData.url+"' alt='预览图像' width='35' height='35' /></td>"+
								"<td>"+jsonData.name+"</td>"+
								"<td>"+jsonData.size+"</td>"+
								"<td>"+jsonData.time+"</td>"+
								"<td>"+
									"<a href='"+jsonData.url+"' download='"+jsonData.name+"'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
									"<a href='javascript:void(0);' onclick='mydel(this)''>删除</a>"+
								"</td>"+
								"</tr>");
			//图片损坏的处理方案
			$("img").on("error",function(){
				$(this).attr("src","images/noimg.png");
			});
			
			//隐藏
			$(".blamnc").hide();
		}
		
	});

	// 删除
	function mydel(obj){
		$.tzAlert({content:"您确定要删除吗？",callback:function(ok){
			if(ok){
				//获取要删除的文件路径
				var src = $(obj).parents(".f_item").find("img").data("url");
				$.ajax({
					url:"deleteServlet",
					type:"post",
					data:{info:src},
					success:function(data){
						if(data > 0){ //如果受影响的行数大于0，说明删除成功
							$(obj).parents(".f_item").fadeOut(1000,function(){
								$(this).remove();
								if($("#f_tbody").children().length == 0){
									$(".blamnc").show();
								}
							});
						}else{
							$.tzAlert({content:"删除失败"});
						}
					}
				});
			}
		}});
		
	}

</script>

</body>
</html>