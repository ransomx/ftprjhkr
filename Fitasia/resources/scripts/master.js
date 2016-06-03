function ChangeMenuOpacity(){
    $(window).scroll(function () {
        if ($(window).scrollTop() > 50) {
            $('#header').css('background', 'rgb(255, 255, 255)').stop().animate({ "opacity": "1" }, 200)
        }
        else if ($(window).scrollTop() < 50) {
            $('#header').css('background', 'rgb(255, 255, 255)').stop().animate({ "opacity": ".5" }, 200)
        }
    });
}

function GoToOffer(){
    $("#gotoOffer").click(function () {
        $('html, body').animate({
            scrollTop: $("#offers").offset().top
        }, 600);
        return false;
    });
}

function MenuClick() {
    $(".menubar a").each(function (index) {
        $(this).click(function () {

            if (($(this).text() == "Login") || $(this).text() == "Logga in") {
                $(".loginPanel").toggle(200);
                return false;
            }
        });
    });
}

function IniUpdate() {
    ChangeMenuOpacity();
    GoToOffer();
    MenuClick();
};

$(document).ready(IniUpdate);

function CloseDiv() {
    $(".loginPanel").toggle(200);
    return false;
}

var searchOpen = false;
function hideSearch() {
    $("#searchContent").toggle(300);
    if (searchOpen) {
        searchOpen = false;
        $("#toggleButton").text("OFFERS");
    } else {
        searchOpen = true;
        $("#toggleButton").text("HIDE");
    }
}


