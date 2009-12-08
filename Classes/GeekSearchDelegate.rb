#
#  GeekSearchDelegate.rb
#  GeekSearch
#
#  Created by Guillaume Garcera on 25/05/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require "cgi"

class GeekSearchDelegate
	attr_accessor :main_window
	attr_accessor :search_results
	attr_accessor :search_field
	
	attr_accessor :results

	def initialize()
		@results = []
	end

	def applicationDidFinishLaunching(notification)
		NSLog("It Work very well")
	end
	
	
	def	search_game(sender)
		@receivedData = nil
		@game_loader =  BoardGameGeekLoader.new
		str = CGI.escape(search_field.stringValue)
		str = str.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
		url = NSURL.URLWithString("http://www.boardgamegeek.com/xmlapi/search?search=#{str}")
		NSLog(url.absoluteString())
		request = NSMutableURLRequest.requestWithURL(url)
		NSURLConnection.connectionWithRequest(request, delegate: self)
		
	end
	
	
	#request delegate methods
	
	# called when request is fininshed
	# we can parse the response to get the search result now
	def connectionDidFinishLoading(connection)
		@results = @game_loader.parse(@receivedData)
		@search_results.reloadData
	end
	
	#called when we have new data on the request
	def connection(connection, didReceiveData:data)
		@receivedData ||= NSMutableData.new
		@receivedData.appendData(data)
	end
end
