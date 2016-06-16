.PHONY : clean

clean:
	rm -rf *~ .snakemake 
	cd tools ; $(MAKE) clean
	cd ground_truth ; $(MAKE) clean
	cd references ; $(MAKE) clean
	cd data ; $(MAKE) clean
	cd simulation ; $(MAKE) clean
	cd exp ; $(MAKE) clean
	cd results ; $(MAKE) clean
