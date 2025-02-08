const onMessage = (request, sender) => {
  if (request.method === 'playing') {
    chrome.action.setIcon({
      tabId: sender.tab.id,
      path: {
        '19': '/data/icons/16.png',
        '38': '/data/icons/32.png',
        '128': '/data/icons/128.png'
      }
    });
  }
};
chrome.runtime.onMessage.addListener(onMessage);

const sorting = (a, b) => {
  if (a.paused === false && b.paused) {
    return -1;
  }
  else if (b.paused === false && a.paused) {
    return 1;
  }
  else if (a.connected === false && b.connected) {
    return -1;
  }
  else if (b.connected === false && a.connected) {
    return 1;
  }
  else {
    return a.frameId - b.frameId;
  }
};

chrome.action.onClicked.addListener(async tab => {
  try {
    const r = await chrome.scripting.executeScript({
      target: {
        tabId: tab.id,
        allFrames: true
      },
      func: () => {
        const es = new Set();
        // collect all videos
        if (typeof videos === 'object') {
          [...videos].forEach(v => es.add(v));
        }
        [...document.querySelectorAll('video')].forEach(v => es.add(v));
        // sort
        return Array.from(es).map(e => ({
          paused: e.paused,
          connected: e.isConnected
        }));
      }
    });
    const video = (r || []).map(o => o.result.map(v => {
      v.frameId = o.frameId;
      return v;
    })).flat().sort(sorting).shift();

    if (video) {
      // update icon
      onMessage({
        method: 'playing'
      }, {
        tab
      });
      // prevent the page from exiting PiP view for 2 seconds
      const prefs = await new Promise(resolve => chrome.storage.local.get({
        'block-pip': true
      }, resolve));
      if (prefs['block-pip']) {
        await chrome.scripting.executeScript({
          target: {
            tabId: tab.id,
            frameIds: [video.frameId]
          },
          func: () => {
            self.pipobj = self.pipobj || {
              pointer: Document.prototype.exitPictureInPicture
            };
            clearTimeout(self.pipobj.id);
            self.pipobj.id = setTimeout(() => {
              Document.prototype.exitPictureInPicture = self.pipobj.pointer;
            }, 2000);
            Document.prototype.exitPictureInPicture = new Proxy(Document.prototype.exitPictureInPicture, {
              apply() {
                return console.log('Request to exit PiP is ignored');
              }
            });
          },
          world: 'MAIN'
        });
      }
      // detach
      await chrome.scripting.executeScript({
        target: {
          tabId: tab.id,
          frameIds: [video.frameId]
        },
        func: () => {
          /* global videos */
          const es = new Set();
          // collect all videos
          if (typeof videos === 'object') {
            [...videos].forEach(v => es.add(v));
          }
          [...document.querySelectorAll('video')].forEach(v => es.add(v));
          //
          const sorting = (a, b) => {
            if (a.paused === false && b.paused) {
              return -1;
            }
            else if (b.paused === false && a.paused) {
              return 1;
            }
            else if (a.connected === false && b.connected) {
              return -1;
            }
            else if (b.connected === false && a.connected) {
              return 1;
            }
          };
          const video = [...es].sort(sorting).shift();
          if (video) {
            video.requestPictureInPicture().catch(e => alert(e.message));
          }
        }
      });
    }
    else {
      throw Error('No player detected');
    }
  }
  catch (e) {
    console.warn(e);
    chrome.action.setBadgeText({
      tabId: tab.id,
      text: 'E'
    });
    chrome.action.setTitle({
      tabId: tab.id,
      title: e.message
    });
  }
});

/* badge */
{
  const once = () => chrome.action.setBadgeBackgroundColor({
    color: '#e34844'
  });
  chrome.runtime.onStartup.addListener(once);
  chrome.runtime.onInstalled.addListener(once);
}

{
  const {management, runtime: {onInstalled, setUninstallURL, getManifest}, storage, tabs} = chrome;
  if (navigator.webdriver !== true) {
    const page = getManifest().homepage_url;
    const {name, version} = getManifest();
    onInstalled.addListener(({reason, previousVersion}) => {
      if (reason === 'install') {
        chrome.tabs.create({ url: page});
      }
    });
    setUninstallURL(page + '/uninstall');
  }
}
