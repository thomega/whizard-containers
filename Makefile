USER = thomega

all: whizard tools build_env

whizard: whizard.stamp
tools: whizard_tools.stamp
build_env: whizard_build_env.stamp

%.stamp: %/Dockerfile
	docker build -t "$(USER)/$*" $*/
	touch $@

whizard.stamp: whizard_tools.stamp whizard_build_env.stamp
whizard_tools.stamp: whizard_build_env.stamp

whizard_build_env.stamp: whizard_build_env/wgetx

clean:
	rm -f *.stamp *~ */*~
