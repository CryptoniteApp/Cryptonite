

chrome.tabs.onUpdated.addListener (function (tabId, changeInfo, tab) {
    if (changeInfo.status == 'complete') {
        if (tab.url.indexOf("yahoo") != -1) {
            chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
                chrome.tabs.executeScript(null, {file: "content.js"});
            });
            
            /**
            window.setTimeout(function() {
                window.alert("hi again");
                document.getElementById('login-username').value = 'nathanielyoung';    
            }, 2000);
            **/
        } else {
            return;
        }
    }
    
    
});


chrome.browserAction.onClicked.addListener(function(activeTab) {
    var newTab = "index.html";
    chrome.tabs.create({ url: newTab });
});

/**
chrome.tabs.query({'active': true, 'windowId': chrome.windows.WINDOW_ID_CURRENT},
   function(tabs){
      currentURL = tabs.url;
   }
);

**/
