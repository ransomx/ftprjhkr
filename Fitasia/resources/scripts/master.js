function ChangeMenuOpacity() {
    $(window).scroll(function () {
        if ($(window).scrollTop() > 50) {
            $('#header').animate({'background-color': 'rgba(0, 0, 0, 0.3)'});
            $('.a').animate({'color': 'white' });
        }
        else {
            $alert("asdasd");
            $('#header').animate({ 'background-color': 'rgba(0, 0, 0, 0.0)' });
            $('.a').animate({ 'color': 'orange' });
        }
    });
}

function GoToOffer() {
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


