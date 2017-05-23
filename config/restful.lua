local restful = {
    v1={},
    v={}
}

restful.v.GET = {
	
    {pattern = '/jlr', controller = 'index', action = 'getJlr'},
    {pattern = '/datacenter.html', controller = 'index', action = 'datacenter'},
    {pattern = '/vip_notify', controller = 'vip', action = 'notify'}
}

restful.v.POST = {
    {pattern = '/post', controller = 'index', action = 'post'},
    {pattern = '/user/login', controller = 'user', action = 'postlogin'}
    {pattern = '/user/signin', controller = 'user', action = 'signin'}
}

restful.v1.GET = {
    {pattern = '/api', controller = 'index', action = 'api_get'},
}

return restful
