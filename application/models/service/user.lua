local mysql = LoadApplication('models.dao.mysql')
local json = require('rapidjson')
local UserService = {}
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

function UserService:get(id)
    local id = id or 0
    if id == 0 then return {} end
    local db = mysql.get()
    local sql = format('select * from cc_user  where uid = 1')
    local res = mysql.exec(sql)
    ngx.say(json.encode(res))
end

function UserService:find()

end

function UserService:create(user)

end

return UserService
