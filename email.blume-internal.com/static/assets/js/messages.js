$(function () {
  var sending = false;

  function displayAlert (type, head, message) {
    var $alert = $("#mail_alert").removeClass("alert-warning alert-danger alert-success").addClass("alert-" + type);
    $alert.find("strong").text(head);
    $alert.find("span").text(message);
    $alert.slideDown();
    setTimeout(function () {
      $alert.slideUp();
    }, 5000);
  }

  function messageSent () {
    $("#to,#subject,#message").prop("readonly", false).val("");
    displayAlert("success", "Sent!", "Message sent successfuly.");
    $("#mail_form").trigger("sent").trigger("message");
    sending = false;
  }

  function messageError () {
    hide_loading_bar();
    $("#to,#subject,#message").prop("readonly", false);
    displayAlert("danger", "Error:", "Unable to send message. Please try again.");
    $("#mail_form").trigger("error").trigger("message");
      sending = false;
  }


  $("#mail_form").submit(function (e) {
    e.preventDefault();

    if(!sending) {
      sending = true;

      show_loading_bar({
        pct: 100,
        delay: 60,
        before: function () {
          $("#subject,#message").prop("readonly", true);
          try {
            $.post(
              "/msg",
              $("#mail_form").serializeArray(),
              function(data){
                show_loading_bar({
                  pct: 100,
                  delay: 1,
                  finish: messageSent
                });
              }
            ).error(function () {
              messageError();
            });
          } catch (error) {
            messageError();
          }
        }
      });
    }
  });
});
