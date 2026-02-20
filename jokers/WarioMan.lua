local cry = SMODS.find_mod("Cryptid")[1]
local biblio = SMODS.find_mod("Bibliography")[1]

if cry and biblio then
	SMODS.Joker:take_ownership("j_cry-wario")
		biblio_evolution = "j_index_warioman"
		biblio_evol_effect = function (self, newcard, oldextra)
			for _,v in ipairs{money} do
				newcard.ability.extra[v] = oldextra[v]
			end
		end,
	})
end

SMODS.Joker {
	key = "wario-man"
	name = "Wario-Man"
	config = {
        	extra = {
			chips = 20,
			mult = 2
		}
	},
	rarity = cry and "biblio_exalted" or "biblio_unavailable",
	calculate = function(self, card, context)
		if
			(
				context.post_trigger
				and not context.other_context.fixed_probability
				and not context.other_context.mod_probability
			) or context.forcetrigger
		then
			return {
				dollars = lenient_bignum(card.ability.extra.money),
				card = context.other_context and context.other_context.blueprint_card or context.other_card or nil,
			}
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips * math.max(0, (G.GAME.dollars + (G.GAME.dollar_buffer or 0)))
				mult = card.ability.extra.mult * math.max(0, (G.GAME.dollars + (G.GAME.dollar_buffer or 0)))
			}
		end
	end,
}