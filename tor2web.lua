local socks5 = require 'socks5'
local ngx = require 'ngx'

local tor2web = {}

local anyhost = "(.*)"

tor2web.handle_tor2web = function(mysuffix, torhost, torport)
    if not torhost then
        torhost = '127.0.0.1'
    end
    if not torport then
        torport = 9050
    end

	local host = ngx.req.get_headers()['Host']
	local repl = anyhost .. mysuffix
	local repl_regex = '^' .. repl .. '$';
    if not host:match(repl_regex) then
        ngx.say('Bad domain: ' .. host)
        return	
    end	
	local targethost = host:gsub(repl_regex, "%1");
	
    socks5.handle_request(torhost, torport,
    function(clheader)
        return clheader
        :gsub("HTTP/1.1(%c+)", "HTTP/1.0%1")
        :gsub(host, targethost)
        :gsub("Connection: keep%-alive", "Connection: close")
        :gsub("Accept%-Encoding: [%w%p ]+%c+", "")
    end,
    function(soheader)
        return soheader
        :gsub(targethost, host)
    end)
end

return tor2web

