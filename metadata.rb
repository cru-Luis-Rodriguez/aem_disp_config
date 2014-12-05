name             'aem_disp_config'
maintainer       'cru'
maintainer_email 'luis.rodriguez@cru.org'
maintainer_email 'luis.rodriguez'
license          'All rights reserved'
description      'Installs/Configures aem_disp_config'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.1.0'
version          '0.1.2'

depends "apache2", "3.0.0"
