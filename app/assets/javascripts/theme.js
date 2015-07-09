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
      position  = nav.offsetTop;

  function stick(){
    var scrollY = window.scrollY || window.pageYOffset;
    if (scrollY > position && !fixed) {
      fixed = true;
      nav.className = nav.className + ' fixed';
    } else if (scrollY <= position && fixed) {
      fixed = false;
      nav.classList.remove('fixed');
    }
  }

  window.onscroll = stick;

  //Make flash to desepare

  $(function() {
    setTimeout(function(){
      $('.alert').slideUp(1000);
    }, 2000);
  });
});
