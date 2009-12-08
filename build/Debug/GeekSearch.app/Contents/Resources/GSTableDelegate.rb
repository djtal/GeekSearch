#
#  GSTableDelegate.rb
#  GeekSearch
#
#  Created by Guillaume Garcera on 25/05/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#


#
# TableView Datasource delegate methods used to populate the table view
# Act as TableView delegate too
#
class GSTableDelegate
	attr_accessor :parent
	
	# datasource deleagate method
	def numberOfRowsInTableView(tableView)
		parent.results.size
	end
	
	def tableView(tableView, objectValueForTableColumn:column, row:row)
		parent.results[row].valueForKey(:name)
	end
	
	def	openInBrowser()
		NSWorkspace.sharedWorkspace.openURL(parent.results[parent.search_results.selectedRow].valueForKey("url"))
	end
	
end
