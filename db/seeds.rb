# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.create!({:email => "amedhat.cs@gmail.com", :roles => ["admin"], :password => "12345678", :password_confirmation => "12345678" })

expenses = Expense.create([
	{description: 'desc1', amount: 10.5, comment: 'comm1', datetime: "2014-07-01 08:32:31", user: user}, 
	{description: 'desc2', amount: 11.5, comment: 'comm2', datetime: "2014-07-02 08:32:31", user: user}, 
	{description: 'desc3', amount: 12.5, comment: 'comm3', datetime: "2014-07-03 08:32:31", user: user}
	])