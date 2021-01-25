<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 게시물 작성 페이지 -->
<div class="row writerWrapper">
	<form action="/main/board.write?pageGroup=community&type=${type}" method="post">
		<div class="col-12"><input type="text" placeholder="제목을 입력하세요" name="title" class="title"></div>
		<div class="col-12">
			<textarea id="summernote" name="contents"></textarea>
		</div>
		<div class="col-12">
			<div class="row mt-3 text-center">
				<div class="col-9"></div>
				<div class="col-1"><input type="submit" value="작성하기"></div>
				<div class="col-2"><button class="btnList" type="button">목록으로</button></div>
			</div>
		</div>
	</form>
</div>
<script>
$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: 600,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
		  toolbar: [
			    // 글꼴 설정
			    ['fontname', ['fontname']],
			    // 글자 크기 설정
			    ['fontsize', ['fontsize']],
			    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    // 글자색
			    ['color', ['forecolor','color']],
			    // 표만들기
			    ['table', ['table']],
			    // 글머리 기호, 번호매기기, 문단정렬
			    ['para', ['ul', 'ol', 'paragraph']],
			    // 줄간격
			    ['height', ['height']],
			    // 그림첨부, 링크만들기, 동영상첨부
			    ['insert',['picture','link']],
			    // 코드보기, 확대해서보기, 도움말
			    ['view', ['codeview', 'help']]
			  ],
			  // 추가한 글꼴
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
			 // 추가한 폰트사이즈
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
		  callbacks: {	//여기 부분이 이미지를 첨부하는 부분
				onImageUpload : function(files) {
					console.log(files[0]);
					uploadSummernoteImageFile(files[0],this);
				},
				onPaste: function (e) {
					var clipboardData = e.originalEvent.clipboardData;
					if (clipboardData && clipboardData.items && clipboardData.items.length) {
						var item = clipboardData.items[0];
						if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
							e.preventDefault();
						}
					}
				}
			}
	});
	
	function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "/main/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success : function(data) {
				data = data;
				console.log(data.url)
            	//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote('insertImage', data.url);
			}
		});
	}
	
	$("input[type=submit]").click(function(){
		let title = $(".title").val();
		let contents = $("#summernote").val();
		if( title == null || title.length <= 0 ){
			alert("제목을 입력 해주세요.");
			return false;
		} else
		if( contents == null || contents.length <= 0){
			alert("내용을 입력 해주세요.");
			return false;
		} else {
			alert("게시글 작성!!")
		}
	})
	
	$(".btnList").click(function(){
		location.href="/main/board.list?pageGroup=${pageGroup}&type=${type}&page=${page}";
	})
});
</script>