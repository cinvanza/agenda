class ContactsController < ApplicationController
  def index
    @contacts = current_user.contacts
    if params[:query].present?
      sql_subquery = <<~SQL
        contacts.full_name ILIKE :query
        OR contacts.nickname ILIKE :query
        OR contacts.contact_email ILIKE :query
      SQL
      @contacts = @contacts.where(sql_subquery, query: "%#{params[:query]}%")
    end

    # Generar los marcadores solo para los contactos con direcciones geocodificadas
    @markers = @contacts.joins(:addresses).merge(Address.geocoded).map do |contact|
      {
        lat: contact.addresses.first.latitude,
        lng: contact.addresses.first.longitude
      }
    end
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
    @contact.phone_numbers.build
    @contact.addresses.build
    redirect_to contact_path(@contact) if @contact.nil?
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      redirect_to root_path, notice: 'su contacto ha sido agregado!'
    else
      render :new
    end
  end

  def edit
    @contact = Contact.find(params[:id]) if @contact.nil?
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

  end

  private

  def contact_params
    params.require(:contact).permit(:full_name, :nickname, :email, :birthday,
      phone_numbers_attributes: [:id, :number, :kind, :_destroy],
      address_attributes: [:id, :street, :city, :state, :country, :postal_code, :_destroy])
  end
end
