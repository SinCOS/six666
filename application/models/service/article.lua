local articleService = {}

function articleService:select()
	local db = mysql.get()
	local res, err = db:query('select * from cc_article limit 10;')
	if not res or #res ==0 then
		return {}
	end 
		return res
end

function articleService:find()
	local db = mysql.get()
	local res, err = db:query('select id from cc_user')
end