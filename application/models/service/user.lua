local table_dao = LoadApplication('models.dao.mysql').new()
local UserService = {}
local format = string.format 
local _table = 'cc_user'

function UserService:get(id)
    local id = id or (return {})
    local sql, errmsg = format('select * from %s  where uid = ')
    if not sql then return {} end 
    return sql
end

function UserService:find()

end

function UserService:create(user)
	
end

return UserService
