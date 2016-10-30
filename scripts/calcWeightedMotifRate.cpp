#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <cassert>
#include <fstream>
#include <sstream>
#include <string>
using namespace std;

int w;

ifstream fm, fr;
istringstream strin;
string line, chr;
char ori;
int pos, nuniq;
double nmulti;

string tchr;
char tori;
int tpos, motif_pos;

double numerator, denominator;

int main(int argc, char* argv[]) {
	if (argc != 4) {
		printf("Usage: calcWeightedMotifRate w input.motifs input.site_info\n");
		exit(-1);
	}

	w = atoi(argv[1]);

	fm.open(argv[2]);
	fr.open(argv[3]);

	int cnt = 0;
	numerator = denominator = 0.0;
	while (getline(fr, line)) {
		strin.clear(); strin.str(line);
		strin>> chr>> ori>> pos>> nuniq>> nmulti;

		getline(fm, line);
		strin.clear(); strin.str(line);
		strin>> tchr>> tori>> tpos>> motif_pos;
		assert(tchr == chr && tori == ori && tpos == pos);

		if (nmulti > 0.0) {
			numerator += nmulti * (abs(motif_pos) <= w);
			denominator += nmulti;
		}

		++cnt;
		if (cnt % 1000000 == 0) fprintf(stderr, "FIN %d\n", cnt);
	}

	fm.close();
	fr.close();

	printf("%.2f%%\t%.2f\t%.2f\n", numerator * 100.0 / denominator, numerator, denominator);
	
	return 0;
}
