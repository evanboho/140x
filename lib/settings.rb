module Settings

  def self.service(service)
    yaml = YAML::load(File.open(Rails.root.join("config/variables", "#{service}.yml")))
  end

  def self.service_field(service, field)
    service(service)[field]
  end

end
