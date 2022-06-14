<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>map</title>

</head>
<style>
    .off {
        background-color: darkgrey;
        color: #fafbff;
    }

    .on {
        background-color: #6c9aff;
        color: #fafbff;
    }

    .btn {
        width: 14%;
        height: 50px;
    }

</style>
<body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b1b5d6fa8d46f25239c3a8380791407c&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script language="JavaScript" type="text/javascript"></script>

<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:850px;"></div>

<button id="hsptl" class="btn on" value="Y" onclick="javascript:iconOnOff('hsptl');">병원</button>
<button id="ermctplace" class="btn on" value="Y" onclick="javascript:iconOnOff('ermctplace');">응급 의료기관</button>
<button id="hqp" class="btn on" value="Y" onclick="javascript:iconOnOff('hqp');">중장비 업체</button>
<button id="emsnpc" class="btn on" value="Y" onclick="javascript:iconOnOff('emsnpc');">긴급 대피소</button>
<button id="dstr_af" class="btn on" value="Y" onclick="javascript:iconOnOff('dstr_af');">이재민 수용시설</button>
<button id="rs_aspc" class="btn on" value="Y" onclick="javascript:iconOnOff('rs_aspc');">자원 집결지</button>
<button id="etc_fac" class="btn on" value="Y" onclick="javascript:iconOnOff('etc_fac');">기타</button>

<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.5666805, 126.9784147), // 지도의 중심좌표
            level: 7 // 지도의 확대 레벨
        }

    // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    function getGisList() {
        $.ajax({
            url: "/getTest",
            type : "get",
            dataType : "json",
            success : function (json) {
                setGisList(json);
            }
        })
    };

    // 마커 이미지 설정
    var imageSrc = "/images/",
        imageSize = new kakao.maps.Size(32, 36),
        imageOption = {};
    var MarkerImages = new Map();

    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_fire.png", imageSize, imageOption);
    MarkerImages.set("A1", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_districtOffice.png", imageSize, imageOption);
    MarkerImages.set("A2", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_school.png", imageSize, imageOption);
    MarkerImages.set("A3", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_road.png", imageSize, imageOption);
    MarkerImages.set("A4", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_water.png", imageSize, imageOption);
    MarkerImages.set("A5", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_river.png", imageSize, imageOption);
    MarkerImages.set("A6", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_healthcenter.png", imageSize, imageOption);
    MarkerImages.set("A7", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_police.png", imageSize, imageOption);
    MarkerImages.set("B1", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_eduoffice.png", imageSize, imageOption);
    MarkerImages.set("B2", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_police.png", imageSize, imageOption);
    MarkerImages.set("B3", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_gas.png", imageSize, imageOption);
    MarkerImages.set("D1", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_electricity.png", imageSize, imageOption);
    MarkerImages.set("D2", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_seoulgas.png", imageSize, imageOption);
    MarkerImages.set("D3", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_kepco.png", imageSize, imageOption);
    MarkerImages.set("D4", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_redcross.png", imageSize, imageOption);
    MarkerImages.set("D5", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_metro5678.png", imageSize, imageOption);
    MarkerImages.set("D6", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_metro.png", imageSize, imageOption);
    MarkerImages.set("D7", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_railway.png", imageSize, imageOption);
    MarkerImages.set("D8", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_park.png", imageSize, imageOption);
    MarkerImages.set("D9", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_army.png", imageSize, imageOption);
    MarkerImages.set("E1", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_hospital.png", imageSize, imageOption);
    MarkerImages.set("E2", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_kt.png", imageSize, imageOption);
    MarkerImages.set("E3", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_airport.png", imageSize, imageOption);
    MarkerImages.set("E4", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "public_forest.png", imageSize, imageOption);
    MarkerImages.set("E5", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_private.png", imageSize, imageOption);
    MarkerImages.set("F1", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_heavyEquipment.png", imageSize, imageOption);
    MarkerImages.set("F2", markerImage);
    markerImage = new kakao.maps.MarkerImage(imageSrc + "private_etc.png", imageSize, imageOption);
    MarkerImages.set("G1", markerImage);

    var markersItem = function (jsons, marker, id, hsptlYn, ermctplaceYn, hqpYn, emsnpcYn,dstrAfYn, rsAspcYn, etcFac) {
        this.data = jsons;
        this.marker = marker;
        this.id = id;
        this.hsptlYn = hsptlYn;
        this.ermctplaceYn = ermctplaceYn;
        this.hqpYn = hqpYn;
        this.emsnpcYn = emsnpcYn;
        this.dstrAfYn = dstrAfYn;
        this.rsAspcYn = rsAspcYn;
        this.etcFac = etcFac;
    }
    var markers =[];

    function setGisList(jsons) {
        jsons.forEach((val, i) => {
                var markerPosition = new kakao.maps.LatLng(val.INT_YCTS, val.INT_XCTS);
                var marker = new kakao.maps.Marker({position: markerPosition, image: MarkerImages.get(val.SPTINT_SE_CD)});
                markers.push(new markersItem(jsons[i], marker, jsons[i].SPTINT_SE_CD, jsons[i].HSPTL_YN, jsons[i].ERMCTPLACE_YN, jsons[i].HQP_YN,
                    jsons[i].EMSNPC_YN, jsons[i].DSTR_AF_YN, jsons[i].RS_ASPC_YN, jsons[i].ETC_FAC));
                marker.setMap(map);
            }
        )
    }
    getGisList();

    function iconOnOff(type) {
        if ($("#"+type).val() == "Y") {
            $("#"+type).removeClass("on");
            $("#"+type).addClass("off");
            $("#"+type).val("N");

            markerView();

        } else {
            $("#"+type).removeClass("off");
            $("#"+type).addClass("on");
            $("#"+type).val("Y");

            markerView();
        }
    }

    function markerView() {
        for(var i = 0; i < markers.length; i++) {
            markers[i].marker.setMap(map);

            if ($('#hsptl').val() == 'N' && markers[i].hsptlYn == 'Y') {
                markers[i].marker.setMap(null);
            }
            if($("#ermctplace").val() == "N" && markers[i].ermctplaceYn == "Y"){
                markers[i].marker.setMap(null);
            };

            if($("#hqp").val() == "N" && markers[i].hqpYn == "Y"){
                markers[i].marker.setMap(null);
            };

            if($("#emsnpc").val() == "N" && markers[i].emsnpcYn == "Y"){
                markers[i].marker.setMap(null);
            };

            if($("#dstr_af").val() == "N" && markers[i].dstrAfYn == "Y"){
                markers[i].marker.setMap(null);
            };

            if($("#rs_aspc").val() == "N" && markers[i].rsAspcYn == "Y"){
                markers[i].marker.setMap(null);
            };

            if($("#etc_fac").val() == "N" && markers[i].etcFac == "Y"){
                markers[i].marker.setMap(null);
            };
        }
    }
</script>
</body>
</html>