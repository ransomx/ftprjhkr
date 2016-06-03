var header = $get('header');
var range = 200;

$(window).on('scroll', function () {
    var scrollTop = $(this).scrollTop();
    var offset = header.offset().top;
    var height = header.outerHeight();
    offset = offset + height / 2;
    var calc = 1 - (scrollTop - offset + range) / range;

    header.css({ 'opacity': calc });

    if (calc > '1') {
        header.css({ 'opacity': 1 });
    } else if (calc < '0') {
        header.css({ 'opacity': 0 });
    }

});

$(document).ready(function () {
    $(document).scroll(function () {
        var top = $get(this).scrollTop();
        if (top < 150) {
            var dif = 1 - top / 150;
            $get("header").css({ opacity: dif });
        }
    })
});

var timer;
$(window).scroll(function () {
    $('header').stop().animate({ opacity: 0.2 }, 10);
    clearInterval(timer);
    timer = setInterval(function () {
        $('header').stop().animate({ opacity: 1 }, 'fast');
    }, 100);
});
