.PHONY : clean

clean:
	rm -rf *~ .snakemake 
	cd tools ; $(MAKE) clean
	cd annotation ; $(MAKE) clean
