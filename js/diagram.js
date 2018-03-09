function openPropertyTab(evt, occurrenceId, propertySet) {

    if (evt.stopPropagation) {
        evt.stopPropagation();   // W3C model
    } else {
        evt.cancelBubble = true; // IE model
    }

    var i;
    var x = document.getElementsByClassName("properties-set");
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none"; 
    }

    propertiesSetButtons = document.getElementsByClassName("properties-set-button");
    for (i = 0; i < propertiesSetButtons.length; i++) {
        if ( propertiesSetButtons[i].className.indexOf("w3-blue") > 1 ) {
            propertiesSetButtons[i].className = propertiesSetButtons[i].className.replace(" w3-blue", "");
        }
    }
    
    document.getElementById("prop-"+propertySet+"-"+occurrenceId).style.display = "block";
    
    if (evt.currentTarget.className.indexOf("occurrenceSelector") == -1) { 
        evt.currentTarget.className += " w3-blue";
    } else {
        document.getElementById("prop-but-core-"+occurrenceId).className += " w3-blue";
    }
};

function openItemPropertyTab(evt, itemId) { 
    var i;

    var x = document.getElementsByClassName("diagram-properties");
    for (i = 0; i < x.length; i++) {

        if (x[i].className.indexOf("w3-hide") == -1 ) {
            x[i].className += " w3-hide";
        }
    }

    var x = document.getElementsByClassName("diagram-properties");
    for (i = 0; i < x.length; i++) {
        if (x[i].className.indexOf("w3-show") > 1 ) {
            x[i].className.replace( " w3-show", "");
        }
    }

    var x = document.getElementById("prop-"+itemId);
    if (x.className.indexOf("w3-show") == -1) {
        openPropertyTab( evt, itemId, "core");
        x.className += " w3-show";
        evt.currentTarget.className += " w3-blue";

    } else { 
        x.className = x.className.replace(" w3-show", "");
        evt.currentTarget.className = evt.currentTarget.className.replace(" w3-blue", "");
    }   
};

