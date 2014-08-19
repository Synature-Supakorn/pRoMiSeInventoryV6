/* XmlHttpRequest library */
/* Version 0.9.2.2, 6 May 2005, Adamv.com */
function _getXmlHttp()
{
try { return new XMLHttpRequest();}
catch (e2) {return null; }
}

function CachedResponse(response) {
this.readyState = ReadyState.Complete
this.status = HttpStatus.OK
this.responseText = response
}

ReadyState = {
Uninitialized: 0,
Loading: 1,
Loaded:2,
Interactive:3,
Complete: 4
}

HttpStatus = {
OK: 200,
NotFound: 404
}

function Request_from_cache(url, f_change) {
var result = this._cache[url];

if (result != null) {
var response = new CachedResponse(result)
f_change(response)
return true
}
else
return false
}

function Request_cached_get(url, f_change) {
if (!this.FromCache(url, f_change)){
var request = this
this.Get(url,
/* Cache results if request completed */
function(x){
if ((x.readyState==ReadyState.Complete)&&(x.status==HttpStatus.OK))
{request._cache[url]=x.responseText}
f_change(x)
},
"GET")
}
}

function Request_get(url, f_change, method) {
if (!this._get) return;

if (method == null) method="GET"
if (this._get.readyState != ReadyState.Uninitialized)
this._get.abort()

this._get.open(method, url, true);

if (f_change != null) {
var _get = this._get;
this._get.onreadystatechange = function(){f_change(_get);}
}
this._get.send(null);
}

function Request_get_no_cache(url, f_change, method){
var sep = (-1 < newurl =" url" __="" get =" Request_get" getnocache =" Request_get_no_cache" cachedget =" Request_cached_get" fromcache =" Request_from_cache" use =" function(){return" cancel =" function(){if" _cache =" new" _get =" _getXmlHttp();" _get ="=">
}