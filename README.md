[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/jatoms-io/io.jatoms.tutorial.base) 

# io.jatoms.tutorial.base
This repository contains all prerequisites needed to start a new tutorial workspace for OSGi development in GitPod

The Gitpod button above needs to be adapted to point to your repository. 
For this just change the URL behind `https://gitpod.io/#` to the URL of your repository.

**Aliases**
This workspace contains some aliases that should save you some time when creating new OSGi applications or add new modules.
Those aliases are defined in the `.gitpod.Dockerfile`. If you want your own aliases feel free to change them.

The aliases are: 
* **osgi_project** which executes the following maven command: `mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=project -DarchetypeVersion=7.0.0`
    * This creates a multi module maven project.
    * The reference implementations of the most commonly used OSGi specs are already added to the parent POMs `dependencyManagement` section, as well as the repositories that are needed to find them 
    * The bnd-maven plugins needed to create indices for the OSGi resolver, as well as to generate necessary metadata for the submodule's MANIFEST files are also added, as well as the repsective repositories 
    * Two submodules are created:
        * app: a modues that is used to collect general configuration and other stuff for your application, e.g., bndrun files that describe which bundles are initially needed for your application to work, and which the resolver takes to compute the dependencies needed for your application
        * impl: a module that contains your first OSGi Declarative Service 
* **osgi_projectbare** which executes the following maven command: `mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=project-bare -DarchetypeVersion=7.0.0`
    * This archetype behaves like the osgi_project archetype, but does not generate any subproject, so you have to add an application submodule and an implementation submodule by yourself.
* **osgi_api** which executes the following maven command: `mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=api -DarchetypeVersion=7.0.0`
    * If executed within a multimodule project this archetype adds an API module with all OSGi dependencies needed. It also modifies the parent POM to include this new submodule
    * It also includes already a first example of two interfaces, i.e., a provider and a consumer interface:
    ```java
    @ConsumerType
    public interface ConsumerInterface {
        
        //TODO add an API
        
    }

    @ProviderType
    public interface ProviderInterface {
        
        //TODO add an API
        
    }
    ```
* **osgi_rest** which executes the following maven command: `mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=rest-component -DarchetypeVersion=7.0.0`
    * If executed withing a multimodule project this archetype adds a submodule with all necessary dependencies to define a JAX-RS REST endpoint via a Declarative Service Component.
    * It also includes already a first example of such a REST endpoint:
    ```java
    @Component(service=RestComponentImpl.class)
    @JaxrsResource
    public class RestComponentImpl {
        
        //TODO add an implementation
        
        @Path("rest")
        @GET
        public String toUpper() {
            return "Hello World!";
        }
        
    }
    ```
* **osgi_test** which executes the following maven command: `mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=bundle-test -DarchetypeVersion=7.0.0`
    * If executed withing a multimodule project this archetype adds a submodule with all necessary dependencies to define unit and integration tests.
    * It also adds a bndrun file that can be used to define what other bundles are needed to run an integration test 
    * It also creates a first test class for you:
    ```java
    /**
     * This is a JUnit test that will be run inside an OSGi framework.
    * 
    * It can interact with the framework by starting or stopping bundles,
    * getting or registering services, or in other ways, and then observing
    * the result on the bundle(s) being tested.
    */
    public class EnrouteBundleTest {
        
        private final Bundle bundle = FrameworkUtil.getBundle(this.getClass());
        
        @Before
        public void setUp() throws Exception {
            assertNotNull("OSGi Bundle tests must be run inside an OSGi framework", bundle);
        }
        
        @After
        public void tearDown() throws Exception {
            // TODO clean up any changes made
        }
        
        @Test
        public void testOSGiBundle() throws Exception {
            // TODO look at the bundle under test
        }
    }
    ```
* **osgi_ds** which executes the following maven command: `mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=ds-component -DarchetypeVersion=7.0.0`
    * This archetype generates a submodule similar to the "impl" submodule of the osgi_project archetype 
    * It contains all depndencies necessary to create new Declarative Service Components
    * It also contains already an empty DS Component to start with: 
    ```java
    @Component
    public class ComponentImpl {
        
        //TODO add an implementation
        
    }
    ```
* **osgi_app** which executes the following maven command: `mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=application -DarchetypeVersion=7.0.0`
    * This archetype generates a submodule similar to the "app" submodule of the osgi_project archetype 
    * It generates two bndrun files, one for the appliation and one for debugging the application 
    * During the archetype generation you are asked for the name of the implementation this application references. Here you can insert another existing submodule you want to be the implementation 
* **osgi_resolve $1** which executes the following maven command: `mvn -pl "$1" -am bnd-indexer:index bnd-indexer:index@test-index bnd-resolver:resolve`
    * This command does not generate any projects or modules, but indexes and resolves an application. Resolving means, you provide the bnd-resolver-plugin with a set of bundles you want to run and the plugin calculates what libraries you need to do so.
* **run** which executes the following command: `java -jar `  
    * This is just an alias for starting a jar that is created by maven so that you can see your application in action
    * You still need to append the jar you want to run, e.g., `run app/target/app.jar`
* **debug** which executes the following command: `java -jar -Xdebug -Xrunjdwp:transport=dt_socket,address=5858,server=y,suspend=y `
    * This starts the JVM in debug mode so that you are able to attach a debugger to debug your application. As you have no main method present in your code (It's hidden in the OSGi runtime) you need to start the application jar and then attach a debugger instead of GitPod doing this for you automatically when starting a main method.
    * This workspace comes with a predefined debug configuration that tries to attach to the same port as defined by this command.