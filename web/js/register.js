function checkForm() {
    var ef = false;
    var div = document.getElementById("errorMsg");
    div.innerHTML = "错误信息：<br>";

    // 检查用户名
    var username = document.form.username.value;
    if (username === "") {
        div.innerHTML += "用户名不能为空！<br>";
        ef = true;
    } else if (username.length < 4 || username.length > 16) {
        div.innerHTML += "用户名长度为4-16个字符！<br>";
        ef = true;
    } else {
        var t = username.toLowerCase();
        for (var i = 0; i < username.length; i++) {
            var c = t.charAt(i);
            if (!(c >= 0 && c <= 9) && (!(c >= 'a' && c <= 'z')) && (c !== '_')) {
                div.innerHTML += "用户名包含非法字符！<br>";
                ef = true;
                break;
            }
        }
    }

    // 检查密码
    var password = document.form.password.value;
    if (password === "") {
        div.innerHTML += "密码不能为空！<br>";
        ef = true;
    } else if (password.length < 4 || password.length > 16) {
        div.innerHTML += "密码长度为4-16位！<br>";
        ef = true;
    }

    // 检查重复密码
    var confirm = document.form.confirm.value;
    if(confirm !== password){
        div.innerHTML += "两次密码输入不一致！<br>";
        ef = true;
    }

    // 检查邮箱
    var email = document.form.email.value;
    if(!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(email)){
        div.innerHTML += "邮箱格式不正确！<br>";
        ef = true;
    }

    // 检查身份证
    var id = document.form.idCard.value;
    if(!/^\d{17}[\d|X]$|^\d{15}$/.test(id)) {
        div.innerHTML += "身份证不正确！<br>";
        ef = true;
    }

    if (!ef)
        div.innerHTML = "";

    return ef;
}

function register() {
    var ef = checkForm();
    if (ef) {
        alert("注册信息有误！无法注册。");
    } else {
        document.form.submit();
    }
}