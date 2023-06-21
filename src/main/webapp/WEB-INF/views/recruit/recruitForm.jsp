<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2022-12-01
  Time: 오전 11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<!-- 모집 게시판 배너 시작 -->
<section class="breadcrumb-section set-bg" data-setbg="/images/recruit_banner.png">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>모집 게시판</h2>
                    <div class="breadcrumb__option">
                        <a href="/">Home</a>
                        <span>모집</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- 모집 게시판 배너 끝 -->

<%-- ip 주소 가져오기 --%>
<% String ip = request.getRemoteAddr(); %>

<!-- 등록 폼 시작 -->
<section class="checkout spad">
    <div class="container">
        <div class="checkout__form">
            <h4>모집글 등록</h4>
            <form action="/recruit/insert" onsubmit="return formCheck()">
                <input type="hidden" id="mem_id" name="mem_id" value="${sessionScope.mem_id}">
                <input type="hidden" id="rcrbrd_ip" name="rcrbrd_ip" value="<%=ip%>">
                <input type="hidden" id="gm_code" name="gm_code" value="">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="checkout__input" style="margin-left: auto">
                                    <p>게임 타이틀 검색<span>*</span></p>
                                    <input type="text" placeholder="Search..." class="col-lg-12" id="game_search"
                                           name="game_search" readonly>&nbsp;


                                    <!-- 모달창 -->
                                    <div class="modal fade" id="gs_modal">
                                        <div class="modal-dialog">
                                            <div class="modal-content">

                                                <!-- 모달 헤더 -->
                                                <div class="modal-header" style="border-bottom: none">
                                                    <h4 class="modal-title">게임 타이틀 검색</h4>
                                                    <button type="button" class="close" data-dismiss="modal">×</button>
                                                </div>

                                                <!-- 모달 본문 -->
                                                <div class="modal-body" id="gs_main">
                                                    <input type="text" placeholder="Search..." id="gs_keyword"
                                                           name="gs_keyword">
                                                    <div id="panel" style="display: none"></div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__input col-lg-6">
                                <p>모집 인원 (본인 제외)<span>*</span></p>
                                <select id="rcrbrd_max" name="rcrbrd_max">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                </select>
                                <br>
                            </div>
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>닉네임<span>*</span></p>
                                    <input type="text" value="${nickname}" readonly>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>패스워드<span>*</span></p>
                                    <input type="password" placeholder="password" id="rcrbrd_pw" name="rcrbrd_pw" required>
                                </div>
                            </div>
                        </div>
                        <div class="checkout__input">
                            <p>제목<span>*</span></p>
                            <input type="text" id="rcrbrd_subject" name="rcrbrd_subject" required>
                        </div>
                        <div class="checkout__input">
                            <p>내용</p>
                            <textarea name="rcrbrd_content" id="rcrbrd_content"></textarea>
                            <script type="text/javascript">    // 글쓰기 editor 및 사진 업로드 기능
                            CKEDITOR.replace('rcrbrd_content',
                                {
                                    width: '100%',
                                    height: '500',
                                    filebrowserUploadUrl: '/recruit/imageUpload'
                                });
                            </script>
                        </div>

                        <div class="checkout__input">
                            <p>주소 검색<span>*</span></p>
                            <input type="text" id="zipcode" style="margin-left: auto; width: 50%" readonly>&nbsp;
                            <button type="button" onclick="DaumPostcode()" class="btn btn-danger">검색</button>
                        </div>
                        <div id="wrap"
                             style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
                            <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap"
                                 style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1"
                                 onclick="foldDaumPostcode()" alt="접기 버튼">
                        </div>
                        <div class="checkout__input" id="rcrbrd_adr0" style="display: none">
                            <input type="text" id="rcrbrd_adr" name="rcrbrd_adr" readonly>
                        </div>

                        <div class="checkout__input">
                            <p>종료일 선택<span>*</span></p>
                            <input id="rcrbrd_edate" name="rcrbrd_edate" type="datetime-local" style="width: 50%"
                                   onchange="dateSummary()" required>
                        </div>
                        <br>
                        <br>
                        <div class="checkout__input__checkbox">
                            <label for="role" onclick="roleCheck()">
                                역할 구분이 필요하신가요?
                                <input type="checkbox" id="role" name="role">
                                <span class="checkmark"></span>
                                &nbsp;&nbsp;&nbsp;
                                <button type="button" id="addRoleBtn" name="addRoleBtn" onclick="addRoleText()"
                                        class="btn btn-danger" style="display: none">역할 추가
                                </button>
                                <button type="button" id="delRoleBtn" name="delRoleBtn" onclick="delRoleText()"
                                        class="btn btn-outline-dark" style="display: none">역할 삭제
                                </button>
                            </label>
                            <div id="addRoleArea" class="checkout__input col-lg-8">
                                <input type="hidden" id="hiddenCount" name="hiddenCount" value=0>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="checkout__order" style="position: sticky; top: 50px">
                            <h4>모집 요약</h4>
                            <ul>
                                <li>타이틀명 <span id="game_search2">-</span></li>
                                <li>모집 인원 <span id="rcrbrd_max2">1</span></li>
                                <li>모집 장소 <span id="rcrbrd_adr2">-</span></li>
                                <li>종료일 <span id="rcrbrd_edate2">-</span></li>
                            </ul>
                            <div class="checkout__order__subtotal">소모 마일리지 <span style="color: red" id="useMileage1">0</span></div>
                            <input type="hidden" id="useMileage" name="useMileage">
                            <div class="checkout__input__checkbox">
                                <label for="acc-or">
                                    위에 적힌 정보가 맞나요?<br>
                                    하루당 100 마일리지가 소모됩니다
                                    <input type="checkbox" id="acc-or">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <button type="submit" class="site-btn" style="background-color: #fba1a4"
                                    disabled="disabled">등록
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
<!-- 등록 폼 끝 -->

