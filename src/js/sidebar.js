function changeOpenMenus() {
    var treeMenuElements = document.querySelectorAll("#tree li");
    for (i in treeMenuElements)
    {
        if (treeMenuElements[i].classList && treeMenuElements[i].classList.contains('collapsible-list-open')){
            treeMenuElements[i].className = 'collapsibleListOpen';
            treeMenuElements[i].firstElementChild.style.display = 'block';
        }

    }
}