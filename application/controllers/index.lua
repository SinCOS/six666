-- local IndexController = Class('controllers.index', LoadApplication('controllers.base'))
-- local IndexController = Class('controllers.index')
local IndexController = {}
local user_service = LoadApplication('models.service.user')
local redis = LoadApplication('models.service.redis')

local json = require('rapidjson')
local json_encode = json.encode
local json_decode = json.decode
local mysql = LoadApplication('models.service.db')
function IndexController:index()
  local db = mysql.get()
  local res, errmsg = db:query('select * from cc_user limit 1')
  mysql.close()
  local view = self:getView()
  return view:display()
end
function IndexController:datacenter()
    local view = self:getView()
    return view:display()
end
function IndexController:echarts()
    local view = self:getView()
    return view:display()
end
function IndexController:getJlr()
    local db = redis.new()
    return json_encode(db:zrevrange("jlr:500",0,9,'withscores') or {})
end


-- curl http://localhost:9110/get?ok=yes
function IndexController:get()
    local get = self:getRequest():getParams()
    print_r(get)
    do return 'get' end
end

-- curl -X POST http://localhost:9110/post -d '{"ok"="yes"}'
function IndexController:post()
    local _, post = self:getRequest():getParams()
    print_r(post)
    do return 'post' end
end

-- curl -H 'accept: application/vnd.YOUR_APP_NAME.v1.json' http://localhost:9110/api?ok=yes
function IndexController:api_get()
    local api_get = self:getRequest():getParams()
    print_r(api_get)
    do return 'api_get' end
end

return IndexController
