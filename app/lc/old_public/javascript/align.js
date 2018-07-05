// align.js

// 
// javascript functions for the curriculum align ui
// 





function showAlignment() {
    $(document).ready(function() {
        clearAlignment();
        var content = createAlignUI();
        console.log(content);
        $("#replace").append(content);
    });
}


function clearAlignment() {
    $("#replace").empty()
}

function createAlignUI() {

    // create placeholder
    var $alignContent = $("<div></div>", { id: "align-ui" });

    // create title
    var $title = $("<span>Curriculum Alignment</span>")
        .addClass("card-title")
        .css("margin-bottom", "30px")
        .appendTo($alignContent);

    var $outerRow = $("<div>")
        .addClass("row")
        .appendTo($alignContent);

    var $form = $("<form>")
        .addClass("col s12")
        .appendTo($outerRow);

    // sting
    var $stingRow = $("<div>")
        .addClass("row")
        .appendTo($form);

    var $stingWrapper = $("<div>")
        .addClass("input-field col s12")
        .appendTo($stingRow);

    var $label = $("<label>Sting</label>")
        .attr("for", "lc-sting")
        .appendTo($stingWrapper);

    var $input = $("<input>")
        .addClass("validate")
        .attr("id", "lc-sting")
        .attr("type", "text")
        .attr("placeholder", "")
        .appendTo($stingWrapper);

    // description
    var $descRow = $("<div>")
        .addClass("row")
        .appendTo($form);

    var $descWrapper = $("<div>")
        .addClass("input-field col s10")
        .appendTo($descRow);

    var $description = $("<textarea>")
        .addClass("materialize-textarea")
        .attr("id", "lc-description")
        .appendTo($descWrapper);

    var $label = $("<label>Description</label>")
        .attr("for", "lc-description")
        .appendTo($descWrapper);

    // align button
    var $btnCol = $("<div>")
        .addClass("col s2")
        .appendTo($descRow);

    var $btn = $("<a>")
        .attr("id", "align-btn")
        .addClass("waves-effect waves-teal btn-flat")
        .on("click", function(){
        	showAlignerResponses();
        })
        .appendTo($btnCol);

    var $btnIcon = $("<i>blur_linear</i>")
        .addClass("material-icons center")
        .appendTo($btn);

    // align service response list

    var $listDiv = $("<div>")
        .addClass("hide")
        .attr("id", "aligner-response")
        .appendTo($alignContent);

    var $title = $("<span>Alignment</span>")
        .addClass("title")
        // .css("margin-bottom", "30px")
        .appendTo($listDiv);

    var $list = $("<ul>")
        .attr("id", "align-response-list")
        .addClass("collection with-header")
        .addClass("hide")
        .appendTo($listDiv);

    var $listHeaderItem = $("<li>Applicable Curriculum Statements</li>")
        .addClass("collection-header")
        .appendTo($list);

    return $alignContent;
}