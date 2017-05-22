local  _M = {}
local ngx_time = ngx.time

function _M:order()
	local order = {
		uid = 1,
		orderID = ngx_time,

	}

end

function _M:notify()
	local params = self:getRequest():getParams()

end


