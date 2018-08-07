require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( 'models/pizza_order.rb' )
also_reload( 'models/*' )


#INDEX ROUTE
#think of this as the home page.
#Layout erb has a link for a new order or a link back here
get '/pizza-orders' do
  @orders = PizzaOrder.all()
  erb(:index)
end


#NEW ROUTE (has to go above SHOW route so it doesn't recall an :id)
#we get here via a link on the navbar from layout.erb
get '/pizza-orders/new' do
  erb(:new)
end


#SHOW ROUTE
#We get here from clicking 'show order' in the index/homepage.
get '/pizza-orders/:id' do
  @order = PizzaOrder.find(params[:id])
  erb(:show)
end

#CREATE ROUTE
#We get here from the new erb post form, which returns params.
#Shows the order successful splash screen.
post '/pizza-orders' do
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

#EDIT
#edit is accessed via a href button on the show.erb.
get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find(params[:id])
  erb(:edit)
end

#UPDATE - we are redirected here from the erb(:edit) above.
#We create a new order with the params passed from the Edit form.
#Once updated we go back to the SHOW (get) route.
post '/pizza-orders/:id' do
  order = PizzaOrder.new(params)
  order.update()
  redirect "/pizza-orders/#{order.id}"
end


#DELETE
post '/pizza-orders/:id/delete' do
@order = PizzaOrder.find(params[:id])
@order.delete()
redirect '/pizza-orders'
end
