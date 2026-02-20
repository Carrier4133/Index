
SMODS.Joker {
	key = "Kings_Chariot"
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local faces = 0
			for _, scored_card in ipairs(context.scoring_hand) do
				if scored_card:is_face() then
					faces = faces + 1
					scored_card:set_ability(m_steel, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							scored_card:juice_up()
							return true
						end
					}))
					for _, hand_card in ipairs(G.hand.cards) do
						local rank = hand_card.base.value
						if rank == 'Jack' then rank = 11
						elseif rank == 'Queen' then rank = 12
						elseif rank == 'King' then rank = 13
						elseif rank == 'Ace' then rank = 14
						else rank = tonumber(rank) end
						if rank < lowest_rank then
							lowest_rank = rank
							lowest_card = hand_card
						end
					end
					if lowest_card then
						SMODS.destroy_cards({lowest_card})
					end
				end
			end
		end
	end
}