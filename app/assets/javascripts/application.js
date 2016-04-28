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
//= require turbolinks
//= require_tree .

hljs_turbolinks_hack = function() {
	var elements = document.querySelectorAll('pre code');
	Array.prototype.forEach.call(elements, function(e, i){
		hljs.highlightBlock(e)
	});
}

document.addEventListener('page:change', hljs_turbolinks_hack, false);
document.addEventListener('page:restore', hljs_turbolinks_hack, false);
