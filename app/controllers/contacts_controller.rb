class ContactsController < ApplicationController
  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
    @contact.phone_numbers.build
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to root_path, notice: 'su contacto ha sido agregado!'
    else
      render :new
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to contact_path(@contact), notice: 'su contacto ha sido actualizado!'
    else
      render :edit
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to root_path, notice: 'su contacto ha sido eliminado!'
  end

  def search
    @contacts = Contact.all
    if params[:query].present?
      sql_subquery = <<~SQL
        contacts.full_name ILIKE :query
        OR contacts.nickname ILIKE :query
        OR contacts.email ILIKE :query
      SQL
      @contacts = @contacts.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:full_name, :nickname, :email, :birthday,
      phone_numbers_attributes: [:id, :number, :_destroy] )
end
