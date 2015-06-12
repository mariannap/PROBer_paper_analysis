.PHONY : clean

clean:
	rm -rf *~ .snakemake 
	cd tools ; $(MAKE) clean
	cd annotation ; $(MAKE) clean
	cd data ; $(MAKE) clean
	cd references ; $(MAKE) clean
	cd results ; $(MAKE) clean
	cd simulation_parameters ; $(MAKE) clean
	cd exp ; $(MAKE) clean

