local libtest = Class('test')


function libtest:index()
	ngx.say('adsfasd')
end


function libtest:__construct()
	 print_r('===============init bbb=========')
	ngx.say('test')
end

return libtest