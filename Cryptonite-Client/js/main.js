$(document).ready(function(){
    $("#tiles").randomize(".col-md-8 col-lg-6");
    $("#topc").on("click", function(e) {
      e.preventDefault(); // cancel the link itself
      $.post(this.href, "2", "text/plain") {
    };
  });
});

  (function($) {
  $.fn.randomize = function(selector){
    (selector ? this.find(selector) : this).parent().each(function(){
        $(this).children(selector).sort(function(){
            return Math.random() - 0.5;
        }).detach().appendTo(this);
    });

    return this;
};

})(jQuery);

