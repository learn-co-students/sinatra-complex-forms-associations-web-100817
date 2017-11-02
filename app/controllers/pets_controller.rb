class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new(params[:pet])
    @pet.save
    if !params[:owner_name].empty?
      owner = Owner.new(name: params[:owner_name])
      owner.save
      owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    # binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params[:owner].empty?
      owner = Owner.new(params[:owner])
      owner.save
      owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end
end
