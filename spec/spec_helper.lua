package.path = package.path .. ";/?.lua;/?/init.lua;/Users/sin/vanilla/framework/0_1_0_rc7/?.lua;/Users/sin/vanilla/framework/0_1_0_rc7/?/init.lua;;";
package.cpath = package.cpath .. ";/?.so;/Users/sin/vanilla/framework/0_1_0_rc7/?.so;;";

Registry={}
Registry['APP_ROOT'] = '/Users/sin/htdocs/vanilla-demo'
Registry['APP_NAME'] = 'vanilla-demo'

LoadV = function ( ... )
    return require(...)
end

LoadApp = function ( ... )
    return require(Registry['APP_ROOT'] .. '/' .. ...)
end

LoadV 'vanilla.spec.runner'
