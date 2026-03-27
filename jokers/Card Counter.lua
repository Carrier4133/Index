SMODS.Joker {
	key = "card_counter",
	name = "Card Counter",
	config = {
		extra = {
			chips = 0
		}
	},
	atlas = "placeholders",
	pos = {x = 0, y = 0},
	rarity = 2,
	loc_vars = function(self, info_queue, card)
		return {card.ability.extra.chips}
	end,
	calculate = function(self, card, context)
		local function get_rank_value(target_card)
			if not target_card or not target_card.base or not target_card.base.value then
				return 0
			end
			local v = target_card.base.value
			if v == "Ace" then
				return 14
			elseif v == "King" then
				return 13
			elseif v == "Queen" then
				return 12
			elseif v == "Jack" then
				return 11
			else
				return tonumber(v) or 0
			end
		end

		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end

		if context.post_trigger and context.other_card ~= card and not context.blueprint then
			local rank_value = get_rank_value(context.other_card)
			if rank_value > 0 then
				card.ability.extra.chips = (card.ability.extra.chips or 0) + rank_value
				SMODS.calculate_effect({
					message = "+" .. rank_value .. " Chips",
					colour = G.C.CHIPS,
				}, card)
			end
		end
	end,
}
