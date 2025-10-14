local func = { client = {}, server = {}, object = {} }

func.client.getPlayerData = function()
	print('^1[FALLBACK] ^7Using fallback for ^1getPlayerData^7.')

	return {
		identifier = '',
		name = '',
		job = {
			name = '',
			label = '',
			grade = 0,
			gradeName = '',
			onDuty = false,
		}
	}
end

func.server.getPlayerData = function(src)
	print('^1[FALLBACK] ^7Using fallback for ^1getPlayerData^7.')

	return {
		identifier = '',
		name = '',
		job = {
			name = '',
			label = '',
			grade = 0,
			gradeName = '',
			onDuty = false,
		}
	}
end

func.server.getSourceByIdentifier = function(identifier)
	print('^1[FALLBACK] ^7Using fallback for ^1getSourceByIdentifier^7.')

	return nil
end

func.server.getPlayerMoney = function(src, type)
	print('^1[FALLBACK] ^7Using fallback for ^1getPlayerMoney^7.')

	return 0
end

func.server.addPlayerMoney = function(src, type, amount)
	print('^1[FALLBACK] ^7Using fallback for ^1addPlayerMoney^7.')

	return false
end

func.server.removePlayerMoney = function(src, type, amount)
	print('^1[FALLBACK] ^7Using fallback for ^1removePlayerMoney^7.')

	return false
end

func.server.createUseableItem = function(name, cb)
	print('^1[FALLBACK] ^7Using fallback for ^1createUseableItem^7.')
end

return func
