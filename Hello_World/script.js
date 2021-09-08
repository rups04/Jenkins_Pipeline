function showTime() {
	document.getElementById('currentTime').innerHTML = new Date();
}
showTime();
setInterval(function () {
	showTime();
}, 1000);