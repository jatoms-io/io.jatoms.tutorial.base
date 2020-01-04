FROM gitpod/workspace-full
                    
USER gitpod

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && #     sudo apt-get install -yq bastet && #     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/42_config_docker/

# Download Maven completion for bash and add some aliases
# TODO: Maybe enhance to also offer auto-completion for enroute Maven plugins
RUN wget -O .mvn_bash_completion https://raw.githubusercontent.com/natros/maven-bash-completion/master/bash_completion.bash \
&& echo 'alias osgi_project="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=project -DarchetypeVersion=7.0.0"' >> ~/.bashrc \
&& echo 'alias osgi_api="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=api -DarchetypeVersion=7.0.0"' >> ~/.bashrc \
&& echo 'alias osgi_rest="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=rest-component -DarchetypeVersion=7.0.0"' >> ~/.bashrc \
&& echo 'alias osgi_test="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=bundle-test -DarchetypeVersion=7.0.0"' >> ~/.bashrc \
&& echo 'alias osgi_ds="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=ds-component -DarchetypeVersion=7.0.0"' >> ~/.bashrc \
&& echo 'alias osgi_app="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=application -DarchetypeVersion=7.0.0"' >> ~/.bashrc \
&& echo 'alias osgi_projectbare="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=project-bare -DarchetypeVersion=7.0.0"' >> ~/.bashrc \
&& echo 'alias java_run="java -jar "' >> ~/.bashrc \
&& echo 'alias java_debug="java -jar -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=y "' >> ~/.bashrc \
&& echo 'osgi_resolve(){ mvn -pl "$1" -am bnd-indexer:index bnd-indexer:index@test-index bnd-resolver:resolve; }' >> ~/.bashrc \
&& echo 'source ~/.mvn_bash_completion' >> ~/.bashrc \

# Give back control

USER root