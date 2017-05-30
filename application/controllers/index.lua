-- local IndexController = Class('controllers.index', LoadApplication('controllers.base'))
local IndexController = Class('controllers.index')
--local IndexController = {}
local user_service = LoadModel('service.user')
local redis = LoadModel('service.redis')
local test = LoadLibrary('test')
local json = require('rapidjson')
local json_encode = json.encode
local json_decode = json.decode

function IndexController:__construct()
    -- local view = self:getView()
    -- view:assign({
    --     auth = LoadLibrary('middle')()
    --     })
end
function IndexController:index()
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
function IndexController:i666()
    local sqlite3 = require('lsqlite3')
    local db = sqlite3.open('/usr/local/openresty/nginx/lua/0526.db')
    local tab_inrt = table.insert
    local _t = {
    ['code'] = 603558,
    ['zf'] = {},
    ['nxjlrjh'] = {},
    ['nxjlrch'] = {},
    ['nxjlr'] = {}
 }
    for row in db:nrows('select zf,nxjlrjh,nxjlrch,nxjlr from cc_stock_info where cpy_id = "603558" and addtime > "09:29" ; ') do
       tab_inrt(_t['zf'],row['zf'] or 0.00)
       tab_inrt(_t['nxjlrjh'],row['nxjlrjh'] or 0)
        tab_inrt(_t['nxjlrch'],row['nxjlrch'] or 0)
         tab_inrt(_t['nxjlr'],row['nxjlr'] or 0.00)
        
    end
    local res = {
    }
    for i,v in pairs(_t) do
        local _str = string.format('var %s = %s;',i,json.encode(v))
        tab_inrt(res,_str)
    end
    
    return table.concat(res,'')
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
