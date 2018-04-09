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

function showOccurrenceTable(evt, componentId ) { 

    var i ;

    if (evt.stopPropagation) {
        evt.stopPropagation();   // W3C model
    } else {
        evt.cancelBubble = true; // IE model
    }

    var componentCard = document.getElementById(componentId)
    var occurrenceTable = document.getElementById("occurrencetable-"+componentId)

    if ( evt.currentTarget.className.indexOf("component-card") >= 0 ) { 
        componentCard.className = componentCard.className.replace(" w3-button", "");
        componentCard.className = componentCard.className.replace(" s2" , " s12");
        
        if (occurrenceTable.className.indexOf("w3-hide") >= 0 ) { 
            occurrenceTable.className += " w3-show";
            occurrenceTable.className = occurrenceTable.className.replace(" w3-hide", "");
        }
        
    }

    if ( evt.currentTarget.className.indexOf("table-close") >= 0 ) { 
        
        var occurrenceTableItems = document.querySelectorAll("#occurrencetable-"+componentId+" > table > tbody > tr");

        for ( i = 0; i < occurrenceTableItems.length; i++) { 
            if ( occurrenceTableItems[i].className.indexOf("w3-blue") >= 0 ) { 
                occurrenceTableItems[i].className = occurrenceTableItems[i].className.replace("w3-blue", "");
            }
        }

        var occurrenceProperties = document.querySelectorAll('[id^="prop-'+componentId+'"]')

        for (i = 0; i < occurrenceProperties.length; i++) {
            if ( occurrenceProperties[i].className.indexOf("w3-show") >= 0 ) { 
                occurrenceProperties[i].className += " w3-hide";
                occurrenceProperties[i].className = occurrenceProperties[i].className.replace(" w3-show", "" );
            } 
        }

        if ( occurrenceTable.className.indexOf("w3-show") >= 0 ) { 
            occurrenceTable.className += " w3-hide";
            occurrenceTable.className = occurrenceTable.className.replace(" w3-show", "");
        }

        componentCard.className += " w3-button";
        componentCard.className = componentCard.className.replace(" s12" , " s2");

    }
}

function showResourceTab(evt, resourceId) { 

    if (evt.stopPropagation) {
        evt.stopPropagation();   // W3C model
    } else {
        evt.cancelBubble = true; // IE model
    }

    resourceTab = document.getElementById("resource-properties-"+resourceId );
        
    if (resourceTab.className.indexOf("w3-hide") >= 0 ) { 
        resourceTab.className += " w3-show";
        resourceTab.className = resourceTab.className.replace(" w3-hide", "");
        evt.currentTarget.className = evt.currentTarget.className.replace(" s2", " s4");
    }
    else { 
        resourceTab.className = resourceTab.className.replace(" w3-show", " w3-hide");
        evt.currentTarget.className = evt.currentTarget.className.replace(" s4", " s2");
    }   
}