<script>

    const gameName = [];
    const gameCode = [];

    /* 클릭하면 모달창 보이기 */
    $(document).ready(function () {
        $("#game_search").click(function () {
            // 모달창의 검색창 초기화
            $("#gs_keyword").val("");
            // 모달창 보이기
            $("#gs_modal").modal({backdrop: 'static', keyboard: false});
        });

        $.ajax({
            url: "/recruit/gameList",
            type: "POST",
            dataType: "json",
            success: function (data) {

                $.each(data, function (index, value) {
                    gameName.push(value.gm_name);
                    gameCode.push(value.gm_code);
                });
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });

    });

    $("#gs_keyword").keyup(function () {

        // 검색어가 존재하지 않으면 출력결과 숨기기
        if ($("#gs_keyword").val() == "") {
            $("#panel").hide();
        } // if end

        // 모달창의 검색창에 검색어 추출
        let params = $("#gs_keyword").val();

        responseProc(params);
    }); // keyup() end

    function responseProc(data) {
        if (data.length > 0) {
            let str = "";
            $.each(gameName, function (index, key) {

                if (key.indexOf(data) != -1) {
                    str += "<hr>";
                    str += "<img src='/images/thumb/" + gameCode[index] + "/thumb.jpg' style='width: 10%'>&nbsp;"
                    str += "<span id='title_key' style='cursor: pointer' onclick='panelClick(\"" + gameCode[index] + "\")'>" + key + "</span>";
                    str += "<hr>";
                }
            });

            $("#panel").html(str);
            $("#panel").show();
        } else {
            $("#panel").hide();
        }

    } // responseProc() end

    // 모달창에서 타이틀 제목이 선택되면 본문과 요약 창에도 반영
    function panelClick(codenum) {
        // 타겟의 내부 텍스트 추출
        let title = event.target.innerText;

        // 추출한 텍스트를 모달창의 검색창에 입력
        $("#game_search").val(title);
        $("#game_search2").text(title);
        $("#gm_code").val(codenum);
        $("#gs_modal").modal("hide");

    }

    // 최대 인원 수를 변경하면 요약 창에도 반영
    $(document).ready(function () {
        $("#rcrbrd_max").on("change", function () {
            //selected value
            $("#rcrbrd_max2").text($("#rcrbrd_max option:selected").text());
        });
    });

    <!-- ----- DAUM 우편번호 API 시작 ----- -->
    // 우편번호 찾기 화면을 넣을 element
    let element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        let currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function (data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if (data.addressType === 'R') {
                    //법정동명이 있을 경우 추가한다.
                    if (data.bname !== '') {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if (data.buildingName !== '') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('rcrbrd_adr').value = fullAddr;
                $('#rcrbrd_adr2').text(fullAddr);

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;


                $('#rcrbrd_adr0').show();
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize: function (size) {
                element_wrap.style.height = size.height + 'px';
            },
            width: '100%',
            height: '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }

    <!-- ----- DAUM 우편번호 API 종료 ----- -->

    // 날짜 정보 요약 창으로 옮기기
    function dateSummary() {
        let date = $('#rcrbrd_edate').val().split('T');
        $('#rcrbrd_edate2').text(date[0] + ' ' + date[1]);
    }

    //
    $('#acc-or').click(function () {
        if ($('#acc-or').is(':checked')) {
            $('.site-btn').css('background-color', 'red');
            $('.site-btn').attr("disabled", false);
        } else {
            $('.site-btn').css('background-color', '#fba1a4');
            $('.site-btn').attr("disabled", true);
        }
    });

    // 역할 추가 버튼 히든 처리 해제
    function roleCheck() {

        if ($('#role').is(':checked')) {
            $('#addRoleBtn').show();
        } else {
            $('#addRoleBtn').hide();
        }
    } // roleCheck() end

    // 역할 추가 텍스트 박스 생성
    function addRoleText() {
        let count = parseInt(document.getElementById('hiddenCount').value);
        count += 1;
        let str = '<input type="text" id="rl_role' + count + '" name="rl_role' + count + '" placeholder="역할을 입력해주세요." style="margin: 2%" required>';
        $('#addRoleArea').append(str.trim());
        document.getElementById('hiddenCount').value = count;
        $('#delRoleBtn').show();
    } // addRoleText() end

    // 역할 추가 텍스트 박스 삭제
    function delRoleText() {
        let count = parseInt(document.getElementById('hiddenCount').value);
        if (count > 0) {
            $('#rl_role' + count).remove();
            count -= 1;
            document.getElementById('hiddenCount').value = count;
            if (count == 0) {
                $('#delRoleBtn').hide();
            }
        }
    }

    // 유효성 검사
    function formCheck() {
        if ($('#game_search').val().length < 1) {
            alert("모집할 게임을 선택해주세요");
            $('#gs_modal').modal('show');
            return false;
        }
        if ($('#zipcode').val().length < 1) {
            alert("주소를 선택해주세요");
            DaumPostcode();
            return false;
        }
        if (dateDiff() == false) {
            alert("모집 마감일은 오늘 이후로 설정해주세요");
            return false;
        }

        for (let i = 1; i <= parseInt($('#hiddenCount').val()); i++) {
            for (let j = 1; j <= i; j++) {
                if (i != j) {
                    if ($('#rl_role'+i).val().trim() == $('#rl_role'+j).val().trim()) {
                        alert("동일한 역할은 추가할 수 없습니다");
                        return false;
                    }
                }
            }
        }
        return true;
    }

    // 현재 날짜와 선택한 날짜의 차이 구하기
    function dateDiff() {
        let date = $('#rcrbrd_edate').val().split('T');
        let today = new Date();
        let selectDate = new Date(date[0] + ' ' + date[1]);
        let diff = selectDate.getTime() - today.getTime();
        // alert(diff); // 261257
        let diffDate = Math.ceil(diff / (1000 * 3600 * 24));
        // alert(diffDate); // 1
        if (diffDate <= 1) {
            $('#rcrbrd_edate').val('');
            return false;
        }
        return true;
    }

    $('#rcrbrd_edate').change(function () {
        let date = $('#rcrbrd_edate').val().split('T');
        let today = new Date();
        let selectDate = new Date(date[0] + ' ' + date[1]);
        let diff = selectDate.getTime() - today.getTime();
        let diffDate = Math.ceil(diff / (1000 * 3600 * 24));

       $('#useMileage1').text((diffDate - 1) * 100);
       $('#useMileage').val((diffDate - 1) * 100);
    });


</script>

<%@ include file="../footer.jsp" %>
