class Admin::ProductsController < Admin::Base
  def index
  end

  def new
    @artists = Artist.all
    @genres = Genre.all
    @labels = Label.all

    @product = Product.new
    @product.discs.new
    @product.discs.first.track_relations.new
    @song = Song.new
  end

  def create
    # p '-------'
    # p song_params
    # p '-------'
    # song = Product.new(product_params)
    product = Product.new(product_params)

    # if song.save!
      if product.save!
        redirect_to admin_products_path
      else
        redirect_to new_admin_product_path
      end
    # end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def product_params
    params.require(:product).permit(
      :id, :name, :image, :product_type, :label_id, :genre_id, :price, :release_date,
      discs_attributes: [
        :id, :disc_order, :_destroy,
        track_relations_attributes: [
          :id, :song_id, :artist_id, :disk_id, :track_order,  :_destroy,
          songs_attributes: [
            :id, :name, :file, :file_cache, :remove_file
          ]
        ]
      ]
    )
  end

  # def song_params
  #   params.require(:song).permit(
  #     :id, :name, :file, :file_cache, :remove_file
  #   )
  # end
end
