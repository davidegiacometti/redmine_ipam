class HostsController < ApplicationController
  before_filter :find_project
  before_filter :authorize

  respond_to 'js'

  def scan
    @host = Host.find(params[:id])
    begin
      @host.scan
    rescue => e
      render :nothing => true, :status => 500, :content_type => 'text/html'
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
end
