$(document).ready(function () {

  $(window).scroll(function () {
    if ($(this).scrollTop() > 400) {
      $('.to-top').fadeIn();
    } else {
      $('.to-top').fadeOut();
    }
  });

  $('.to-top').click(function () {
    $('html, body').animate({
      scrollTop: 0
    }, 600);
    return false;
  });

  var fixed = false,
      nav       = document.getElementById('navigation'),
      position  = nav.offsetTop,
      $container = $('.container.main'),
      o1 = $('#navigation').offset(),
      o2 = $container.offset(),
      dy = o2.top - o1.top;

  function stick(){
    var scrollY = window.scrollY || window.pageYOffset;
    if (scrollY > position && !fixed) {
      fixed = true;
      nav.className = nav.className + ' fixed';
      $container.css('padding-top', dy + 'px');
    } else if (scrollY <= position && fixed) {
      fixed = false;
      nav.classList.remove('fixed');
      $container.css('padding-top', 0);
    }
  }

  window.onscroll = stick;
});
