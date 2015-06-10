.PHONY : clean

clean:
	rm -rf builds *~ .snakemake 
	cd tools ; $(MAKE) clean
	cd annotation ; $(MAKE) clean
