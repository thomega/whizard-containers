USER = thomega

all: whizard trunk tools build_env

trunk: whizard-trunk.stamp
whizard: whizard-2.2.6.stamp
tools: whizard_tools.stamp
build_env: whizard_build_env.stamp

%.stamp: %/Dockerfile
	docker build -t "$(USER)/$*" $*/
	touch $@

%/Dockerfile: %/Dockerfile.m4 macros.m4
	m4 macros.m4 $< > $@

whizard-trunk.stamp: whizard_tools.stamp whizard_build_env.stamp
whizard-2.2.6.stamp: whizard_tools.stamp whizard_build_env.stamp
whizard_tools.stamp: whizard_build_env.stamp

whizard_build_env.stamp: whizard_build_env/wgetx

push:
	docker push thomega/whizard_build_env
	docker push thomega/whizard_tools
	docker push thomega/whizard-2.2.6
	docker push thomega/whizard-trunk

clean:
	rm -f whizard_tools/Dockerfile whizard-*/Dockerfile \
		*.stamp *~ */*~

realclean: clean
	docker rm `docker ps -aq`
	docker rmi `docker images -q`