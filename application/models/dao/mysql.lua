
local mysql = require('resty.mysql')
local json = require('rapidjson')
local config = Registry['sys_conf']['v_resource']['mysql']
local _M = {}
local function new()
	if ngx.ctx['mysql'] then 
		return ngx.ctx['mysql']
	end
	local client, errmsg = mysql:new()
	if not client then return nil,errmsg end
	client:set_timeout(2000)
	local opt = {
		database = config['dbname'],
		user = config['user'],
		password = config['passwd'],
		max_packet_size = 1024 * 1024* 1024
	}
	if config['socket'] then
		opt.path = config['socket']
	else
		opt.host = config['host']
		opt.port = config['port']
	end
	local ok, errmsg = client:connect(opt)
	if not ok then return nil, errmsg end
	
	ok, errmsg = client:query('SET NAMES UTF8;')
	ngx.ctx['mysql'] = client

	return ngx.ctx['mysql']
end

local function close(keepalive)
	local keep = keepalive or true
	if keep and ngx.ctx['mysql'] then
		ngx.ctx['mysql']:set_keepalive(10000,100)
		ngx.ctx['mysql'] = nil
		return true
	end
	ngx.ctx['mysql']:close()
	ngx.ctx['mysql'] = nil
	return true

end
_M.close = close
_M.get = new
return _M