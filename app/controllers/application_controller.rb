class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

  delete '/reviews/:id' do
    # find the review using the ID
    # delete the review
    # send a response with the deleted review as JSON
  rev= Review.find(params[:id])
  rev.destroy
  rev.to_json
  end

  post '/reviews' do
    # find the review using the ID
    # delete the review
    # send a response with the deleted review as JSON
  rev= Review.create(
    score: params[:score],
    comment: params[:comment],
    game_id: params[:game_id],
    user_id: params[:user_id]
  )
  rev.to_json
  end

  patch '/reviews/:id' do
    # find the review using the ID
    # delete the review
    # send a response with the deleted review as JSON
  rev= Review.find(params[:id])
  rev.update(
    score: params[:score],
    comment: params[:comment]
  )
  rev.to_json
  end
end
