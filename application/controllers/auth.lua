local json = require 'rapidjson'
local user_model = LoadModel('service.user')
local sql_str = ngx.quote_sql_str
local M = {}


local function getSignUp(self)
	return self:getView():display()
end


local function postSignUp(self)

end

local function postSignIn(self)

	local params = self:getRequest():getParams()
	local logined = user_model:login(sql_str(params['username'] or ''),params['password'])
	if logined then
		ngx.redirect('/')
	end
 	return 
end


local function getSignIn(self)
	return self:getView():display()
end


M.getsignin = getSignIn
M.postsignin = postSignIn
M.getsignup = getSignUp
M.postsignup = postSignUp

return M
