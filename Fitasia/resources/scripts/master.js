﻿
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

$(window).bind('scroll', function () {
    if ($(window).scrollTop() > 100) {
        $('#header').animate({ 'background-color': 'rgba(0, 0, 0, 0.3)' });
    }
    else {
        $('#header').animate({ 'background-color': 'rgba(0, 0, 0, 0.0)' });
    }
});


