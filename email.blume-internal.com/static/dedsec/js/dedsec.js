(function( $ ) {
  var dedsec = {
    warnings: [
      "Operative, let's not get distracted.",
      "We need you to do this.",
      "Focus on the task at hand.",
      "We don't have much time. Let's get this done.",
      "Remeber the mission."
    ],
    images: [
      "static/dedsec/images/i.png"
    ],
    init: function () {
      // LOAD STYLES
      $("head").append("<link>");
      var css = $("head").children(":last");
      css.attr({
        rel:  "stylesheet",
        type: "text/css",
        href: "static/dedsec/css/dedsec.css"
      });
      // CREATE HTML
      $("body").append(
        "<div id='dedsec-comunique' style='display:none;'><div class='dedsec-header'><span>DedSec Comunique</span><div class='dedsec-close'></div></div><img src='' alt='' class='alert-image'><div class='alert-text'><span></span></div><div class='confirm'>OK</div></div>"
      );
      // ADD EVENT HANDLERS
      $(window).keydown(function (e) {
        if(e.which == 13 && !$("*:focus").is("textarea, input")){
          dedsec.popdownWithGlass();
        }
      });
      $("#dedsec-comunique .dedsec-close, #dedsec-comunique .confirm").click(function () {    
        dedsec.popdownWithGlass();
      });
    },
    popup: function (text,image) {
      var image = image || 0;
      $("#dedsec-comunique .alert-image").attr("src", dedsec.images[image]);
      if(typeof text != "undefined") $("#dedsec-comunique .alert-text").text(text);
      $("#dedsec-comunique").show();
      $(window).trigger("popup");
    },
    popdown: function () {
      $("#dedsec-comunique").hide();
      $(window).trigger("popdown");
    },
    popupWithGlass: function (text,image) {
      dedsec.popup(text,image);
      dedsec.glass();
    },
    popdownWithGlass: function () {
      dedsec.popdown();
      dedsec.deglass();
    },
    glass: function () {
      $(".page-container,.login-container").addClass("glass");
      $(":focus").blur();
      $("body").focus();
      $("*:not(body,.glass)").on("focus.glass", function () {
        $(this).blur();
        $("body").focus();
      });
      $(window).trigger("glass");
    },
    deglass: function () {
      $(".page-container,.login-container").removeClass("glass");
      $("*").off("focus.glass");
      $(window).trigger("deglass");
    },
    glassIfNotRecent: function (name, time) {
      var time = time || 1000*60*20;
      var recent = localStorage.getItem(name);
      if(recent == "undefined" || recent < new Date() ) {
        localStorage.setItem(name, new Date((new Date().getTime() + time)));
        dedsec.glass();
        return true;
      }
      return false;
    },
    prevent: function (okay) {
      var okay = okay || "";
      if(typeof okay.jquery == "undefined") {
        okay = $(okay);
      }

      function nope () {
        dedsec.glass();
        if(dedsec.warnings.length) {
          dedsec.popup(dedsec.warnings.shift());
        } else {
          setTimeout(function () {
            $(".page-container").removeClass("glass");
          }, 200);
        }
      }

      function filterForOkay (index, element) {
        var $this = $(element);
        for (var i = 0; i < okay.length; i++) {
          if($this.is($(okay[i])) == true) {
            return false
          }
        }
        return true;
      }

      $("form").filter(filterForOkay).submit(function (e) {
        e.preventDefault();
        nope();
      });

      $("a").filter(filterForOkay).filter(function () {
        var $this = $(this),
        href = $this.attr("href"),
        prop = $this.prop("href");
        if(prop == document.location.href) {
          return false;
        }
        if(href == "#") {
          return false;
        }
        return true;
      }).click(function (e) {
        if(!e.isDefaultPrevented()){
          e.preventDefault();
          nope();
        }
      });
    }
  };

  dedsec.init();

  $.dedsec = dedsec;
}( jQuery ));
