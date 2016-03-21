function get_wallpapers(page, category, clr, collection) {
    wallpapersView.status = false

    var mode_index = filter_by;

    switch (mode_index) {
        case 0:
            var url = api_url + '?auth=' + auth_key + '&method=featured&page=' + page + '&info_level=3';
        break;
        case 1:
            var url = api_url + '?auth=' + auth_key + '&method=newest&page=' + page + '&info_level=3';
        break;
        case 2:
            var url = api_url + '?auth=' + auth_key + '&method=highest_rated&page=' + page + '&info_level=3';
        break;
        case 3:
            var url = api_url + '?auth=' + auth_key + '&method=by_views&page=' + page + '&info_level=3';
        break;
        case 4:
            var url = api_url + '?auth=' + auth_key + '&method=by_favorites&page=' + page + '&info_level=3';
        break;
    }

    if (category && category != "0") {
        var url = api_url + '?auth=' + auth_key + '&method=category&id=' + category + '&page=' + page + '&info_level=3';
    }
    if (collection && collection != "0") {
        var url = api_url + '?auth=' + auth_key + '&method=collection&id=' + collection + '&page=' + page + '&info_level=3';
    }

    if (res_width != "" && res_height != "") {
        url = url + '&width=' + res_width + '&height=' + res_height;
    }

    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (clr != 'false') {
                wallpapersModel.clear()
            }

            var results = JSON.parse(xhr.responseText);

            var j;
            for (j in results) {
                if (j == 'wallpapers') {
                    var ii = 0;
                    for (var i = 0; i < objLength(results[j]); i++) {
                        var id = results[j][i]['id'];
                        var name = results[j][i]['name'];
                        var image = results[j][i]['url_thumb'];
                        var big_image = results[j][i]['url_image'];
                        wallpapersModel.append({"id":id, "name":name, "image":image, "big_image":big_image});
                        ii++;
                    }
                }
            }

            wallpapersView.status = true
        }
    }

    xhr.send();
}

function get_categories() {
    categoriesView.status = false

    var url = api_url + '?auth=' + auth_key + '&method=category_list';

    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            categoriesModel.clear()
            var results = JSON.parse(xhr.responseText);

            var j;
            for (j in results) {
                if (j == 'categories') {
                    var ii = 0;
                    for (var i = 0; i < objLength(results[j]); i++) {
                        var id = results[j][i]['id'];
                        var name = results[j][i]['name'];
                        var count = results[j][i]['count'];
                        categoriesModel.append({"nid":id, "name":name, "count":count});
                        ii++;
                    }
                }
            }

            categoriesView.status = true
        }
    }

    xhr.send();
}

function get_collections() {
    collectionsView.status = false

    var url = api_url + '?auth=' + auth_key + '&method=collection_list';

    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            collectionsModel.clear()
            var results = JSON.parse(xhr.responseText);

            var j;
            for (j in results) {
                if (j == 'collections') {
                    var ii = 0;
                    for (var i = 0; i < objLength(results[j]); i++) {
                        var id = results[j][i]['id'];
                        var name = results[j][i]['name'];
                        var count = results[j][i]['count'];
                        collectionsModel.append({"nid":id, "name":name, "count":count});
                        ii++;
                    }
                }
            }

            collectionsView.status = true
        }
    }

    xhr.send();
}

function get_search(page, term, clr) {
    wallpapersView.status = false

    var url = api_url + '?auth=' + auth_key + '&method=search&term=' + term + '&page=' + page + '&info_level=3';

    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (clr != 'false') {
                wallpapersModel.clear()
            }

            var results = JSON.parse(xhr.responseText);

            var j;
            for (j in results) {
                if (j == 'wallpapers') {
                    var ii = 0;
                    for (var i = 0; i < objLength(results[j]); i++) {
                        var id = results[j][i]['id'];
                        var name = results[j][i]['name'];
                        var image = results[j][i]['url_thumb'];
                        var big_image = results[j][i]['url_image'];
                        wallpapersModel.append({"id":id, "name":name, "image":image, "big_image":big_image});
                        ii++;
                    }
                }
            }

            wallpapersView.status = true
        }
    }

    xhr.send();
}

function objLength(obj){
  var i=0;
  for (var x in obj){
    if(obj.hasOwnProperty(x)){
      i++;
    }
  }
  return i;
}
