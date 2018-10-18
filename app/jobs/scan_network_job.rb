class ScanNetworkJob
  include SuckerPunch::Job

  def perform(network)
    network.last_scan = DateTime.now
    network.save!
    network.hosts.each do |h|
      h.scan
    end
  end
end
