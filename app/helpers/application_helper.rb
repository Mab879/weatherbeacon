module ApplicationHelper
	def find_color
		@temp_diff = (@todays_high.to_i - @next_day_high.to_i)
		if (-5..5).include?(@temp_diff)
			"green"
		elsif @temp_diff < -5
			"white"
		elsif @temp_diff > 5
			"red"
		end
              end
	def flash
		if @preicp > 50
			"flash"
              end
	end
end
