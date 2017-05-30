local restful = {
    v1={},
    v={}
}

restful.v.GET = {

    {pattern = '/jlr', controller = 'index', action = 'getJlr'},
    {pattern = '/datacenter.html', controller = 'index', action = 'datacenter'},
    {pattern = '/vip_notify', controller = 'vip', action = 'notify'},
    {pattern = '/auth/signin', controller = 'auth', action = 'getsignin'},
    {pattern = '/auth/signup', controller = 'auth', action = 'getsignup'}

}

restful.v.POST = {
    {pattern = '/post', controller = 'index', action = 'post'},
    {pattern = '/user/login', controller = 'user', action = 'postlogin'},
    {pattern = '/auth/signin', controller = 'auth', action = 'postsignin'},
    {pattern = '/auth/signup', controller = 'auth', action = 'postsignup'}

}

restful.v1.GET = {
    {pattern = '/api', controller = 'index', action = 'api_get'},
}

return restful
