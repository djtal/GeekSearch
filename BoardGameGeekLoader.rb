# BoardGameGeekLoader.rb
# GeekSearch
#
# Created by Guillaume Garcera on 08/12/09.
# Copyright 2009 __MyCompanyName__. All rights reserved.


class BoardGameGeekLoader

	@@base_url = "http://www.boardgamegeek.com/xmlapi/search?search=%1"


	
	#request delegate methods
	
	# called when request is fininshed
	# we can parse the response to get the search result now
	def parse(receivedData)
		result = []
		doc = NSXMLDocument.alloc.initWithData(receivedData,
												options:NSXMLDocumentValidate,
												error:nil)
		if doc
			games = doc.nodesForXPath("*/boardgame", error: nil)
			NSLog("Found : #{games.size} games")
			results = games.map do |g|
				game_id = g.attributeForName("objectid").stringValue
				NSLog("game id : #{game_id}");
				{
					:name => g.nodesForXPath("name", error: nil).first.stringValue(),
					:url => NSURL.URLWithString("http://www.boardgamegeek.com/boardgame/#{game_id}")
				}
				
			end
		end
	end
end