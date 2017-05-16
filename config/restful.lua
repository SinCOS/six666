local restful = {
    v1={},
    v={}
}

restful.v.GET = {
    {pattern = '/get', controller = 'index', action = 'get'},
    {pattern = '/datacenter.html', controller = 'index', action = 'datacenter'},
}

restful.v.POST = {
    {pattern = '/post', controller = 'index', action = 'post'},
}

restful.v1.GET = {
    {pattern = '/api', controller = 'index', action = 'api_get'},
}

return restful
