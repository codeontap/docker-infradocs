function openSideBarDeployments(evt, currentLevel, nextLevel) {

    var i;
    var x = document.getElementsByClassName("nav-"+currentLevel);
    for (i = 0; i < x.length; i++) {

        if (x[i].className.indexOf("w3-hide") == -1 ) {
            x[i].className += " w3-hide";
        }
    }
    
    var levelBar = document.getElementById("level-"+currentLevel)
    levelBar.className += " w3-show";
    var currentText = document.getElementById(evt.currentTarget.id).innerText;
    document.getElementById("level-text-"+currentLevel).innerText = currentText;

    document.getElementById("level-current").innerText = nextLevel;

    var deploymentNavs = document.getElementsByClassName("deployment-nav");
    
    for ( i = 0; i < deploymentNavs.length; i++ ) {
        
        if (deploymentNavs[i].id.indexOf(evt.currentTarget.id) >= 0 && deploymentNavs[i].classList.contains("deployment-"+nextLevel) ) {
            if (deploymentNavs[i].className.indexOf("w3-hide") >= 0 ) {
                deploymentNavs[i].className = deploymentNavs[i].className.replace(" w3-hide", "");
            }
            if (deploymentNavs[i].className.indexOf("w3-show") == -1 ) {
                deploymentNavs[i].className += " w3-show";
            }
            console.log(evt.currentTarget.className)
        }
        else {
            if (deploymentNavs[i].className.indexOf("w3-show") >= 0 ) {
                deploymentNavs[i].className = deploymentNavs[i].className.replace(" w3-show", "");
            }
            if (deploymentNavs[i].className.indexOf("w3-hide") == -1 ) {
                deploymentNavs[i].className += " w3-hide";
            }
        }
    }

}