SMODS.Joker {
	key = "looping_rooms"
	name = "Looping the Rooms",
	config = {
		extra = {
			diamond_count = 0
		}
	},
	rarity = 3,
	loc_vars = function(self, info_queue, card)
		return {card.ability.extra.diamond_count}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local diamonds_scored = 0
			for _, scored_card in ipairs(context.scoring_hand) do
				if scored_card:is_suit('Diamonds') then
					diamonds_scored = diamonds_scored + 1
				end
			end
			if diamonds_scored > 0 then
				card.ability.extra.diamond_count = card.ability.extra.diamond_count + diamonds_scored
				if card.ability.extra.diamond_count >= 39 then
					G.GAME.round_resets.ante = G.GAME.round_resets.ante - 1
					card.ability.extra.diamond_count = 0
					return {
						message = "Looped!",
						colour = G.C.RED
					}
				end
			end
		end
	end
}