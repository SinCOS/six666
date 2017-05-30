local AdminPlugin = LoadV('vanilla.v.plugin'):new()

function AdminPlugin:routerStartup(request, response)
    print_r('<pre>')
    if request.method == 'GET' then
    	print_r(request)
        --print_r('-----------' .. sprint_r(request.headers) .. '----------')
    else
       --print_r(request.headers)
    end
end

function AdminPlugin:routerShutdown(request, response)

end

function AdminPlugin:dispatchLoopStartup(request, response)
	
end

function AdminPlugin:preDispatch(request, response)
	
end

function AdminPlugin:postDispatch(request, response)
end

function AdminPlugin:dispatchLoopShutdown(request, response)
	if ngx.ctx['mysql'] then
		ngx.ctx['mysql']:set_keepalive(10000,100)
		ngx.ctx['mysql'] = nil
	end
end

return AdminPlugin
