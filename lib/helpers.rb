module GetFunc
    class << self
        def get_uom(x)
        	uom_regex = [
                /(?<![^\sx])(\d*[\.,]?\d+)\s?(litre[s]?)(?![^\s])/i,
                /(?<![^\sx])(\d*[\.,]?\d+)\s?(fl oz)(?![^\s])/i,
                /(?<![^\sx])(\d*[\.,]?\d+)\s?([mcfd]?l)(?![^\s])/i,
                /(?<![^\sx])(\d*[\.,]?\d+)\s?([mk]?g)(?![^\s])/i,
                /(?<![^\sx])(\d*[\.,]?\d+)\s?([mc]?m)(?![^\s])/i,
                /(?<![^\sx])(\d*[\.,]?\d+)\s?(oz)(?![^\s])/i,
            ].find {|ur| x =~ ur}
            
            size = $1
            unit = $2

            uom = {
        		size: (size.gsub(",", ".") rescue nil),
        		unit: unit,
        	}

        	return uom
        end


        def get_pieces(x)
        	product_pieces_regex = [
                /(\d+)\s?per\s?pack/i,
                /(\d+)\s?pack/i,
                /(\d+)\s?pc[s]?/i,
                /(\d+)\s?pkt[s]?/i,
                #
                /(?<![^\s])(\d+)\s?-\s?p(?![^\s])/i,
                #
                /(?<![^\s])(\d+)\s?x\s?\d+/i,
                /[a-zA-Z]\s?x\s?(\d+)(?![^\s])/i,
                /(\d+)'?\s?s(?![^\s])/i,
            ].find {|ppr| x =~ ppr}
            product_pieces = product_pieces_regex ? $1.to_i : 1
            product_pieces = 1 if product_pieces == 0
            product_pieces ||= 1

            return product_pieces
        end


        def get_discount(base_price, customer_price)
        	discount = (((base_price - customer_price) / base_price.to_f) * 100).round(7)

        	return discount
        end
    end
end