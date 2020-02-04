# VIVO project template
This is a git repository template for working with and customizing [VIVO](http://vivoweb.org/).  It uses the [three tiered build approach](https://wiki.lyrasis.org/display/VTDA/Building+VIVO+in+3+tiers) documented by the VIVO project.  The project source files (VIVO and Vitro) are tracked using [Git Submodules](http://git-scm.com/book/en/Git-Tools-Submodules).

For a more detailed explanation of setting up the VIVO environment, consult the installation instructions for [v1.11.x](https://wiki.lyrasis.org/display/VIVODOC111x/Installing+VIVO). Some additional configuration options are explained in the [System Administration](https://wiki.lyrasis.org/display/VIVODOC111x/System+Administration) section of the wiki.

VIVO uses [Maven](https://maven.apache.org/) for its build tool. Follow the directions below for building your custom VIVO project with Maven. 

## Checking out the project and building VIVO in three tiers

### VIVO 1.9 and later
1. Clone this template 
    ~~~
    git clone https://github.com/lawlesst/vivo-project-template.git vivo
    cd vivo
    git submodule init
    ~~~
2. Pull in VIVO and Vitro.  This will take a few minutes.  
	~~~
	git submodule update
	~~~
3. Check out specific versions of VIVO and Vitro by branch or tag name
    ~~~
    cd VIVO
    git checkout vivo-1.11.0
    cd ../Vitro
    git checkout vitro-1.11.0
    ~~~
4. Change back to vivo main directory  
    ~~~
    cd ../VIVO
	~~~
5. Copy default-settings.xml  
	~~~
    cp custom-vivo/default-settings.xml custom-vivo/custom-settings.xml
    ~~~

6. Using a text editor, change the settings for the VIVO home directory, Tomcat location, and theme to match your environment. 

7. Build and deploy  
	~~~
    mvn install -s custom-vivo/custom-settings.xml
    ~~~

If you are installing VIVO v1.9.x or 1.10.x, you are finished. For later versions, you must install and configure Solr. See the [v1.11 installation instructions](https://wiki.lyrasis.org/display/VIVODOC111x/Installing+VIVO#InstallingVIVO-ConfigureandStartSolr) for additional details. 

### VIVO 1.8 and earlier
Prior to December 2015, VIVO used ant to build the project. 

1. Clone this template and revert to an ant-compatible template using git checkout
    ~~~
    git clone https://github.com/lawlesst/vivo-project-template.git vivo
    cd vivo
    git checkout 2e02f3cc10e7fc7583b3273b4128dcfe6d43fc10
    git submodule init
    ~~~

2. Pull in VIVO and Vitro.  This will take a few minutes.
	~~~
    git submodule update
    ~~~
3. Check out specific versions of VIVO and Vitro
    ~~~
    cd VIVO
    git checkout maint-rel-1.8
    cd ../Vitro
    git checkout maint-rel-1.8
    ~~~
4. Change back to vivo main directory
    ~~~
    cd ..
    ~~~
5. Copy default build.properties, runtime.properties, and applicationSetup.n3
    ~~~
    cp example.build.properties build.properties
    cp example.runtime.properties runtime.properties
    cp config/example.applicationSetup.n3 config/applicationSetup.n3
    ~~~
6. Adjust build, runtime, and applicationSetup properties
7. Create the vivo data directory specified in build.properties if it doesn't exist. Eg:
    ~~~
    mkdir -p /usr/local/vivo/data/config
    cp runtime.properties /usr/local/vivo/data
    cp config/applicationSetup.n3 /usr/local/vivo/data/config
    ~~~
8. Build and deploy VIVO
    ~~~
    ant all
    ~~~


## Benefits to this approach
 * local changes are separated from core code making upgrades easier.
 * using Git you can checkout any tagged release, build it with your local changes, and test it out.
 * using the steps above, you can quickly deploy VIVO to another machine.
 * you can use Git features, like [cherry-pick](http://www.vogella.com/articles/Git/article.html#cherrypick), to select bug fixes or enhancements that are not yet in a VIVO release and incorporate them into your implementation.
 * even if you plan on making few modifications, this can be a convenient and efficient way to manage your custom theme.

## Questions or comments
[Open an issue](https://github.com/vivo-community/vivo-project-template/issues) via the issue tracker.
