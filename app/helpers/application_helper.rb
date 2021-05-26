module ApplicationHelper
	def number_to_brl(number)
		number_to_currency(number, unit: 'R$ ', delimiter: '.', separator: ',')
	end

	def date_to_br(date)
		date.strftime('%d/%m/%Y')
	end
end
