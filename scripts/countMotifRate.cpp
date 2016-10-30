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

int w;

int main(int argc, char* argv[]) {
	if (argc != 5) {
		printf("Usage: countMotifRate reference.fa motif(regex) w bed_file\n");
		exit(-1);
	}

	string line, chr;
	int start, end, pos;
	char ori;

	Genome *genome = new Genome(argv[1], argv[2], atoi(argv[3]));

	ifstream fin(argv[4]);

	int nhit = 0, tot = 0;
	while (getline(fin, line)) {
		istringstream strin(line);
		strin>> chr>> ori>> start>> end;
		pos = (start + end) / 2;
		if (genome->containMotif(chr, ori, pos)) ++nhit;
		++tot;
	}
	fin.close();

	delete genome;

	printf("\t%d\t%d\t%.2f%%\n", tot, nhit, nhit * 100.0 / tot);
	// printf("nhit = %d, tot = %d, rate = %.2f%%\n", nhit, tot, nhit * 100.0 / tot);

	return 0;
}
