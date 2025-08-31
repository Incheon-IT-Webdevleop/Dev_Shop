$(document).ready(function() {
    $('#loginForm').on('submit', function(e){
        e.preventDefault(); // 기본 form submit 막기

        const email = $('#userEmail').val();
        const password = $('#userPassword').val();

        $.ajax({
            url: "/api/auth/login",
            type: "POST",
            data: {  // 객체 그대로 전송
                email: email,
                password: password
            },
            success: function(res) {
                console.log(res)
                if(res.success) {
                    alert("로그인 성공!");
                    window.location.href = "/api";
                } else {
                    alert("로그인 실패!");
                }
            },
            error: function(xhr) {
                alert("로그인 중 오류 발생: " + xhr.status);
            }
        });
    });

    $('#naverLoginBtn').on('click', function() {
        window.location.href = '/oauth2/authorization/naver';
    });
});