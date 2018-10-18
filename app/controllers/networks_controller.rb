class NetworksController < ApplicationController
  before_filter :find_project
  before_filter :find_network, :except => [:index, :new, :create]
  before_filter :authorize

  def index
    @limit = per_page_option
    scope = Network.all
    scope = scope.like(params[:ip_address]) if params[:ip_address].present?
    @network_count = scope.count
    @network_pages = Paginator.new @network_count, @limit, params['page']
    @offset ||= @network_pages.offset
    @networks = scope.limit(@limit).offset(@offset).to_a
  end

  def new
    @network = Network.new
  end

  def create
    @network = Network.new(network_params)
    begin
      ActiveRecord::Base.transaction do
        @network.project = @project
        @network.author = User.current
        @network.save!
        ip = IPAddress([@network.ip_address, @network.mask].join('/'))
        Thread.new do
          ip.each_host do |h|
            host = Host.new(:ip_address => h, :network => @network)
            host.save!
          end
        end
        flash[:notice] = l(:created)
        redirect_to networks_path(@project)
      end
    rescue => e 
      flash[:error] = e.to_s
      render :new
    end
  end

  def edit
  end

  def update
    begin
      @network.update_attributes!(network_params)
      flash[:notice] = l(:updated)
      redirect_to networks_path(@project)
    rescue
      flash[:error] = l(:error)
      render :edit
    end
  end

  def destroy
    begin
      flash[:notice] = l(:deleted)
      @network.destroy!
      redirect_to networks_path(@project)
    rescue
      flash[:notice] = l(:error)
      redirect_to networks_path(@project)
    end
  end

  def scan
    ScanNetworkJob.perform_async(@network)
    flash[:notice] = l(:scan_requested)
    redirect_to network_path
  end

  def show
    @limit = per_page_option
    scope = Host.where(:network => @network)
    scope = scope.like(params[:ip_address]) if params[:ip_address].present?
    scope = scope.where(:status => params[:status]) if params[:status].present?
    @host_count = scope.count
    @host_pages = Paginator.new @host_count, @limit, params['page']
    @offset ||= @host_pages.offset
    @hosts = scope.limit(@limit).offset(@offset).to_a
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_network
    @network = Network.find(params[:id])
  end

  def network_params
    params.require(:network).permit(:id, :ip_address, :mask, :description)
  end
end
