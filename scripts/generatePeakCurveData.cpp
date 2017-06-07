#include <cstdio>
#include <cstring>
#include <cctype>
#include <cstdlib>
#include <cassert>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>
#include <regex>
#include <algorithm>
using namespace std;

class Genome {
public:
	Genome(const char* file, const char* motif, int w) {
		this->w = w;
		context.resize(2 * w + 1);
		this->motif = motif;

		chr = seq = ""; len = 0;

		string line;
		fin.open(file);
		while (getline(fin, line) && line[0] != '>');
		assert(line[0] == '>');
		chr_name = line.substr(1, line.find_first_of(' ') - 1);
	}

	~Genome() { fin.close(); }

	void seek(const string& chr) {
		string line;

		assert(this->chr != chr);

		seq = "";
		while (fin.good() && this->chr != chr) {
			this->chr = chr_name;
			while (getline(fin, line) && line[0] != '>') {
				assert(!isspace(line[0]) && line[0] != '#' && !isspace(line[line.length() - 1]));
				if (this->chr == chr) {
					int llen = line.length();
					for (int i = 0; i < llen; ++i) line[i] = toupper(line[i]);
					seq += line;
				}
			}
			if (fin.good() && line[0] == '>') {
				chr_name = line.substr(1, line.find_first_of(' ') - 1);
			}
		}
		
		len = seq.length();
		assert(len > 0);
	}

	bool containMotif(const string& chr, char ori, int pos) {
		if (this->chr != chr) seek(chr);
		
		int center, start, end;
		char c;

		center = pos;
		start = center - w;
		end = center + w;
		for (int i = start; i <= end; ++i) {
			c = (i >= 0 && i < len) ? seq[i] : 'N';
			if (ori == '+') context[i - start] = c;
			else context[end - i] = complement(c);
		}
		
		return regex_search(context, m, motif);
	}

private:
	string context;
	regex motif;
	smatch m;
	int w;

	int len;
	ifstream fin;
	string chr, chr_name, seq;

	char complement(char c) { 
		switch(c) { 
		case 'A': return 'T';
		case 'C': return 'G';
		case 'G': return 'C';
		case 'T': return 'A';
		}
		return 'N';
	}
};

struct Peak {
	double pvalue;
	bool hasMotif;

	Peak(double pvalue, bool hasMotif) : pvalue(pvalue), hasMotif(hasMotif) {}

	bool operator< (const Peak& o) const {
		return pvalue < o.pvalue;
	}
};

int w;
vector<Peak> peaks;

int main(int argc, char* argv[]) {
	if (argc != 6) {
		printf("Usage: generatePeakCurveData reference.fa motif(regex) w bed_file output_file\n");
		exit(-1);
	}

	string line, chr;
	int start, end, pos;
	char ori;
	double pvalue;

	Genome *genome = new Genome(argv[1], argv[2], atoi(argv[3]));

	ifstream fin(argv[4]);

	peaks.clear();
	while (getline(fin, line)) {
		istringstream strin(line);
		strin>> chr>> ori>> start>> end>> pvalue;
		pos = (start + end) / 2;

		peaks.push_back(Peak(pvalue, genome->containMotif(chr, ori, pos)));
	}
	fin.close();

	delete genome;

	printf("Extracting Motif is done.\n");

	sort(peaks.begin(), peaks.end());
	
	double cpvalue, nhit, ntot;

	FILE *fo = fopen(argv[5], "w");
	cpvalue = peaks[0].pvalue; nhit = double(peaks[0].hasMotif); ntot = 1.0;
	for (int i = 1; i < (int)peaks.size(); ++i) {
		if (cpvalue < peaks[i].pvalue) {
			fprintf(fo, "%d\t%.6g\t%.6g\n", (int)ntot, nhit / ntot, cpvalue);
			cpvalue = peaks[i].pvalue;
		}
		nhit += double(peaks[i].hasMotif);
		++ntot;
	}
	fprintf(fo, "%d\t%.6g\t%.6g\n", (int)ntot, nhit / ntot, cpvalue);
	fclose(fo);
	printf("Curve data are generated.\n");

	return 0;
}
