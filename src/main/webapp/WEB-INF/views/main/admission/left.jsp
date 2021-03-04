<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="col-2">
	<div class="row text-center leftMenu">
		<div class="col-12"><p>입사안내</p></div>
		<div class="col-12">
			<ul class="list-group">
			  <li class="list-group-item"><a href="/main?pageGroup=admission&type=susi">수시 안내</a></li>
			  <li class="list-group-item"><a href="/main?pageGroup=admission&type=jeongsi">정시 안내</a></li>
			</ul>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	let listLength = $(".list-group-item").length;
	let arrType = [];
	for( let i = 0; i < listLength; i++ ){
		let href = $(".list-group-item").eq(i).children().attr("href");
		arrType[i] = href.substring( href.indexOf("type=") + 5, href.length );
	}
	for( let i = 0; i < arrType.length; i++ ){
		if( "${type}" == arrType[i] ){
			$(".list-group-item").eq(i).addClass("active");
		}
	}
})
</script>