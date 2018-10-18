# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get     'projects/:project_id/networks',            to: 'networks#index',   as: 'networks'
get     'projects/:project_id/networks/new',        to: 'networks#new',     as: 'new_network'
post    'projects/:project_id/networks',            to: 'networks#create'
get     'projects/:project_id/networks/:id',        to: 'networks#show',    as: 'network'
get     'projects/:project_id/networks/:id/edit',   to: 'networks#edit',    as: 'edit_network'
delete  'projects/:project_id/networks/:id',        to: 'networks#destroy', as: 'destroy_network'
match   'projects/:project_id/networks/:id',        to: 'networks#update',  via: [:put, :patch]
get     'projects/:project_id/networks/:id/scan',   to: 'networks#scan'

get     'projects/:project_id/hosts/:id/scan',      to: 'hosts#scan'
