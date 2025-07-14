'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "5f508d69fce7abd0cd59b0bd4a5080b5",
"assets/AssetManifest.bin.json": "3a73931cf017490750b2b2b139aba13b",
"assets/AssetManifest.json": "a6c6e3ac3ea48e12dca058131b5dff47",
"assets/assets/files/cankirkgoz-mobiledeveloper-resume.pdf": "29b358571446618bd92c6bcc93f1c1c0",
"assets/assets/fonts/Inter-Bold.ttf": "7ef6f6d68c7fedc103180f2254985e8c",
"assets/assets/fonts/Inter-Medium.ttf": "8540f35bf8acd509b9ce356f1111e983",
"assets/assets/fonts/Inter-Regular.ttf": "37dcabff629c3690303739be2e0b3524",
"assets/assets/fonts/Inter-SemiBold.ttf": "e5532d993e2de30fa92422df0a8849dd",
"assets/assets/icons/code_icon.png": "84e63a5082b550c074e64dfdadc9335c",
"assets/assets/icons/dart_icon.png": "9e1cb14cade7c3f3c6d256f1c968711d",
"assets/assets/icons/download.png": "3e83b3ea914cbf15378c4da68866c6ac",
"assets/assets/icons/education_icon.png": "c52b93c42114d3c941065ef9c8904ccb",
"assets/assets/icons/figma_icon.png": "4cf089d4b3d51d89f04eba85b62595bd",
"assets/assets/icons/firebase_icon.png": "a7aee5fd5df17a8e759efc63c6d7531b",
"assets/assets/icons/flutter_icon.png": "3c2c6c115979778e16d1c02b6ffb9176",
"assets/assets/icons/framework_icon.png": "758dfdd6695ad35671bc8bfd9bd43038",
"assets/assets/icons/github_icon.png": "8fc3e753835f3aed3f91a5353e93a24c",
"assets/assets/icons/git_icon.png": "983890d1d1d34d6926b0a372ac1e036f",
"assets/assets/icons/hive_icon.png": "37e0e1338c3138455f5fb2904ea4c2a9",
"assets/assets/icons/kotlin_icon.png": "667b8d9b74a8d237d754e87cc5db2cba",
"assets/assets/icons/music.png": "743420128c5cf5e0ce4bdf6bd0e4057d",
"assets/assets/icons/nodejs_icon.png": "de8248dee8d411a4ad75d1f03ec2d379",
"assets/assets/icons/phone_icon.png": "39051487a61b4324fda996b44e39a305",
"assets/assets/icons/postman_icon.png": "84340be75cec58ab93125ed0a3a8b99f",
"assets/assets/icons/reactnative_icon.png": "3e9d6905e04724310de0b2e75f1f25cd",
"assets/assets/icons/riverpod_icon.png": "aa900299ab9997b03e1be77c93e85e66",
"assets/assets/icons/rocket.png": "d4d36096522bed3c1b84695433a3c8b4",
"assets/assets/icons/share_icon.png": "5b3fb28b4965199299f52e6581269d90",
"assets/assets/icons/spotify.png": "3307f2fe93f63d32d073a2c26fdcd38f",
"assets/assets/icons/swift_icon.png": "e7b19cedf0f946533774ff213a22c3d3",
"assets/assets/icons/tensorflow_icon.png": "2010dbf84b702d6f1eae16944ed659bf",
"assets/assets/icons/tools.png": "927f0cc9e860f1fa1392b82209ff5a5a",
"assets/assets/images/baloons.png": "d3546edee71b1f80b0ff8146aae7e2aa",
"assets/assets/images/my_photo_first.JPG": "86da8f61b072f46ece76670e601dce68",
"assets/assets/images/my_photo_second.jpg": "da727ffe15f9fca804b4d8f5c51306d2",
"assets/assets/images/profile.jpg": "0c0ac507624973f0a8c10d32cbd7c803",
"assets/assets/images/ternai_mockup.png": "1c186eee34499651a9ec66aa1592c440",
"assets/assets/images/wedly_mockup.png": "2bebb357bae7bb61782d90108b9858ef",
"assets/cankirkgoz-mobiledeveloper-resume.pdf": "29b358571446618bd92c6bcc93f1c1c0",
"assets/FontManifest.json": "1a36d0fb6a74e9d1ecf11cdf73d4f0ad",
"assets/fonts/MaterialIcons-Regular.otf": "e560c9c781d204b621b21dbce75e66bd",
"assets/NOTICES": "22a0f789e220f4765d86f99f4d1c177f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "fb284f02523d68ea403e0418e1e0177b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "6a76095d220c1bd4c2b0527ffda382c4",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "8f0c27c06dc7f0b1bfe62adc2e25f0c9",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "730613135d90323de3d0988a1d6b631b",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "5cce1edf9169ad47eafb106559ea937b",
"/": "5cce1edf9169ad47eafb106559ea937b",
"main.dart.js": "ef25638b86f512f2f1aff201697e2acf",
"manifest.json": "d8fe34f7ae4c072a77b924e01dac8a50",
"portfolio-logo.png": "28706527d2938a501fed4dcbe8e16e85",
"version.json": "9b818ca9511483c901bed1545384376c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
