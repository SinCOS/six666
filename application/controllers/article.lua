local articleController = {}
local redis = LoadModel 'service.redis'



function articleController:index()
	local view =self:getView()
	local client = redis:new({db_index =0})
	local res_json = client:get('last_news')
	return view:display()
end

function articleController:detail()

end

function articleController:comment()
	local view = self:getView()
	return view:display()
end
return articleController;