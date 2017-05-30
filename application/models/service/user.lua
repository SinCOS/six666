local mysql = LoadModel('dao.mysql')
local json = require('rapidjson')
local redis = LoadModel('service.redis')
local vcookie_lib = LoadV('vanilla.v.libs.cookie')
local UserService = Class('user')
local format = string.format 
local _table = 'cc_user'
local function exec(sql)
	local db = mysql.get()
	local res, err, errno, sqlstate = db:query(sql)
	mysql.close()
	return res, err, errno, sqlstate
end


local function parse_sql(sql,params)
	if not params or #params == 0 then
		return sql
	end

	local new_params = {}
	for i, v in ipairs(params) do
		if v and type(v) == 'string' then
			v = ngx.quote_sql_str(v)
		end
		table.insert(new_params,v)
	end
end
local function query(sql,params)
	local sql = parse_sql(sql,params)
	return exec(sql)
end
local function insert(sql,params)
	local sql = parse_sql(sql,params)
	return exec(sql)
end

function UserService:__construct()
	self.user_id = auth:check_login() or 0

end

function UserService:get()
   	local client = redis.new()
   	client:select(2)
   	return json.decode(client:get('usr:'..self.user_id) or '{}')
end
function UserService:setVip()
	local db = mysql.get()
	local ok, err = pcall(function()
		
	end,db)
	if not ok then 
		db:query('rollback;')
	end
end
function UserService:login_success(user)
	-- local cjson = require('cjson')
	local cookie = vcookie_lib()
	local redis = LoadModel('service.redis').new({db_index = 0})
	redis:init_pipeline()
	redis:set('666','123')
	redis:expire('666',10)
	redis:commit_pipeline()
	cookie:set('auth_code',12123)

end
function UserService:login(username,password)
	local sql = format("select * from cc_user where (username = %s or email = %s) limit 1; ",username,password)
	local db = mysql.get()
	local res, err, errno, sqlstate = db:query(sql)
	if not res or #res == 0 then return false end
	if res[1]['password'] ~= ngx.md5(password) then return false end
	self:login_success(res[1])
	return res[1]['id']
end

function UserService:create(user)
	local sql = format("insert into cc_user(username,password,email,status,created_at) values(%s,'%s',%s,1,uninx_timstrap")
end

return UserService
