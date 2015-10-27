// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales/es-ES
//= require_tree .

// Para desaparecer las notificaciones y alertas
$(document).ready(function () {
    setTimeout(function () {
        $("#notice_wrapper").fadeOut("slow", function () {
            $(this).remove();
        })
    }, 5000);
});

// wysihtml5 editor for body post
$(document).ready(function(){

    $('#wysihtml5s').each(function(i, elem) {
        $(elem).wysihtml5();
    });

})