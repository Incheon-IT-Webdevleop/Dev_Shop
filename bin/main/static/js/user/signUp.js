function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}

$(document).ready(function() {
    // 모든 항목 유효성 검사
    // 우선은 유효성 없이 회원가입 기능만 하기위해 주석 처리
    let effectivenessFlag = {
        "email" : false,
        "password" : false,
        "confirmPassword" : false,
        "name" : false,
        "phone" : false,
        "address" : false
    }

    // 유효성 검사 성공 시
    function changeTureEffectivenessFlag(item){
        effectivenessFlag.item = true;
    }

    // 유효성 검사 실패 시 
    function changeFlaseEffectivenessFlag(item){
        effectivenessFlag.item = false;
    }

    // 이메일 인증버튼
    $('#certificationBtn').on('click', function(){
        // 이메일 인증검사 버튼을 눌렀을 때 유효성 검사를 다시 해야하므로,
        // 상태를 false로 우선 변경        

        // changeFlaseEffectivenessFlag("email");

        // id로 값 받아오기
        // 이메일 앞부분
        const localEmail = $('#localEmail').val();
        //이메일 도메인
        const domainEmail = $('#domainEmail').val();
       
        const email = localEmail + domainEmail;
        const emailFlag = false;

        // 인증 번호 버튼을 눌렀을 때 
        // 이메일 중복검사 부터
        // 있으면 버튼 눌렀을 때 알람 나오고 break;
        
        // $.ajax({
        //     url: "/api/duplication",
        //     type: "POST",
        //     data: {
        //         type: "email",
        //         value: email
        //     },
        //     success: function (res) {
        //         alert(res); // "사용 가능한 이메일입니다."
        //         changeTureEffectivenessFlag("email");
        //         emailFlag = true;
        //     },
        //     error: function (xhr) {
        //         if (xhr.status === 403) {
        //             alert(xhr.responseText); // "이미 사용중인 이메일입니다."
        //             emailFlag = false;
        //             return;
        //         } else {
        //             alert("알 수 없는 오류 발생");
        //             emailFlag = false;
        //             return;
        //         }
        //     }
        // });
        
    })

    // 회원가입 버튼
    $('#submitBtn').on('click', function(){
        // id로 값 받아오기
        // 이메일 앞부분
        const localEmail = $('#localEmail').val();
        //이메일 도메인
        const domainEmail = $('#domainEmail').val();
        // 비밀번호
        const password = $('#password').val();
        // 비밀번호 확인
        const confirmPassword = $('#confirmPassword').val();
        // 주소 zipcode
        const addressZipcode = $('#zipcode').val();
        // 주소 base
        const addressBase = $('#address').val();    
        // 주소 detail
        const addressDetail = $('#detailAddress').val();
        // 이름
        const name = $('#name').val();
        // 휴대폰번호
        const phone = $('#phone1').val() + $('#phone2').val() + $('#phone3').val();
        
        const email = localEmail + domainEmail;

        $.ajax({
            url: "/api/auth/signUp",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                email: email,
                password: password,
                confirmPassword: confirmPassword,
                name: name,
                phone: phone,
                address: {
                    zipcode: addressZipcode,
                    base: addressBase,
                    detail: addressDetail
                }
            }),
            success: function (res) {
                alert(res); // "사용 가능한 이메일입니다."
                changeTureEffectivenessFlag("email");
                emailFlag = true;
            },
            error: function (xhr) {
                if (xhr.status === 403) {
                    alert(xhr.responseText); // "이미 사용중인 이메일입니다."
                    emailFlag = false;
                    return;
                } else {
                    alert("알 수 없는 오류 발생");
                    emailFlag = false;
                    return;
                }
            }
        });
    })
});