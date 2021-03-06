package "yum-s3-iam" do
  version node['yum_s3_iam']['version']
end

if node['yum_s3_iam']['repo_default']
	template File.join('/', 'etc', 'yum.repos.d', "#{node['yum_s3_iam']['repo_name']}.repo") do
		owner 'root'
		group 'root'
		mode '0644'
		source 's3-iam.repo.erb'
		variables :repo_name => node['yum_s3_iam']['repo_name'],
		:repo_description => node['yum_s3_iam']['repo_description'],
		:repo_bucket => node['yum_s3_iam']['repo_bucket']
	end
end

node['yum_s3_iam']['repositories'].each do |repo_name,config|
	template File.join('/', 'etc', 'yum.repos.d', "#{repo_name}.repo") do
		owner 'root'
		group 'root'
		mode '0644'
		source 's3-iam.repo.erb'
		variables :repo_name => repo_name,
		:repo_description => config['repo_description'],
		:repo_bucket => config['repo_bucket']
	end
end
