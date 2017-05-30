local libmid = Class('middle')
local redis = LoadModel('service.redis')
local json = require('rapidjson')
local vcookie_lib = LoadV('vanilla.v.libs.cookie')
local ngx_req = ngx.req
function libmid:__constuct(dispatch)
	self.dispatch = dispatch
end
function libmid:getAuthtoken()
	local auth_token = ngx_req.get_headers()['Authentication'];
	if not auth_token then
		local cookie = vcookie_lib()
		auth_token = cookie:get('auth_code')
	end
	if auth_token then return auth_token end
	return  false
end

function libmid:UserInfo()
	local user_id = self:check_login()	
	local client = redis:new()
	local res = client:get('usr:'..user_id)
	if not res then return {} end
	return json.decode(res) or {}
end

function libmid:check_login()
	local token = self:getAuthtoken()
	if not token then return false end
	
	return token

end

return libmid