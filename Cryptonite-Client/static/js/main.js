$(document).ready(function(){
    $("#tiles").randomize(".col-md-8 col-lg-6");
    $(".new").click(function(e){
         e.preventDefault();
         alert("a");
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
//.B, .G, .O, .P, .BL, .Y, .R, .W, .GR, .PI
