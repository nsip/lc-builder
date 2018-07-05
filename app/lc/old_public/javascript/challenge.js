// challenge.js



// console.log("sting: ", ChallengeSting);
// console.log("desc: ", ChallengeDescription);


// show the challenge text if set
var sting = document.getElementById("lc-sting");
sting.onchange = function() {
    ChallengeSting = sting.value;
    console.log(ChallengeSting);
};
if (ChallengeSting != "") {
    sting.value = ChallengeSting;
    console.log(sting);
}
var description = document.getElementById("lc-description");
description.onchange = function() {
    ChallengeDescription = description.value;
    console.log(ChallengeSting);
};
if (ChallengeDescription != "") {
    description.value = ChallengeDescription;
    console.log(description);
}


// align-btn handler
document.getElementById("align-btn").onclick = showAlignedCurriculumResponse;


// set up a request handler
// var xhttp = new XMLHttpRequest();

function showAlignedCurriculumResponse() {

    var desc = document.getElementById("lc-description").value;

    var alignDiv = document.getElementById("alignment-content");
    var currList = document.getElementById("curriculum-list");

    alignDiv.classList.add("hide");
    currList.classList.add("hide");

    removePreviousResults();
    doCurriculumAlignmentRequest(desc);

    alignDiv.classList.remove("hide");
    currList.classList.remove("hide");


}


function removePreviousResults() {
    results = document.getElementsByClassName("avatar");

    while (results[0]) {
        results[0].parentNode.removeChild(results[0]);
    }
}

function doCurriculumAlignmentRequest(description) {

    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = JSON.parse(this.responseText);
            listAlignedStatements(response);
        }
    };
    var params = "text=" + description;
    xhttp.open("GET", "/curricalign?" + params, true);
    xhttp.setRequestHeader("Content-type", "application/json");
    xhttp.send(null);
}


function listAlignedStatements(statementsList) {

    for (i in statementsList) {

        var item = statementsList[i];

        // get the list we want to add to
        var currList = document.getElementById("curriculum-list");
        var listItem = document.createElement("li");
        listItem.className = "collection-item avatar";

        // set the icon style based on result weighting
        var icon = document.createElement("i");
        if (item.Score > -30) {
            icon.className = "material-icons circle green";
        } else {
            icon.className = "material-icons circle blue";
        }
        var iconName = document.createTextNode("location_on");
        icon.appendChild(iconName);
        listItem.appendChild(icon);

        // set the title of the list item
        var title = document.createElement("span");
        title.className = "title";
        var titleText = document.createTextNode(item.Item);
        title.appendChild(titleText);
        listItem.appendChild(title);

        // add the content from the item
        var row = document.createElement("div");
        row.className = "row";
        var col1 = document.createElement("div");
        col1.className = "col s8";
        row.appendChild(col1);
        listItem.appendChild(row);
        var contentPara = document.createElement("p");
        var contentText = document.createTextNode(item.Text);
        contentPara.appendChild(contentText);
        col1.appendChild(contentPara);

        // add the checkbox to confirm use of this item
        var col2 = document.createElement("div");
        col2.className = "col s4";
        row.appendChild(col2);
        var label = document.createElement("label");
        var chk = document.createElement("input");
        chk.type = "checkbox";
        var chkText = document.createElement("span");
        if (item.Score > -30) {
            var chkCaption = document.createTextNode("Nailed It");
        }
        else {
            var chkCaption = document.createTextNode("Notify");
        }
        chkText.appendChild(chkCaption);
        label.appendChild(chk);
        label.appendChild(chkText);
        col2.appendChild(label);

        // 
        // no external links yet...
        // 
        // add a link arrow to the item url
        // var link = document.createElement("a");
        // link.className = "secondary-content";
        // link.href = item.Url;
        // link.target = "_blank";
        // var linkIcon = document.createElement("i");
        // linkIcon.className = "material-icons";
        // var linkIconName = document.createTextNode("arrow_forward");
        // linkIcon.appendChild(linkIconName);
        // link.appendChild(linkIcon);
        // listItem.appendChild(link);

        // console.log(listItem);

        currList.appendChild(listItem);
    }
}