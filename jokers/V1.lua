SMODS.Joker {
	key = "V1"
	name = "V1"
	config = {
        	extra = {
			suit = 'Hearts',
			cost = 1,
			Xmult = 2
		},
	},
	rarity = 4,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) and (G.GAME.dollars + (G.GAME.dollar_buffer or 0)) - card.ability.extra.cost >= G.GAME.bankrupt_at then
			return {
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - card.ability.extra.cost
				xmult = card.ability.extra.Xmult
			}
		end
	end
}
				
		