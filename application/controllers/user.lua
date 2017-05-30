local UserController = {}
local json = require('rapidjson')
local json_encode = json.encode
local json_decode = json.decode
local db = LoadModel('service.db')
local redis = LoadModel('service.redis')
local user_model = LoadModel('service.user')

function UserController:login()
	local view = self:getView()
	return view:display()
end

function UserController:jlr()
	local redis = loadModel('service.redis')
end
function UserController:postCategory()
	local user_id = auth:check_login()
	local category = LoadModel('service.category')
end
function UserController:postLogin()
	local params = self:getRequest():getParams()
	local username = params['username'] or ''
	local passwd = params['passwd'] or ''
	
end


-- user shutdown
function UserController:logff()

end

--user login
function UserController:postlogin()
	local params = self:getRequest():getParams()
	local username = params['username'] or ''
	local passwd = paras['passwd'] or ''
	return json_decode {
		status = 0
	}
end
-- user information
function UserController:userinfo()
	local user_id = check_auth()

end

-- user register page
function UserController:register()
	local params = self:getRequest():getParams()

end

return UserController