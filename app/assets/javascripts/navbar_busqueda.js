/*global jQuery*/

jQuery(document).ready(function($) {
   $('#query').bind('keypress keydown keyup change',function(){
    var word = $(':input[id="query"]').val();
    $('a[id="searchlink"]').attr("href","patients?nombre=" + word.toString());
   });
});