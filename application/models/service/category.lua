local category = Class("category")
local mysql = LoadModel 'dao.mysql'
local redis = LoadModel 'service.redis'
function category:__construct(user_id)
	self.user_id = user_id
end
local function _update_cache(params,del)
	local delete = del or false
	local db = mysql.get()
	local res, err 
	if delete and delete > 0 then
		res, err = db:query('update cc_stockGroup set status = 0 where uid = ' ..params['uid'] .. ' and id = ' .. delete)
		if not res or res.affected_row == 0 then reutrn false, err end
	end
	local res, err = db:query('select id,name from cc_stockGroup where uid = ' .. params['uid'] )
	local key = 'usr:' .. self.user_id ..':stockGroup'
	local client = redis:new({db_index = 2})
	client:init_pipeline()
	client:set('usr:' .. self.user_id ..':stockGroup',json.encode(res))
	client:expires(key,24*3600)
	client:commit_pipeline()
end
function category:add(params)
	local sql = format("insert into cc_stockGroup(name,uid,created_at,status,public) values(%s,%d,localtime(),1,1);",params['name'],params['uid'])
	local res, err = mysql:exec(sql)
	if not res or res.affected_row == 0 then return false,err end
	_update_cache(params)
	return true
end
function category:delete(params)
	_update_cache(params,params['id'])
end

function category:list(user_id)
	local key = 'usr:' ..user_id .. ':stockGroup'
	local res, err = redis:new({db_index=2}):get(key)
	if not res then
		res = _update_cache({uid=user_id})
	end
	return res
end

