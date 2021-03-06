# Description

You can create an Ensembl browser site with your own species and use your own database.

Custom site requires you to build your own browser image using our pre built web libs images as base. 

For custom sites, Ensembl recommends using ensembl-web-libs-03 image from DockerHub as your base image rather than building web libs from scratch.

But if you have a use case to build them from scratch, we would be interested to hear about it. 


## Customisation

The Ensembl webcode is designed to be extensible using plugins mechanism so that you can customize your own installation. 

Plugins are used to complement the normal system of inheritance in object-oriented Perl. Whereas a child object can inherit methods from multiple parents, a parent object normally cannot be overridden by multiple children. The plugin system "aggregates" the contents of several methods into one "master" method that can then be used by mod_perl when rendering the webpage.

The module conf/Plugins.pm controls which plugins are used by an instance of Ensembl and their order of precedence. In a standard Ensembl docker site, the module will define a plugin array as follows:

```
$SiteDefs::ENSEMBL_PLUGINS = [
‘EnsEMBL::Docker’     => $SiteDefs::ENSEMBL_SERVERROOT.‘/public-plugins/docker’,
‘EnsEMBL::Linuxbrew’  => $SiteDefs::ENSEMBL_SERVERROOT.‘/public-plugins/linuxbrew’,
‘EnsEMBL::Widgets’    => $SiteDefs::ENSEMBL_SERVERROOT.‘/public-plugins/widgets’,
‘EnsEMBL::Genoverse’  => $SiteDefs::ENSEMBL_SERVERROOT.‘/public-plugins/genoverse’,
‘EnsEMBL::Ensembl’    => $SiteDefs::ENSEMBL_SERVERROOT.‘/public-plugins/ensembl’,
‘EnsEMBL::Docs’       => $SiteDefs::ENSEMBL_SERVERROOT.‘/public-plugins/docs’
];
```

The plugins are processed in reverse order, starting with the last one.

By creating your own plugin, you can completely change the available species, alter the colour scheme or page template, or add your own views and static content, or use your own databases. 
 
 ## Customisation involves following steps
 
 - Prepare your plugin using the above custom-* plugins as example or edit and adapt them accoording to your need
 - Edit dockerfile to add your plugin to image's filesystem. Here is an [example](https://github.com/Ensembl/ensembl-web-docker/blob/869d9f280815f52c548be6aa672f169b1d71014a/ensembl-browser/Dockerfile#L17) how to add your plugin to image's filesystem.
 - Make sure you edit your Plugins.pm to define your custom-plugin as the first element in the array
   - To override default configuration with configurations from your plugin, you need to define your plugin as the first element in the above array. For example, if you happen to use/adapt “custom-species” plugin in this directory for your custom site, you array would look like in [Plugins.pm](https://github.com/Ensembl/ensembl-web-docker/blob/master/ensembl-browser/custom-plugin-examples/custom-species/conf/Plugins.pm)
- Your Plugin.pm from the custom-plugin directory which you added to image's filesystem would then need to be copied to default location in ensembl-webcode for it to get picked up. Here is an [example](https://github.com/Ensembl/ensembl-web-docker/blob/f9481c04f2dda5f2d79fafbed54ace42cc8feaaa/ensembl-browser/create-ensembl-site.sh#L76)
- Build your image with required build time parameters as described [here](https://github.com/Ensembl/ensembl-web-docker/tree/master/ensembl-browser)
- Run your image. Example ```docker run <your_image_name>``` 
  - Or if required, create a custom network and add sessions database container along with your container to it as described [here](https://github.com/Ensembl/ensembl-web-docker).
