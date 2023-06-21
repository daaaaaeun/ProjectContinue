<%@ page import="javax.websocket.Session" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2022-12-04
  Time: 오후 2:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<script src="/js/jquery.nicescroll.min.js"></script>

<style>

    .portfolio-item {
        margin-bottom: 30px;
    }

    .detail_profile {
        transition: 0.3s;
        position: relative;
        overflow: hidden;
        z-index: 1;
    }

    .detail_profile::before {
        content: "";
        background: rgba(167, 222, 255, 0.6);
        position: absolute;
        left: 30px;
        right: 30px;
        top: 30px;
        bottom: 30px;
        transition: all ease-in-out 0.3s;
        z-index: 2;
        opacity: 0;
    }

    .detail_profile .detail_profile_hover {
        opacity: 0;
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        text-align: center;
        z-index: 3;
        transition: all ease-in-out 0.3s;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .detail_profile .detail_profile_hover::before {
        display: block;
        content: "";
        width: 48px;
        height: 48px;
        position: absolute;
        top: 35px;
        left: 35px;
        border-top: 3px solid #fff;
        border-left: 3px solid #fff;
        transition: all 0.5s ease 0s;
        z-index: 9994;
    }

    .detail_profile .detail_profile_hover::after {
        display: block;
        content: "";
        width: 48px;
        height: 48px;
        position: absolute;
        bottom: 35px;
        right: 35px;
        border-bottom: 3px solid #fff;
        border-right: 3px solid #fff;
        transition: all 0.5s ease 0s;
        z-index: 9994;
    }

    .detail_profile .detail_profile_hover h4 {
        font-size: 20px;
        color: #fff;
        font-weight: 600;
    }

    .detail_profile .detail_profile_hover p {
        color: #ffffff;
        font-size: 14px;
        text-transform: uppercase;
        padding: 0;
        margin: 0;
    }

    .detail_profile:hover::before {
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        opacity: 1;
    }

    .detail_profile:hover .detail_profile_hover {
        opacity: 1;
    }

    .detail_profile:hover .detail_profile_hover::before {
        top: 15px;
        left: 15px;
    }

    .detail_profile:hover .detail_profile_hover::after {
        bottom: 15px;
        right: 15px;
    }

    .product__item__pic__hover li span {
        font-size: 16px;
        color: #1c1c1c;
        height: 40px;
        width: 40px;
        line-height: 40px;
        text-align: center;
        border: 1px solid #ebebeb;
        background: #ffffff;
        display: block;
        border-radius: 50%;
        -webkit-transition: all, 0.5s;
        -moz-transition: all, 0.5s;
        -ms-transition: all, 0.5s;
        -o-transition: all, 0.5s;
        transition: all, 0.5s;
        cursor: pointer;
    }

    .nice-select {
        border: none;
    }

    .whiteLabel {
        width: 100%;
        height: 150px;
        font-size: 13px;
        color: #6f6f6f;
        padding-left: 20px;
        margin-bottom: 24px;
        border: 1px solid #ebebeb;
        border-radius: 4px;
        padding-top: 12px;
        resize: none;
    }

    .product__item__pic__hover {
        vertical-align: bottom;
    }

</style>

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

<section class="blog spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="row">
                    <div class="col-lg-12" style="text-align: center">
                        <span style="font-size: 30px; font-weight: bold">모집장</span>
                        <br>
                        <br>
                        <c:if test="${detail.mem_id eq mem_id}">
                            <div style="float: right; padding-right: 7%">
                                <select id="rcr_status" onchange="statusCheck()">
                                    <option value="진행중">진행중</option>
                                    <option value="모집완료">모집완료</option>
                                </select>
                            </div>
                        </c:if>
                    </div>
                    <div class="col-lg-1"></div>
                    <div class="col-lg-4 detail_profile" style="text-align: center">
                        <c:choose>
                            <c:when test="${memDetail.mem_pic != 'ProfilePicture.png'}">
                                <img alt="" id="profile0" src="/images/profile/${memDetail.mem_id}/${memDetail.mem_pic}"
                                     class="img-thumbnail img-fluid"
                                     style="height: 100%; overflow: hidden"/>
                            </c:when>
                            <c:otherwise>
                                <img alt="" id="profile0" src="/images/profile/ProfilePicture.png"
                                     class="img-thumbnail img-fluid"
                                     style="height: 100%; overflow: hidden"/>
                            </c:otherwise>
                        </c:choose>
                        <div class="detail_profile_hover">
                            닉네임 : ${memDetail.mem_nick}<br>
                            등급 : ${memDetail.mem_grade}<br>
                            온도 : ${memTemp}&deg;C<br>
                            모집 횟수 : ${recruitCount}<br>
                        </div>
                    </div>
                    <div class="col-lg-6" style="text-align: left; padding: 5%; border: solid 1px #a8a4a3">
                        타이틀 : ${gameDetail.gm_name}
                        </h2></p>
                        <p>
                            최대 인원 : ${detail.rcrbrd_max}<br>
                            모집 지역 : ${detail.rcrbrd_adr}
                        </p>
                        <p>
                            종료일 : ${detail.rcrbrd_edate}
                        </p>
                        <hr>
                        <p>${memDetail.mem_nick} &nbsp;|&nbsp; ${memDetail.mem_grade}</p>
                        <p>
                        <div class="progress" style="width: 50%; height:30px">
                            <div class="progress-bar" style="width:${memTemp}%;height:30px; background-color: red">
                                ${memTemp}&deg;C
                            </div>
                        </div>
                        </p>
                    </div>
                    <div class="col-lg-1"></div>
                </div>
                <br>
                <c:if test="${detail.mem_id eq mem_id}">
                    <form style="text-align: right; padding-right: 7%" method="post">
                        <input type="hidden" id="rcrbrd_num" name="rcrbrd_num" value="${detail.rcrbrd_num}">
                            <%--<button type="submit" class="btn btn-outline-warning" onclick="updateConfirm(this.form)">글 수정</button>--%>
                        <c:if test="${roleList.size() != 0}">
                            <button type="button" class="btn btn-outline-info"
                                    onclick="location.href='/recruit/open/' + ${detail.rcrbrd_num}">글 공개
                            </button>
                        </c:if>
                        <button type="button" class="btn btn-outline-danger" onclick="deleteConfirm(this.form)">글 삭제
                        </button>
                    </form>
                    <div style="text-align: right; padding-right: 7%; font-weight: bold">
                        <br>
                        <span>역할을 추가하셨다면 역할 선택 완료 후 공개 버튼을 눌러주세요<br></span>
                        <span style="font-weight: lighter">(비공개 상태의 모집글은 마이페이지에서 확인이 가능합니다)</span>
                    </div>
                </c:if>
                <br>
                <hr>
                <div class="row">
                    <div class="col-lg-12" style="text-align: center;">
                        <span style="font-size: 30px; font-weight: bold">모집 내용</span>
                        <br>
                        <br>
                        <br>
                        <div id="rcrbrd_content" name="rcrbrd_content" style="min-height: 300px">
                            ${detail.rcrbrd_content}
                        </div>
                        <hr>
                    </div>
                    <c:forEach var="seat" items="${seatDetail}" varStatus="vs">
                        <div class="col-lg-3 col-md-4 col-sm-4">
                            <div class="product__item">
                                <c:choose>
                                    <c:when test="${seat.get('mem_id') != ''}">
                                    <div id="profile${vs.count}" class="product__item__pic set-bg" style="text-align: center;">
                                        <img src="/images/profile/${seat.get('mem_id')}/${seat.get('mem_pic')}"
                                             style="height: 100%; overflow: hidden;">
                                    </c:when>
                                    <c:otherwise>
                                        <div id="profile${vs.count}" class="product__item__pic set-bg"
                                            data-setbg="/images/profile/ProfilePicture.png" style="text-align: center">
                                    </c:otherwise>
                                </c:choose>
                                <input type="hidden" id="recruitseat${vs.count}" name="recruitseat${vs.count}"
                                       value="${vs.count}">
                                <ul class="product__item__pic__hover">
                                <c:choose>
                                    <%-- 그 방에 참가했거나 모집장인 경우 --%>
                                    <c:when test="${attendCheck > 0 or detail.mem_id eq mem_id}">
                                        <%-- 그 자리에 참가한 인원이 있을 경우 --%>
                                        <c:if test="${seat.get('mem_id') != ''}">
                                            <%-- 본인을 제외하고 신고와 하트를 출력 --%>
                                            <c:if test="${attendCheck != vs.count}">
                                                <li>
                                                    <a onclick="heart('${seat.get('mem_id')}', '${seat.get('mem_nick')}')"
                                                       style="cursor: pointer; padding-top: 0%"><i
                                                            class="fa fa-heart"></i></a></li>
                                                <li>
                                                    <a onclick="declare('${seat.get('mem_id')}', '${seat.get('mem_nick')}')"
                                                       style="cursor: pointer; padding-top: 0%">신고</a></li>
                                            </c:if>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <%-- 그 자리에 참가한 인원이 없을 경우 --%>
                                        <c:if test="${seat.get('mem_id') == ''}">
                                            <li><span id="attendBtn${vs.count}"
                                                      onclick="attend(${vs.count}, '${mem_id}')">참가</span>
                                            </li>
                                        </c:if>
                                        <c:if test="${seat.get('mem_id') != ''}">
                                            <li>
                                                <a onclick="heart('${seat.get('mem_id')}', '${seat.get('mem_nick')}')"
                                                   style="cursor: pointer; padding-top: 0%"><i
                                                        class="fa fa-heart"></i></a></li>
                                            <li>
                                                <a onclick="declare('${seat.get('mem_id')}', '${seat.get('mem_nick')}')"
                                                   style="cursor: pointer; padding-top: 0%">신고</a></li>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                                </ul>
                                <c:choose>
                                    <c:when test="${detail.mem_id eq sessionScope.mem_id}">
                                        <select id="roleSelect${vs.count}" name="roleSelect${vs.count}">
                                            <c:forEach var="role" items="${roleList}" varStatus="vs2">
                                                <%-- 사용자가 선택한 옵션 출력 --%>
                                                <option value="${role.rl_name}"
                                                        id="${vs.count}option${vs2.count}">${role.rl_name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <button type="button" id="roleBtn${vs.count}"
                                                onclick="roleConfirm(${fn:length(roleList)}, $(this).attr('id'))"
                                                class="btn btn-warning" style="float: left; margin-left: 2px">확정
                                        </button>
                                    </c:when>
                                </c:choose>
                            </div>
                            <div class="product__item__text">
                                <h6 id="attendText${vs.count}" name="attendText${vs.count}">
                                <c:if test="${seat.get('mem_id') != ''}">
                                    ${seat.get('mem_nick')} (${seat.get('mem_id')})
                                </c:if>
                                </h6>
                                <h5 id="roleText${vs.count}" name="roleText${vs.count}">
                                    <c:forEach var="role" items="${roleNameSeat}" varStatus="vs3">
                                        <%-- vs.count번째 자리에 vs.count와 자리 번호가 동일하면 역할 부여 --%>
                                        <c:if test="${vs.count == role.rs_seat}">
                                            ${role.rl_name.trim()}
                                        </c:if>
                                    </c:forEach>
                                </h5>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                    </div>
                    <hr>
                    <form id="commentForm" onsubmit="return commentCheck()" method="post">
                        <input type="hidden" id="com_rcrnum" name="rcrbrd_num" value=${detail.rcrbrd_num}>
                        <input type="hidden" id="com_memid" name="mem_id" value="${mem_id}">
                        <br>
                        <h3 style="text-align: center; font-weight: bold">댓글 작성</h3>
                        <br>
                        <div class="text-center">
                        <textarea id="com_content" name="com_content" placeholder="댓글 작성란..."
                                  style="width: 100%; height: 150px; font-size: 16px; color: #6f6f6f; padding-left: 20px; margin-bottom: 24px; border: 1px solid #ebebeb; border-radius: 4px; padding-top: 12px; resize: none;"></textarea>
                        </div>
                        <button type="button" onclick="comment()" class="site-btn" style="float: right">댓글 작성</button>
                        <br><br><br>
                        <hr>
                    </form>
                    <div>
                        <div class="row" id="commentList">
                            <c:forEach var="list" items="${commentList}" varStatus="vs5">
                                <div class="col-lg-8" style="padding-left: 5%; padding-top: 2%">
                                    <div class="header">
                                        <c:choose>
                                            <c:when test="${list.mem_pic != 'ProfilePicture.png'}">
                                                <img src="/images/profile/${list.mem_id}/${list.mem_pic}"
                                                     style="max-height: 20px; max-width: 20px">&nbsp;&nbsp;${list.mem_nick}&nbsp;&nbsp;
                                            </c:when>
                                            <c:otherwise>
                                                <img src="/images/profile/ProfilePicture.png"
                                                     style="max-height: 20px; max-width: 20px">&nbsp;&nbsp;${list.mem_nick}&nbsp;&nbsp;
                                            </c:otherwise>
                                        </c:choose>
                                        <span>${list.comdate}</span>
                                        <c:if test="${list.mem_id == sessionScope.mem_id}">
                                    <span style="float: right; cursor: pointer"
                                          onclick="commentDelete(${list.com_num})">삭제</span>
                                            <span style="float: right; padding-right: 1%; cursor: pointer"
                                                  onclick="commentUpdate(${list.com_num}, $('#comment${list.com_num}').text().trim())">수정</span>
                                        </c:if>
                                    </div>
                                    <div class="card-body comment_content" id="content${list.com_num}">
                                        <div class="whiteLabel"
                                             style="background-color: #f7f7e3; max-height: 80px; font-size: 13px"
                                             id="comment${list.com_num}">${list.com_content}
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="container">
    <!-- The Modal -->
    <div class="modal fade" id="declaration">
        <input type="hidden" id="modal_id" value="">
        <input type="hidden" id="modal_nickname" value="">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">신고하기</h4>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <textarea id="declare_content" class="whiteLabel"></textarea>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="declare2()" class="btn btn-primary">제출</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>

            </div>
        </div>
    </div>
</div>

<script>

    // 참가에 대한 내용
    function attend(num, mem_id) {

        $.ajax({
            url: "/recruit/attend",
            type: "post",
            data: {
                "rcrbrd_num": "${detail.rcrbrd_num}",
                "mem_id": mem_id,
                "ri_seat": num
            },
            success: function (data) {
                if (mem_id !== '${detail.mem_id}' || ${attendCheck} > 0) {
                    for (let i = 1; i <= ${detail.rcrbrd_max}; i++) {
                        $("#attendBtn" + i).attr('onclick', '').unbind('click');
                        $("#attendBtn" + i).css("cursor", "default");
                        $("#attendBtn" + i).css("background-color", "lightgray");
                        $("#attendBtn" + i).css("border", "solid 2px gray");
                    }

                    alert(mem_id + "님, 참가 신청이 완료되었습니다.");
                } else {
                    alert("참가 신청에 실패하였습니다.");
                }
            },
            error: function (error) {
                console.log("에러 발생 : " + error);
            }
        });

    } // attend() end

    // 역할을 선택하고 확정하는 내용
    function roleConfirm(x, id) {
        let num = id.substring(id.length - 1, id.length);
        let role = $('#roleSelect' + num + ' option:selected').val();
        //let role = $('#roleSelect' + num +' option:selected').val();

        // 여기서 disabled 하는 이유는 모집장이 역할을 선택하고 나서 disabled를 해야 다른 역할을 선택할 수 없기 때문
        for (let i = 1; i <= x; i++) {
            for (let j = 1; j <= x; j++) {
                if ($('#' + j + 'option' + i).val() == role) {
                    $('#roleSelect' + num).attr('disabled', true).niceSelect('update');
                    $('#' + id).hide();
                }
            }

        }

        $.ajax({
            url: "/recruit/roleConfirm",
            type: "post",
            data: {
                "rl_name": role,
                "rcrbrd_num": ${detail.rcrbrd_num},
                "rs_seat": num
            },
            success: function (data) {
                alert("역할이 확정되었습니다");
            },
            error: function (error) {
                console.log("에러 발생 : " + error);
            }
        });

    } // roleConfirm() end

    $(document).ready(function () {
        for (let i = 1; i <= ${detail.rcrbrd_max}; i++) {
            $.ajax({
                url: "/recruit/roleSeatCheck",
                type: "post",
                data: {
                    "rcrbrd_num": ${detail.rcrbrd_num},
                    "rs_seat": i
                },
                success: function (data) {
                    if (data != 0) {

                        $('#roleSelect' + i).val($('#roleText' + i).text().trim());
                        // console.log($('#roleSelect'+i).val()); 해당 select box id의 value값
                        // console.log($('#roleText'+i).text().trim()); 선택된 값

                        // 여기서 disabled 하는 이유는 모집장이 새로고침 후에도 해당 좌석은 역할 선택을 할 수 없게 해야하기 때문
                        $('#roleSelect' + i).attr('disabled', true).niceSelect('update');
                        $('#roleBtn' + i).hide();
                    }
                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            })

            // 만약 역할 추가를 안 했다면 select box와 버튼이 안 보이게 처리
            if ($('#roleSelect' + i).val() == null) {
                $("#profile" + i + " > .nice-select").css('display', 'none').niceSelect('update');
                $('#roleBtn' + i).hide();
            }
        }

        if ($('#rcr_status').val() == '모집완료') {
            $('#rcr_status').attr('disabled', true).niceSelect('update');
        }

    });

    function deleteConfirm(form) {
        if (confirm("정말로 삭제하시겠습니까?")) {
            form.action = "/recruit/delete";
            form.submit();
        } else {
            location.href = "#";
        }
    }

    function statusCheck() {
        if ($('#rcr_status').val() == '모집완료') {

            $.ajax({
                url: "/recruit/status",
                type: "post",
                data: {
                    "rcrbrd_num": ${detail.rcrbrd_num}
                },
                success: function (data) {
                    $('#rcr_status').attr('disabled', true).niceSelect('update');

                    $.ajax({
                        url: "/recruit/bonus",
                        type: "post",
                        data: {
                            "mem_id": '${detail.mem_id}'
                        },
                        success: function (data) {
                            if (data == 1) {
                                alert("모집 완료 보너스로 100 포인트가 지급되었습니다.");
                            }
                        },
                        error: function (request, status, error) {
                            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                        }
                    })
                }
            })


        }
    }

    function heart(id, nickname) {
        // alert(id);

        $.ajax({
            url: "/recruit/heart",
            type: "post",
            data: {
                "rt_goodbad": "좋아요",
                "give_id": '${mem_id}',
                "receive_id": id,
                "rt_content": "-",
                "rcrbrd_num": ${detail.rcrbrd_num}
            },
            success: function (result) {
                alert(nickname + result);
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })
    }

    function declare(id, nickname) {
        if (confirm("정말로 신고하시겠습니까?")) {
            $('#modal_id').val(id);
            $('#modal_nickname').val(nickname);
            $('#declaration').modal('show');
        }
    }

    function declare2() {

        $.ajax({
            url: "/recruit/declare",
            type: "post",
            data: {
                "rt_goodbad": "신고",
                "give_id": '${mem_id}',
                "receive_id": $('#modal_id').val(),
                "rt_content": $('#declare_content').val(),
                "rcrbrd_num": ${detail.rcrbrd_num}
            },
            success: function (result) {
                alert($('#modal_nickname').val() + result);
                $('#declaration').modal('hide');
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })

    }

    $('#declare_content').keyup(function () {
        let content = $(this).val();
        if (content.length > 255) {
            alert("최대 255자까지 입력 가능합니다.");
        }
    });

    function commentCheck() {
        let size = $('#com_content').val();
        if (size.length < 2) {
            alert("두글자 이상 입력해주세요!");
            return false;
        } else {
            return true;
        }
    }

    function comment() {
        let comment = $('#commentForm').serialize();
        if (commentCheck() == true) {
            $.ajax({
                url: "/recruit/comment",
                type: "post",
                data: comment,
                success: function (data) {
                    commentList();
                    $('#com_content').val('');
                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            })
        }
    }

    function commentList() {
        $.ajax({
            url: "/recruit/commentList",
            type: "post",
            data: {
                "rcrbrd_num": ${detail.rcrbrd_num}
            },
            success: function (result) {
                let str = "";
                $.each(result, function (index, value) {
                    str += "<div class='col-lg-8' style='padding-left: 5%; padding-top: 2%'>";
                    str += "<div class='header'>";
                    if (value.mem_pic != 'ProfilePicture.png') {
                        str += "<img src='/images/profile/" + value.mem_id + "/" + value.mem_pic + "' style='max-height: 20px; max-width: 20px'>&nbsp;&nbsp;" + value.mem_nick + "&nbsp;&nbsp;";
                    } else {
                        str += "<img src='/images/profile/ProfilePicture.png' style='max-height: 20px; max-width: 20px'>&nbsp;&nbsp;" + value.mem_nick + "&nbsp;&nbsp;"
                    }
                    str += "<span>" + value.comdate + "</span>";
                    if (value.mem_id == '${mem_id}') {
                        str += "<span style='float: right; cursor: pointer' onclick='commentDelete(" + value.com_num + ")'>삭제</span>";
                        str += "<span style='float: right; padding-right: 1%; cursor: pointer' onclick='commentUpdate(" + value.com_num + ",\"" + value.com_content + "\")'>수정</span>";
                    }
                    str += "</div>";
                    str += "<div class='card-body comment_content' id='content" + value.com_num + "'>";
                    str += "<div class='whiteLabel' style='background-color: #f7f7e3; max-height: 80px; font-size: 13px'  id='comment" + value.com_num + "'>" + value.com_content + "</div>";
                    str += "</div>";
                    str += "</div>";
                });
                $('#commentList').html(str);
                $('#com_content').text();
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })
    }

    document.addEventListener("DOMContentLoaded", () => {
        $('.comment_content').niceScroll();
    });

    function commentDelete(com_num) {
        $.ajax({
            url: '/recruit/commentDelete/' + com_num,
            type: 'post',
            success: function (result) {
                if (result == 1) {
                    commentList(); // 댓글 삭제 후 목록 출력
                }
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })
    }

    function commentUpdate(com_num, com_content) {
        let str = "";
        str = "<textarea class='whiteLabel' style='width: 100%' id='comUpdate" + com_num + "'>" + com_content + "</textarea>";
        str += "<div style='text-align: right' id='comButton" + com_num + "'><button type='button' class='btn btn-warning' onclick='commentUpdateProc(" + com_num + ")' style='margin-top: 2%'>수정 확인</button><div>";
        $('#content' + com_num + '').html(str);
    }

    function commentUpdateProc(com_num) {
        $.ajax({
            url: '/recruit/commentUpdate',
            type: 'post',
            data: {
                'com_content': $('#comUpdate' + com_num).val(),
                'com_num': com_num
            },
            success: function (result) {
                if (result == 1) {
                    commentList();
                }
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });

    }

</script>

<%@ include file="../footer.jsp" %>
