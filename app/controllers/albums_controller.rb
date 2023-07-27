class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ]

  # GET /albums or /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1 or /albums/1.json
  def show
    @album = Album.find(params[:id])
    @photos = @album.photos
  end

  # GET /albums/new
  def new
    @album = Album.new
   
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums or /albums.json
  def create
    @album = Album.new(album_params)
  
    if @album.save
      # Xử lý các tệp đã chọn và thêm chúng vào album
      selected_files.each do |file|
        @album.photos.create(image: file) 
      end
  
      redirect_to @album, notice: 'Album was successfully created.'
    else
      render :new
    end
  end





  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    @album = Album.find(params[:id])

    @album.update(album_params)
    if @album.save
      selected_files.each do |file|
        @album.photos.create(image: file) 
      end
      redirect_to @album, notice: 'Album was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url, notice: "Album was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:title)
      
    end

    def save_images_to_album
      if params[:album][:photo_images].present?
        params[:album][:photo_images].each do |image|
          @album.photos.create(image: image)
        end
      end
    end

    def selected_files
      files = params[:album][:photo_images]
      return [] unless files
    
      valid_files = []
      files.each do |file|
        valid_files << file if file.is_a?(ActionDispatch::Http::UploadedFile) && file.content_type.start_with?('image/')
      end
      valid_files
    end
end
