size = node['dna'][:environment][:instance_size] || ec2_instance_size
default['collectd'] = (default_collectd(size))
meminfo = Mixlib::ShellOut.new("cat /proc/meminfo").run_command.stdout
default['swap_total_bytes'] = meminfo.scan(/^SwapTotal:\s+(\d+)\skB$/).flatten.first.to_i * 1024
default['swap_warn_threshold'] = "0.50"
default['swap_crit_threshold'] = "0.70"
default['swap_warning_total'] = node['swap_total_bytes'] * node['swap_warn_threshold'].to_f
default['swap_critical_total'] = node['swap_total_bytes'] * node['swap_crit_threshold'].to_f

default['collectd']['version'] = "5.4.1-r3"
