def resp_json(name)
  current_dir = File.expand_path(File.dirname((__FILE__)))
  IO.read(File.join(current_dir, "..", "fixtures", "resp_#{name}.json"))
end
