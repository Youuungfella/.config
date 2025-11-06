function FindProxyForURL(url, host) {
	var ciadpiSites = [
		"youtube.com", "netflix.com", "twitter.com",
		"instagram.com", "facebook.com","youtube.com", "youtu.be", "ytimg.com", "ggpht.com",
		"googlevideo.com", "googleapis.com", "gstatic.com"
	];
    
    host = host.toLowerCase();
    
    // Ciadpi сайты
    for (var i = 0; i < ciadpiSites.length; i++) {
        if (host.includes(ciadpiSites[i])) {
            return "SOCKS5 127.0.0.1:8888";
        }
    }
    
    // Все остальное - напрямую
    return "DIRECT";
}
