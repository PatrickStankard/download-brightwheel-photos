async function getAllPhotoUrls(document, jQuery) {
    var $studentFeed = null;
    var $loadMoreButton = null;
    var $loadingDiv = null;
    var photoUrls = [];

    async function loadAllFeedItems() {
        console.log('[download-brightwheel-photos] Loading all feed items...');

        getElements();

        while ($loadMoreButton.length > 0 || $loadingDiv.length > 0) {
            scrollToBottom();
            clickLoadMoreButton();
            await sleep(500);
            getElements();
        }

        console.log('[download-brightwheel-photos] Finished loading all feed items');
    }

    function getElements() {
        $studentFeed = jQuery('div.StudentFeed');
        $loadMoreButton = $studentFeed.find('button[data-testid="load-button"]');
        $loadingDiv = $studentFeed.find('div[role="status"]');
    }

    function clickLoadMoreButton() {
        if ($loadMoreButton.length > 0) {
            $loadMoreButton.click();
        }
    }

    function scrollToBottom() {
        document.documentElement.scrollTop = document.documentElement.scrollHeight;
    }

    function populatePhotoUrls() {
        console.log('[download-brightwheel-photos] Getting all photo URLs...');

        $photos = $studentFeed.find('div[class^="activity-card-module-content"]')
                              .find('a[href^="https://cdn.mybrightwheel.com/media_images/images/"]');

        $photos.each(function() {
            photoUrls.push('"' + jQuery(this).attr('href') + '"');
        });

        console.log('[download-brightwheel-photos] Finished getting all photo URLs');
    }

    function printPhotoUrlsBashArray() {
        console.log('[download-brightwheel-photos] Printing PHOTO_URLS Bash array variable definition...');
        var photoUrlsBashArray = "PHOTO_URLS=( " + photoUrls.join(' ') + " )";
        console.log(photoUrlsBashArray);
    }

    function sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }

    await loadAllFeedItems();
    populatePhotoUrls();
    printPhotoUrlsBashArray();

    console.log('[download-brightwheel-photos] Done!');
}

var jquery = document.createElement('script');
jquery.src = "https://code.jquery.com/jquery-latest.min.js";
jquery.onload = function() { jQuery.noConflict(); getAllPhotoUrls(document, jQuery); }
document.head.appendChild(jquery);
